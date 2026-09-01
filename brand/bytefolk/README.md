# ByteFolk brand mark

The ByteFolk organization mark is the minimal one-color **horned B** approved in
[issue #18](https://github.com/bytefolk/.github/issues/18). It combines a capital `B`,
two modular horns, and an extended lower bowl that hints at the digital-employee mascot without
turning the logo into an illustration.

## Assets

| File | Use |
| --- | --- |
| `symbol.svg` | Primary mark on white or very light surfaces |
| `symbol-reversed.svg` | White mark on black or dark surfaces |
| `lockup.svg` | Horizontal symbol and `ByteFolk` wordmark |
| `avatar-1024.png` | Exact opaque upload artifact for the GitHub organization profile |

The full-body mascot is a separate expressive brand character. It must not replace the symbol in
organization avatars, favicons, repository ownership marks, or compact product navigation.

## Usage

- Primary ink: `#141414`.
- Reversed ink: `#FFFFFF`.
- Keep clear space of at least one horn-stem width around the symbol.
- Keep every visible avatar pixel (any grayscale value below 250) inside the 496 px-radius circle
  centered at `(511.5, 511.5)` on the 1024 px canvas. This leaves 16 px inside GitHub's 512 px
  circular crop.
- Use the standalone symbol at 16 px or larger.
- Use the horizontal lockup at 120 px wide or larger.
- Upload `avatar-1024.png` without recropping or recoloring it. The image already includes padding
  and a validated circular safe area for GitHub's presentation.
- On dark surfaces, use `symbol-reversed.svg`; do not place the primary black mark directly on a
  dark background.

Do not add gradients, shadows, outlines, background frames, eyes, nostrils, mane tiles, extra
colors, text inside the mark, or product-specific decoration. Do not stretch, rotate, crop, or
rearrange the horns and B geometry.

## Reproduce the GitHub avatar

ImageMagick is required for deterministic raster export:

```bash
brand/bytefolk/render-avatar.sh
brand/bytefolk/render-avatar.sh --check
```

The first command rewrites `avatar-1024.png` from `symbol.svg`. The second renders to a temporary
file and verifies byte-for-byte equality with the tracked artifact.
