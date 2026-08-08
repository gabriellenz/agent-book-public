# Figures and tables

Use this note for book-facing figures, tables, and hidden chunks.

## Layout

- Figures: `book/analysis/chXX/figures/`
- Tables: `book/analysis/chXX/tables/`
- Inline-stat chunks: `book/analysis/chXX/chunks/`
- Drafts, probes, and temporary outputs: `scratch/`

## Data and code

- Fix data problems in the data-construction pipeline, not in book-side
  plotting or table code.
- New or substantially revised displays should use datasets registered in
  `data_construction/README.md` whenever reasonably possible. Using more than
  one registered dataset is fine.
- Filtering, reshaping, aggregation, estimation, labeling, and well-checked
  joins may remain in the book script. Shared measures, recurring joins, and
  corrections to the main data belong in the owning builder.
- Explain and validate any use of raw, scratch, specially built, or
  unregistered data beside the script.
- Keep chapter chunks thin. Put substantive code in external scripts and let
  the book render execute those scripts.
- Generate book-facing estimates in code. Do not paste coefficients, standard
  errors, fit statistics, summary values, or table cells from console output.
- Put values used in prose in external hidden chunks rather than hard-coding
  quantities that can change when data are rebuilt.

## Chunk and caption safety

- Preserve chunk labels. They are the stable handles for cross-references and
  generated maps.
- Preserve chunk options, caption text, `(ref:...)` blocks, and citation
  syntax unless the task requires changing them.
- Keep caption definitions in the chapter file rather than moving them into
  external scripts.
- Code loaded with `file="analysis/..."` runs in the Bookdown knit context,
  not relative to the external script's own folder.
- Use the repository-relative data path documented in
  `book/_codex/data.md`.

## Figure design

- Start from shared plotting defaults in `book/bookdown/_common.R`. Prefer
  small local adjustments over a one-off replacement theme.
- Design figures to work in grayscale. Do not rely on color; use line type,
  linewidth, shape, fill, or direct labels to distinguish series.
- Prefer thin, visually quiet lines, restrained annotation, and minimal
  furniture.
- Usually omit an embedded plot title or caption; the R Markdown caption
  carries that information.
- Use short, reader-facing series names and explicit axis labels with units
  and years.
- For a few series, prefer direct labels in unused space when clearer than a
  legend. Otherwise place the legend in genuinely unused plot space or above
  the figure.
- Do not add point markers automatically to line charts when observation
  timing is already obvious. Use small symbols when irregular timing, missing
  observations, or exact values need emphasis.
- For facets intended for comparison, normally use shared scales, quiet strip
  backgrounds, plain strip text, thin axes, and enough panel spacing.
- Use readable transformations when values are highly skewed. If using
  `scales::pseudo_log_trans()`, choose and record an explicit `sigma`.
- Size points by a meaningful exposure, denominator, or precision measure,
  not arbitrary visual importance.
- When smoothing adjusted outcomes over time, do not remove the time pattern
  the figure is meant to show. Adjust only for nuisance variation outside the
  displayed relationship.

## Labels

- For labeled scatters, prefer `ggrepel`.
- If the plot is dense, label a principled subset: large observations,
  extremes, or substantively important cases.
- Give the repel layer the full plotted dataset and blank labels for
  unselected observations so selected labels avoid every point.
- Use `max.overlaps = Inf` when every selected label must appear.
- Check label clipping and overlap in the rendered output, not only in an
  interactive preview.

## Data visibility

Before signing off, check whether real observations are hidden by:

- line-only geometries that drop singletons;
- gap or segment rules;
- smoothing choices;
- facet or sample filters;
- axis limits or coordinate clipping;
- selective labeling;
- missing-value handling; or
- cached chunks that did not rerun.

If relevant data are omitted, tell the user and say whether the remedy belongs
in display logic, data construction, or both.

- Before excluding or explaining an outlier, verify its numerator,
  denominator, transcription, and source definition.
- Retain correctly measured unusual observations. Explain consequential
  category differences in the caption or note.
- When a sample changes over time, inspect counts by period and series.
  Consider a fixed-group or within-unit sensitivity when entry and exit could
  create the apparent trend.
- If axis limits omit real observations, say how many and identify
  consequential cases in the caption.

## Tables

- Build tables from live code and registered data; do not paste screenshots or
  hand-maintained values.
- Put the substantive grouping or comparison first. Sort rows in an order that
  helps the reader, not merely alphabetically or by internal codes.
- Use reader-facing labels and consistent units, rounding, decimal places, and
  missing-value notation.
- Report `N` and useful unit counts. If denominators differ across columns,
  make that clear.
- Identify the outcome, sample, unit of analysis, weights, and important
  restrictions in the caption or note.
- Define abbreviations and non-obvious categories in table notes.
- Keep notes wide and readable. A compact table does not justify a cramped,
  unreadable note.
- For regression-table layout, confidence intervals, model notes, robust
  standard errors, and LaTeX details, read
  `book/_codex/regression_tables.md`.

## Scratch and promotion

- Put every draft script and preview under `scratch/`, using a dated,
  purpose-named packet.
- Match the intended production aspect ratio while drafting figures.
- Inspect generated images before promotion.
- Promote approved code into `book/analysis/chXX/...` and update the live
  chapter chunk. Final output must not depend on scratch files.

## Numbering and verification

- After rendering, use `book/_reports/figure_map.md`,
  `book/_reports/table_map.md`, and `book/_reports/artifact_map.md`.
- Use rendered numbers for reader-facing lookup, but edit through stable
  labels and source paths.
- Never rely on remembered numbering. If a map and the rendered book disagree,
  rerun the official render before editing.
- Visually inspect changed displays for missing, clipped, overlapping, or
  unreadable content.
