# ByteFolk organization avatar

The current organization avatar uses the **Open Herd icon without the ByteFolk wordmark**,
as specified in [issue #18, R2](https://github.com/bytefolk/.github/issues/18).
Its only graphic source is `g#open-herd-mark` in
[`bytefolk-concept-c-open-herd.svg`](bytefolk-concept-c-open-herd.svg).
The mark-only SVG preserves that group's four paths, five rectangles, and colors exactly;
it only removes the horizontal lockup's translation and wordmark and fits the icon canvas.
R2 supersedes the earlier R1 one-color horned B avatar direction.

## Assets

| File | Use |
| --- | --- |
| `bytefolk-concept-c-open-herd.svg` | Unchanged original Open Herd horizontal lockup and source group |
| `bytefolk-concept-c-open-herd-mark.svg` | Exact icon-only extraction; the current avatar export source |
| `avatar-1024.png` | Opaque 1024×1024 Open Herd upload artifact for the GitHub organization profile |
| `symbol.svg` | Historical R1 black horned B; not an avatar source |
| `symbol-reversed.svg` | Historical R1 white horned B; not an avatar source |
| `lockup.svg` | Historical R1 horned B lockup; not an avatar source |

Historical R1 SVGs remain unchanged for reference. Their presence or earlier approval must not
be used to restore the black B organization avatar. The full-body mascot is also a separate asset.

## Usage

- Preserve the source palette: blue `#1677ff`, purple `#722ed1`, ink `#141414`, and white `#ffffff`.
- Use the icon without visible text for organization avatars and compact navigation.
- Keep every visible avatar pixel (any color channel below 250) inside the 496 px-radius circle
  centered at `(511.5, 511.5)` on the 1024 px canvas. This leaves 16 px inside GitHub's 512 px
  circular crop.
- Use the standalone icon at 16 px or larger. Reserve the full lockup for wider brand surfaces.
- Upload `avatar-1024.png` without recropping or recoloring it. The image already includes padding
  and a validated circular safe area for GitHub's presentation.
- Preserve the opaque white avatar background in both GitHub light and dark themes.

Do not redraw, recolor, stretch, rotate, crop, or rearrange the source geometry. Do not add
gradients, shadows, outlines, text, or decoration. Preserve the existing white details and seams.

## Reproduce the GitHub avatar

ImageMagick is required for deterministic raster export:

```bash
brand/bytefolk/render-avatar.sh
brand/bytefolk/render-avatar.sh --check
ruby scripts/validate-brand-assets.rb
```

The first command renders the mark-only SVG at density 768, scales proportionally to fit
900×900, centers it on an opaque white 1024×1024 canvas, and writes `avatar-1024.png`.
The second renders to a temporary file and verifies byte-for-byte equality with the tracked
artifact. The validator checks the approved source, icon geometry and palette, and avatar pixels.

The tracked export was produced with ImageMagick 7.1.2-22. Other renderer versions may produce
different antialiasing or PNG bytes; do not replace the approved artifact without verifying the
source and visual result. Upload the tracked PNG, then verify GitHub's served pixels separately.
