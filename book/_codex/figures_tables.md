# Figures And Tables

## Layout

- Figures: `book/analysis/chXX/figures/`
- Tables: `book/analysis/chXX/tables/`
- Inline/stat chunks: `book/analysis/chXX/chunks/`

## Rules

- Fix upstream data problems in the production pipeline that creates the data,
  not in book-side plotting code.
- New or substantially revised displays should use production datasets
  registered in `data_construction/README.md` whenever reasonably possible.
  More than one registered input is allowed. Filtering, reshaping,
  aggregation, estimation, labeling, and well-checked joins may remain here;
  shared measures and corrections belong in the owning data builder.
- Keep chapter chunks thin; put substantive code in external scripts.
- Preserve chunk labels because cross-references and maps depend on them.
- Report sample sizes or row counts when figures and tables summarize data.
- Explain and validate reliance on raw, scratch, specially built, or
  unregistered data beside the display script.
- Prefer quiet, grayscale-safe figures that do not depend on color alone.
  For a few series, use direct labels when clearer than a legend. Do not add
  point markers automatically when dates are already clear.
- Normally let the manuscript caption carry the title rather than repeating
  it inside the plot.
- Check whether filters, limits, smoothing, line-only displays, missing
  values, or cached output hide observations. If they do, say so.
- Verify an outlier's ingredients and source definition before excluding it.
- When samples change over time, inspect counts by period and group; consider
  a fixed-group sensitivity when composition might explain the trend.
- After rendering, use `book/_reports/figure_map.md`, `table_map.md`, and `artifact_map.md` to find source chunks. The maps include rendered-style number, owner, cross-reference label, caption, and source path.
- Treat the cross-reference label (`fig:...` or `tab:...`) and source path as the stable edit handles. Rendered numbers are user-facing lookup keys and may change when chapters, appendices, figures, or tables move.
- If map numbering and the rendered output appear to disagree, rerun the included render script before editing from memory or from an older PDF.
- For manuscript regression-table style, especially coefficient/confidence-interval layout, dependent-variable headers, model notes, OLS/weights/SER conventions, and LaTeX/kableExtra details, read `book/_codex/regression_tables.md`.
