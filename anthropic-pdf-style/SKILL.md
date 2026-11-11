---
name: anthropic-pdf-style
description: Build a PDF document (report, guide, QA plan, readiness summary, memo) in the Anthropic / Claude house style. Use when the user asks for a PDF in "Anthropic style", "Claude style", "default artifact style" or "the default template", or asks for an internal PDF without naming another brand. Not for client-branded deliverables.
---

# Anthropic-style PDF

Start from the template and change content only. Do not improvise a different look.

## What the style is

- **Type:** Anthropic Sans for body text, headings, labels and table text, with real weights (400 body, 600 labels, 650 headings and bold). Anthropic Serif only for the document title (`h1`, weight 400, optical size 48). Anthropic Mono for code. Khmer uses Khmer OS Battambang (shipped in `assets/fonts/`; regular weight only, so Chrome synthesises bold). Mark Khmer passages with `lang="km"` so they get the taller line height Khmer needs.
- **Page:** A4, warm off-white `#f9f9f7` edge to edge, near-black ink `#0b0b0b`, secondary text `#52514e`, labels `#6b6a65`, hairline rules `#e1e0d9`.
- **Panels:** raised surface `#fcfcfb` with a 1px hairline border and 10px radius. Used for the three fact tiles under the title and nothing else by default.
- **Accent:** clay `#d97757` is the only accent. It appears in the one callout (`.note`) and, darkened to `#b85f43`, in table row IDs. Status pills use green, amber and red and are not the accent.
- **Tables:** no vertical lines, hairline row rules, small uppercase letter-spaced column heads.

It was taken from Anthropic's own report template in the official Claude Code plugins (`champion-kit/skills/maturity/report-template.html`).

Looks that miss, so do not use them: Inter with Space Grotesk on white with a blue accent; Poppins with Lora; serif body text on cream; the regular-only "Web Text" font files, which cannot do bold.

## How to build one

1. Copy `assets/template.html` to a working folder (the session scratchpad) and replace the sample content. Keep the `<style>` block and the outer `table.page` wrapper as they are.
2. Put images in an `img/` folder beside the HTML and reference them with relative paths.
3. Render: `scripts/render.sh <input.html> <output.pdf>`. It copies the fonts beside the HTML, prints with headless Chrome (set `CHROME_BIN` if Chrome is elsewhere), and lists the page count and the fonts embedded. It needs macOS with Google Chrome, and `pdfinfo` and `pdffonts` from poppler for the report.
4. Check the output before handing it over:
   - The font list must show `AnthropicSans` and `AnthropicSerif`. If it shows Helvetica, Arial or Georgia, the fonts did not load.
   - Turn the pages into images (`pdftoppm -r 45 -png`) and look at every page for a near-empty page, a table heading stranded at a page bottom, or an image that overflowed.
5. Save the PDF where the user asked, and say plainly where it is.

## Layout rules that matter in print

- `@page { margin: 0 }` plus the `table.page` wrapper is what lets the page colour reach the paper edge while each page still has a top and bottom margin. Removing either gives white borders or text touching the edge.
- `section.pb` starts a new page. Use it only for major parts; too many leave half-empty pages.
- Images are capped at 108mm high so a screenshot and its caption stay on one page. Two side by side go in `<div class="pair">`.
- Rows never split across pages, and a table's heading row stays with its first data row.
- Use `class="num"` on figures so digits line up.

## Fonts

- The Anthropic fonts are not shipped with this skill. They are Anthropic's proprietary typefaces.
- `scripts/render.sh` copies them from the Claude desktop app on the same machine (`/Applications/Claude.app/Contents/Resources/fonts/`), or from `~/Library/Fonts`, or from a folder named in `ANTHROPIC_FONTS_DIR`. It stops with a message when it finds none.
- The app has Anthropic Sans and Anthropic Serif. Anthropic Mono is optional; without it, code falls back to the system monospace font.
- Khmer OS Battambang ships in `assets/fonts/` (LGPL 2.1, Danh Hong) and is copied beside the HTML on every render.
- The fonts get embedded in the PDF. Tell the user once when a document is meant to go outside their company.

## Writing

Plain sentences, the conclusion first, real figures with units. Number sections only when the order matters. No emoji.
