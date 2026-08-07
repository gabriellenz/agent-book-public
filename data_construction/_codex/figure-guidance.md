# Figure Guidance

- New or substantially revised figures should use registered production
  datasets from `data_construction/README.md` whenever reasonably possible.
  Keep shared measures and corrections in the owning production builder.
- Prefer simple plots that reveal the raw data.
- Label axes with units and years.
- Prefer quiet lines, restrained styling, and designs that remain readable in
  grayscale. Do not rely on color alone.
- For a few series, prefer direct labels when they are clearer than a legend.
  Do not add point markers automatically when the observed dates are already
  obvious.
- Let the manuscript caption carry the title unless an embedded plot title
  serves a clear purpose.
- Check whether filters, axis limits, smoothing, line-only displays, missing
  values, or cached output hide real observations. Tell the user when they do.
- Verify an unusual observation's numerator, denominator, and source
  definition before excluding it.
- When samples change over time, inspect counts by period and group; consider
  a fixed-group sensitivity when entry and exit could create the pattern.
- Report sample size when the figure summarizes data.
