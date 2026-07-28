# frozen_string_literal: true

require "pathname"
require "uri"
require "yaml"

ROOT = Pathname.new(File.expand_path("..", __dir__)).freeze
ISSUE_TEMPLATE_DIR = ROOT.join(".github", "ISSUE_TEMPLATE").freeze
FORM_NAMES = %w[bug.yml docs.yml feature.yml maintenance.yml question.yml].freeze
CONFIG_NAME = "config.yml"
CONTROL_TYPES = %w[checkboxes dropdown input markdown textarea].freeze
YAML_PARSE_ERROR = Object.new.freeze

class Validator
  attr_reader :errors

  def initialize
    @errors = []
  end

  def error(path, message)
    display_path = Pathname.new(path).relative_path_from(ROOT)
    @errors << "#{display_path}: #{message}"
  end

  def nonempty_string?(value)
    value.is_a?(String) && !value.strip.empty?
  end

  def boolean?(value)
    value == true || value == false
  end
end

def load_yaml(path, validator)
  YAML.safe_load(
    path.read,
    permitted_classes: [],
    permitted_symbols: [],
    aliases: false
  )
rescue Psych::Exception => e
  validator.error(path, "invalid YAML: #{e.message.lines.first.strip}")
  YAML_PARSE_ERROR
end

def validate_string_list(value, path, field, validator)
  return if value.nil?

  unless value.is_a?(Array) && value.all? { |entry| validator.nonempty_string?(entry) }
    validator.error(path, "#{field} must be a list of non-empty strings")
  end
end

def validate_control(control, index, path, ids, validator)
  unless control.is_a?(Hash)
    validator.error(path, "body item #{index + 1} must be a mapping")
    return
  end

  type = control["type"]
  unless CONTROL_TYPES.include?(type)
    validator.error(path, "body item #{index + 1} has unsupported type #{type.inspect}")
    return
  end

  attributes = control["attributes"]
  unless attributes.is_a?(Hash)
    validator.error(path, "body item #{index + 1} must define attributes")
    return
  end

  if type == "markdown"
    unless validator.nonempty_string?(attributes["value"])
      validator.error(path, "markdown item #{index + 1} must have a non-empty attributes.value")
    end
    return
  end

  id = control["id"]
  unless validator.nonempty_string?(id) && id.match?(/\A[A-Za-z0-9_-]+\z/)
    validator.error(path, "body item #{index + 1} must have an id using letters, numbers, '-' or '_'")
  end
  if ids.include?(id)
    validator.error(path, "body item #{index + 1} repeats id #{id.inspect}")
  elsif id
    ids << id
  end

  unless validator.nonempty_string?(attributes["label"])
    validator.error(path, "body item #{index + 1} must have a non-empty attributes.label")
  end

  if type == "dropdown"
    options = attributes["options"]
    unless options.is_a?(Array) && !options.empty? &&
           options.all? { |option| validator.nonempty_string?(option) }
      validator.error(path, "dropdown #{id.inspect} must have non-empty string options")
    end
    if attributes.key?("multiple") && !validator.boolean?(attributes["multiple"])
      validator.error(path, "dropdown #{id.inspect} attributes.multiple must be boolean")
    end
  end

  if type == "checkboxes"
    options = attributes["options"]
    unless options.is_a?(Array) && !options.empty?
      validator.error(path, "checkboxes #{id.inspect} must have at least one option")
    else
      options.each_with_index do |option, option_index|
        unless option.is_a?(Hash) && validator.nonempty_string?(option["label"])
          validator.error(path, "checkboxes #{id.inspect} option #{option_index + 1} needs a label")
          next
        end
        if option.key?("required") && !validator.boolean?(option["required"])
          validator.error(path, "checkboxes #{id.inspect} option #{option_index + 1} required must be boolean")
        end
      end
    end
  end

  validations = control["validations"]
  return if validations.nil?

  unless validations.is_a?(Hash)
    validator.error(path, "body item #{index + 1} validations must be a mapping")
    return
  end
  if validations.key?("required") && !validator.boolean?(validations["required"])
    validator.error(path, "body item #{index + 1} validations.required must be boolean")
  end
end

def validate_form(path, validator)
  form = load_yaml(path, validator)
  return if form.equal?(YAML_PARSE_ERROR)

  unless form.is_a?(Hash)
    validator.error(path, "top level must be a mapping")
    return
  end

  %w[name description].each do |field|
    unless validator.nonempty_string?(form[field])
      validator.error(path, "#{field} must be a non-empty string")
    end
  end

  if form.key?("title") && !form["title"].is_a?(String)
    validator.error(path, "title must be a string")
  end
  validate_string_list(form["labels"], path, "labels", validator)
  validate_string_list(form["assignees"], path, "assignees", validator)

  body = form["body"]
  unless body.is_a?(Array) && !body.empty?
    validator.error(path, "body must be a non-empty list")
    return
  end

  ids = []
  body.each_with_index do |control, index|
    validate_control(control, index, path, ids, validator)
  end
end

def validate_config(path, validator)
  config = load_yaml(path, validator)
  return if config.equal?(YAML_PARSE_ERROR)

  unless config.is_a?(Hash)
    validator.error(path, "top level must be a mapping")
    return
  end

  unless validator.boolean?(config["blank_issues_enabled"])
    validator.error(path, "blank_issues_enabled must be boolean")
  end

  links = config["contact_links"]
  unless links.is_a?(Array)
    validator.error(path, "contact_links must be a list")
    return
  end

  links.each_with_index do |link, index|
    unless link.is_a?(Hash)
      validator.error(path, "contact link #{index + 1} must be a mapping")
      next
    end
    %w[name url about].each do |field|
      unless validator.nonempty_string?(link[field])
        validator.error(path, "contact link #{index + 1} #{field} must be a non-empty string")
      end
    end
    url = link["url"]
    unless validator.nonempty_string?(url) && url.match?(/\Ahttps:\/\//)
      validator.error(path, "contact link #{index + 1} url must use HTTPS")
    end
  end
end

def destination_token(raw)
  value = raw.strip
  if value.start_with?("<")
    closing = value.index(">")
    return closing ? value[1...closing] : value
  end

  token = +""
  escaped = false
  value.each_char do |character|
    if escaped
      token << character
      escaped = false
    elsif character == "\\"
      escaped = true
    elsif character.match?(/\s/)
      break
    else
      token << character
    end
  end
  token
end

def inline_destinations(line)
  destinations = []
  cursor = 0

  while (match = line.match(/!?\[[^\]\n]*\]\(/, cursor))
    content_start = match.end(0)
    depth = 1
    index = content_start
    escaped = false

    while index < line.length
      character = line[index]
      if escaped
        escaped = false
      elsif character == "\\"
        escaped = true
      elsif character == "("
        depth += 1
      elsif character == ")"
        depth -= 1
        break if depth.zero?
      end
      index += 1
    end

    break unless depth.zero?

    destinations << destination_token(line[content_start...index])
    cursor = index + 1
  end

  destinations
end

def markdown_destinations(path)
  destinations = []
  fence_character = nil
  fence_length = 0

  path.each_line.with_index(1) do |line, line_number|
    stripped = line.lstrip
    if fence_character
      if stripped.match?(/\A#{Regexp.escape(fence_character)}{#{fence_length},}/)
        fence_character = nil
        fence_length = 0
      end
      next
    end

    if (fence = stripped.match(/\A(`{3,}|~{3,})/))
      fence_character = fence[1][0]
      fence_length = fence[1].length
      next
    end

    without_code = line.gsub(/(`+)(.*?)\1/, "")
    if (definition = without_code.match(/\A {0,3}\[[^\]]+\]:\s*(<[^>]+>|\S+)/))
      destinations << [destination_token(definition[1]), line_number]
    end
    inline_destinations(without_code).each do |destination|
      destinations << [destination, line_number]
    end
  end

  destinations
end

def validate_markdown_links(validator)
  Dir.glob(ROOT.join("**", "*.md").to_s).sort.each do |filename|
    path = Pathname.new(filename)
    markdown_destinations(path).each do |destination, line_number|
      next if destination.empty? || destination.start_with?("#", "/", "//")
      next if destination.match?(/\A[A-Za-z][A-Za-z0-9+.-]*:/)

      relative_target = destination.split(/[?#]/, 2).first
      next if relative_target.nil? || relative_target.empty?

      begin
        relative_target = URI::DEFAULT_PARSER.unescape(relative_target)
      rescue ArgumentError
        validator.error(path, "line #{line_number} has invalid URL encoding in #{destination.inspect}")
        next
      end

      target = Pathname.new(File.expand_path(relative_target, path.dirname))
      unless target == ROOT || target.to_s.start_with?("#{ROOT}#{File::SEPARATOR}")
        validator.error(path, "line #{line_number} escapes the repository: #{destination.inspect}")
        next
      end
      unless target.exist?
        validator.error(path, "line #{line_number} points to missing target #{destination.inspect}")
      end
    end
  end
end

validator = Validator.new

expected_files = (FORM_NAMES + [CONFIG_NAME]).sort
actual_files = ISSUE_TEMPLATE_DIR.children.map { |path| path.basename.to_s }.sort
unless actual_files == expected_files
  validator.error(
    ISSUE_TEMPLATE_DIR,
    "expected exactly #{expected_files.join(', ')}, found #{actual_files.join(', ')}"
  )
end

FORM_NAMES.each do |name|
  path = ISSUE_TEMPLATE_DIR.join(name)
  path.exist? ? validate_form(path, validator) : validator.error(path, "file is missing")
end

config_path = ISSUE_TEMPLATE_DIR.join(CONFIG_NAME)
config_path.exist? ? validate_config(config_path, validator) : validator.error(config_path, "file is missing")
validate_markdown_links(validator)

if validator.errors.empty?
  puts "Validated #{FORM_NAMES.length} issue forms, issue template config, and local Markdown links."
  exit 0
end

warn "Governance validation failed:"
validator.errors.each { |message| warn "  - #{message}" }
exit 1
