#!/bin/bash
# Usage: render.sh <input.html> <output.pdf>
# Copies the Anthropic fonts beside the HTML (in ./fonts) from this machine's Claude desktop app or
# user fonts folder, then prints the page to PDF with headless Chrome. The fonts are not shipped with this skill.
set -euo pipefail
in="$1"; out="$2"
dir="$(cd "$(dirname "$in")" && pwd)"
mkdir -p "$dir/fonts"
found=0
for src in "${ANTHROPIC_FONTS_DIR:-}" "/Applications/Claude.app/Contents/Resources/fonts" "$HOME/Library/Fonts"; do
  [ -n "$src" ] && [ -d "$src" ] || continue
  for f in "$src"/AnthropicSans-*-Variable-*.ttf "$src"/AnthropicSerif-*-Variable-*.ttf "$src"/AnthropicMonoVariable.ttf; do
    [ -f "$f" ] && cp -n "$f" "$dir/fonts/" && found=1
  done
done
if [ "$found" = 0 ] && ! ls "$dir"/fonts/AnthropicSans-*.ttf >/dev/null 2>&1; then
  echo "Anthropic fonts not found. Install the Claude desktop app, or set ANTHROPIC_FONTS_DIR to a folder that holds them." >&2
  exit 1
fi
chrome="${CHROME_BIN:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
"$chrome" --headless=new --disable-gpu --no-pdf-header-footer --allow-file-access-from-files \
  --virtual-time-budget=20000 --print-to-pdf="$out" "file://$dir/$(basename "$in")" >/dev/null 2>&1 || true
[ -s "$out" ] || { echo "render failed: $out not written" >&2; exit 1; }
pdfinfo "$out" 2>/dev/null | grep Pages || true
pdffonts "$out" 2>/dev/null | awk 'NR>2{print $1}' | sed 's/^[A-Z]*+//' | sort -u || true
