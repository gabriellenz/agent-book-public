# Figures And Tables

## Layout

- Figures: `book/analysis/chXX/figures/`
- Tables: `book/analysis/chXX/tables/`
- Inline/stat chunks: `book/analysis/chXX/chunks/`

## Rules

- Keep chapter chunks thin; put substantive code in external scripts.
- Preserve chunk labels because cross-references and maps depend on them.
- Report sample sizes or row counts when figures and tables summarize data.
- If a display hides data through filters, limits, or missing values, say so.
- After rendering, use `book/_reports/figure_map.md`, `table_map.md`, and `artifact_map.md` to find source chunks.
- For manuscript regression-table style, especially coefficient/confidence-interval layout, dependent-variable headers, model notes, OLS/weights/SER conventions, and LaTeX/kableExtra details, read `book/_codex/regression_tables.md`.
