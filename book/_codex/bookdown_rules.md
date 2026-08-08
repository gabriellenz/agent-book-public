# Bookdown rules

## Structure

- `book/bookdown/index.Rmd` contains the whole-book YAML and front matter.
- `book/bookdown/_bookdown.yml` controls chapter order.
- `book/chapters/` is the manuscript source of truth. The render script copies
  chapter files into the Bookdown wrapper.
- `book/bookdown/_common.R` holds shared knitr setup.
- Do not edit copied chapter files or generated Bookdown intermediates as the
  permanent source.

## Paths

- Use forward-slash repository-relative paths. Do not add a drive letter, home
  directory, or machine-specific project root.
- Set the knit context once rather than calling `setwd()` inside chunks.
- External scripts loaded with `file="analysis/..."` execute in the
  `book/bookdown/` knit context, not relative to the script file.
- Book-facing scripts read registered clean datasets using the path in
  `book/_codex/data.md`.

## Chapters and ordering

- Each chapter begins with one level-one heading.
- Add or reorder chapters through `_bookdown.yml`, not filename changes alone.
- Preserve unnumbered markers such as `{-}` on the preface, citations, or
  other intentionally unnumbered chapters.
- Do not hard-code appendix letters or rendered chapter, figure, or table
  numbers in reusable prose.

## Figures, tables, and cross-references

- Every cross-referenced figure or table needs a stable chunk label and
  caption.
- Reference figures with `\@ref(fig:chunk-label)` and tables with
  `\@ref(tab:chunk-label)`.
- Never change an existing chunk label casually. Generated maps and
  cross-references depend on it.
- Preserve `(ref:label)` caption definitions, chunk options, and citations
  inside captions.
- Keep substantive figure, table, and inline-stat code in external scripts.
  Follow `book/_codex/figures_tables.md`.
- Keep inline R in prose simple. Compute and format complicated quantities in
  a hidden external chunk, then reference one named scalar.

## YAML and output

- Do not change output formats, citation settings, LaTeX header settings, or
  global knitr behavior unless the task requires it.
- Keep PDF-required code free of HTML-only dependencies.
- If a render fails after a refactor, do not repair it by rewriting captions,
  labels, or YAML indiscriminately. Capture the error and make the smallest
  targeted fix.
- Some tools return a nonzero status after writing an output. Check that the
  expected PDF or HTML exists and is readable before deciding what failed.

## Citations and footnotes

- Narrative citation: `@key`.
- Parenthetical citation: `[@key]`.
- Preserve the author's form unless editing the sentence substantively.
- Prefer reference-style footnotes for notes long enough to make the source
  paragraph hard to edit. Keep footnote labels short and content-based.
- The final unnumbered citations chapter contains the bibliography placeholder
  and must remain in `_bookdown.yml`.

## Render and maps

- Render from the repository root with the included script for the user's
  platform.
- The render rebuilds shared clean data before knitting the book.
- After rendering, check `output/book.pdf` or `output/index.html` and the
  three maps under `book/_reports/`.
- Use rendered numbers for user-facing lookup and stable labels/source paths
  for edits.
- Visually inspect pages affected by changed prose, figures, tables, citations,
  or front matter.
- Keep temporary render probes and extracted pages under `scratch/`.
