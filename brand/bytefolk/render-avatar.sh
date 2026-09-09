#!/usr/bin/env bash
set -euo pipefail

asset_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_svg="$asset_dir/bytefolk-concept-c-open-herd-mark.svg"
tracked_png="$asset_dir/avatar-1024.png"
mode="${1:-write}"

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick 'magick' is required to render the ByteFolk avatar." >&2
  exit 1
fi

render() {
  local destination="$1"
  magick \
    -background '#ffffff' \
    -density 768 \
    "$source_svg" \
    -resize 900x900 \
    -gravity center \
    -background '#ffffff' \
    -extent 1024x1024 \
    -alpha remove \
    -alpha off \
    -colorspace sRGB \
    -type TrueColor \
    -strip \
    -define png:exclude-chunks=date,time \
    "PNG24:$destination"
}

case "$mode" in
  write)
    render "$tracked_png"
    echo "Rendered $tracked_png"
    ;;
  --check)
    candidate="$(mktemp /tmp/bytefolk-avatar-check.XXXXXX)"
    trap 'rm -f -- "$candidate"' EXIT
    render "$candidate"
    if ! cmp -s "$candidate" "$tracked_png"; then
      echo "avatar-1024.png is stale; run brand/bytefolk/render-avatar.sh" >&2
      exit 1
    fi
    echo "ByteFolk avatar matches the Open Herd mark-only source"
    ;;
  *)
    echo "Usage: brand/bytefolk/render-avatar.sh [write|--check]" >&2
    exit 2
    ;;
esac
