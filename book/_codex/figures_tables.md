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
- After rendering, use `book/_reports/figure_map.md`, `table_map.md`, and `artifact_map.md` to find source chunks. The maps include rendered-style number, owner, cross-reference label, caption, and source path.
- Treat the cross-reference label (`fig:...` or `tab:...`) and source path as the stable edit handles. Rendered numbers are user-facing lookup keys and may change when chapters, appendices, figures, or tables move.
- If map numbering and the rendered output appear to disagree, rerun the included render script before editing from memory or from an older PDF.
- For manuscript regression-table style, especially coefficient/confidence-interval layout, dependent-variable headers, model notes, OLS/weights/SER conventions, and LaTeX/kableExtra details, read `book/_codex/regression_tables.md`.
