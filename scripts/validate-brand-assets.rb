# frozen_string_literal: true

require "pathname"
require "rexml/document"
require "zlib"

ROOT = Pathname.new(File.expand_path("..", __dir__)).freeze
ASSET_DIR = ROOT.join("brand", "bytefolk").freeze
SVG_NAMES = %w[symbol.svg symbol-reversed.svg lockup.svg].freeze
PROHIBITED_ELEMENTS = %w[filter foreignObject image linearGradient radialGradient script].freeze
CIRCULAR_SAFETY_MARGIN = 16.0
INK_THRESHOLD = 250

errors = []
circular_metrics = nil
geometry_signatures = {}

SVG_NAMES.each do |name|
  path = ASSET_DIR.join(name)
  unless path.file?
    errors << "#{path.relative_path_from(ROOT)}: missing"
    next
  end

  begin
    document = REXML::Document.new(path.read)
  rescue REXML::ParseException => e
    errors << "#{path.relative_path_from(ROOT)}: invalid XML: #{e.message.lines.first.strip}"
    next
  end

  root = document.root
  unless root&.name == "svg"
    errors << "#{path.relative_path_from(ROOT)}: root element must be svg"
    next
  end
  errors << "#{path.relative_path_from(ROOT)}: viewBox must be present" if root.attributes["viewBox"].to_s.empty?
  %w[width height].each do |attribute|
    errors << "#{path.relative_path_from(ROOT)}: root #{attribute} is prohibited" if root.attributes[attribute]
  end

  REXML::XPath.each(document, "//*") do |element|
    errors << "#{path.relative_path_from(ROOT)}: <#{element.name}> is prohibited" if PROHIBITED_ELEMENTS.include?(element.name)
    element.attributes.each_attribute do |attribute|
      value = attribute.value.to_s
      next if attribute.expanded_name == "xmlns" && value == "http://www.w3.org/2000/svg"

      if value.match?(/(?:https?:|data:|javascript:)/i)
        errors << "#{path.relative_path_from(ROOT)}: external or executable attribute is prohibited"
      end
    end
  end

  symbol_group = REXML::XPath.first(document, "//*[starts-with(@id, 'bytefolk-symbol')]")
  if symbol_group
    child_geometry = symbol_group.elements.map do |element|
      attributes = element.attributes.map { |key, value| [key, value] }.sort
      [element.name, attributes]
    end
    geometry_signatures[name] = [symbol_group.attributes["transform"].to_s, child_geometry]
  else
    errors << "#{path.relative_path_from(ROOT)}: ByteFolk symbol group is missing"
  end
end

if geometry_signatures.length == SVG_NAMES.length && geometry_signatures.values.uniq.length != 1
  errors << "ByteFolk primary, reversed, and lockup symbol geometry must remain identical"
end

png_path = ASSET_DIR.join("avatar-1024.png")
if !png_path.file?
  errors << "#{png_path.relative_path_from(ROOT)}: missing"
else
  bytes = png_path.binread
  signature = "\x89PNG\r\n\x1A\n".b
  if bytes.byteslice(0, 8) != signature
    errors << "#{png_path.relative_path_from(ROOT)}: invalid PNG signature"
  else
    offset = 8
    ihdr = nil
    idat = +"".b
    while offset + 12 <= bytes.bytesize
      length = bytes.byteslice(offset, 4).unpack1("N")
      type = bytes.byteslice(offset + 4, 4)
      data = bytes.byteslice(offset + 8, length)
      break unless data && offset + 12 + length <= bytes.bytesize

      ihdr = data if type == "IHDR"
      idat << data if type == "IDAT"
      offset += 12 + length
      break if type == "IEND"
    end

    if !ihdr || ihdr.bytesize != 13
      errors << "#{png_path.relative_path_from(ROOT)}: missing or invalid IHDR"
    else
      width, height, bit_depth, color_type, compression, filter_method, interlace = ihdr.unpack("NNCCCCC")
      errors << "#{png_path.relative_path_from(ROOT)}: expected 1024x1024, got #{width}x#{height}" unless width == 1024 && height == 1024
      errors << "#{png_path.relative_path_from(ROOT)}: expected 8-bit RGB without alpha" unless bit_depth == 8 && color_type == 2
      errors << "#{png_path.relative_path_from(ROOT)}: unsupported PNG encoding" unless compression.zero? && filter_method.zero? && interlace.zero?

      if errors.empty?
        raw = Zlib::Inflate.inflate(idat)
        stride = width * 3
        expected_size = height * (stride + 1)
        errors << "#{png_path.relative_path_from(ROOT)}: decompressed size mismatch" unless raw.bytesize == expected_size

        if raw.bytesize == expected_size
          prior = Array.new(stride, 0)
          pixels = []
          cursor = 0
          min_x = width
          min_y = height
          max_x = -1
          max_y = -1
          center_x = (width - 1) / 2.0
          center_y = (height - 1) / 2.0
          safe_radius = ([width, height].min / 2.0) - CIRCULAR_SAFETY_MARGIN
          max_ink_radius = 0.0
          outside_circle_ink = 0

          height.times do |y|
            filter = raw.getbyte(cursor)
            cursor += 1
            encoded = raw.byteslice(cursor, stride).bytes
            cursor += stride
            row = Array.new(stride, 0)

            encoded.each_index do |index|
              left = index >= 3 ? row[index - 3] : 0
              up = prior[index]
              upper_left = index >= 3 ? prior[index - 3] : 0
              value = case filter
                      when 0 then encoded[index]
                      when 1 then encoded[index] + left
                      when 2 then encoded[index] + up
                      when 3 then encoded[index] + ((left + up) / 2)
                      when 4
                        estimate = left + up - upper_left
                        distances = [(estimate - left).abs, (estimate - up).abs, (estimate - upper_left).abs]
                        encoded[index] + [left, up, upper_left][distances.index(distances.min)]
                      else
                        errors << "#{png_path.relative_path_from(ROOT)}: unsupported row filter #{filter}"
                        encoded[index]
                      end
              row[index] = value & 0xff
            end

            row.each_slice(3).with_index do |(red, green, blue), x|
              unless red == green && green == blue
                errors << "#{png_path.relative_path_from(ROOT)}: avatar must remain grayscale"
                break
              end
              next if red >= INK_THRESHOLD

              min_x = [min_x, x].min
              min_y = [min_y, y].min
              max_x = [max_x, x].max
              max_y = [max_y, y].max
              ink_radius = Math.hypot(x - center_x, y - center_y)
              max_ink_radius = [max_ink_radius, ink_radius].max
              outside_circle_ink += 1 if ink_radius > safe_radius
            end
            pixels.concat(row)
            prior = row
          end

          darkest = pixels.min
          errors << "#{png_path.relative_path_from(ROOT)}: primary ink is not #141414" unless darkest == 20
          margins = [min_x, min_y, width - 1 - max_x, height - 1 - max_y]
          if max_x.negative? || margins.any? { |margin| margin < 100 }
            errors << "#{png_path.relative_path_from(ROOT)}: insufficient rectangular padding #{margins.inspect}"
          end
          if outside_circle_ink.positive?
            errors << format(
              "%s: %d ink pixels outside centered circular safe area (center=%.1f,%.1f radius=%.1fpx; max=%.1fpx)",
              png_path.relative_path_from(ROOT),
              outside_circle_ink,
              center_x,
              center_y,
              safe_radius,
              max_ink_radius
            )
          else
            circular_metrics = format(
              "outside-circle ink=0; center=(%.1f,%.1f); safe radius=%.1fpx; max ink radius=%.1fpx",
              center_x,
              center_y,
              safe_radius,
              max_ink_radius
            )
          end
        end
      end
    end
  end
end

if errors.empty?
  puts "Validated #{SVG_NAMES.length} ByteFolk SVGs and one opaque 1024x1024 RGB avatar."
  puts "Circular crop: #{circular_metrics}."
else
  warn errors.join("\n")
  exit 1
end
