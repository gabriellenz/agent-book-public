# Regression Tables

Use this note for manuscript regression tables. Keep estimates generated from book-side scripts; do not copy coefficients, confidence intervals, standard errors, or fit statistics by hand from console output.

For prose that interprets coefficients, confidence intervals, null effects, or effect sizes, also read `book/_codex/empirical_writing.md`.

## Preferred Layout

- Use a compact booktabs-style table, but make it wide enough that the table note reads comfortably. Near-full-page width is fine when it improves note readability.
- Put the dependent variable at the top as a centered two-line spanning header over the model columns:
  - first line: `Dependent variable`
  - second line: the outcome name, such as `Umbrella count` or `Outcome rate per 100,000`
- Do not put a rule between those two dependent-variable header lines. Keep a thin rule below the outcome line before the model-column names.
- Each model column is a separate regression. Say this explicitly in the table note because readers from some fields may not assume it.
- Show coefficients in the main variable row and 95 percent confidence intervals in square brackets on the row immediately below, in the same model column.
- Leave cells blank where a variable is not included in a model.
- Insert a thin horizontal rule between the last coefficient/confidence-interval row and the model-summary rows.
- Include model-summary rows at the bottom when available:
  - fixed effects included, if relevant
  - weights included, if relevant
  - `N`
  - `R-squared`
  - `SER`

## Model Notes

Use a detailed table note. At minimum, state:

- the unit of analysis and sample construction
- the model name, such as ordinary least squares (OLS)
- that each column is a separate regression
- controls and fixed effects
- weights
- coefficient and confidence-interval convention
- definitions of non-obvious variables, abbreviations, or outcome conventions

If the displayed outcome uses a manuscript convention that differs from the raw variable name, say so in the note.

If predictors are percentages or shares, state whether they enter in percentage points, proportions, or logs.

For weighted `lm` models with population weights, do not report base `sigma()` as `SER`. If `SER` is needed, report the weighted residual RMSE in outcome units and define it in the note.

## LaTeX And kableExtra Details

- Escape LaTeX-sensitive text in table cells. In particular, labels like `(%)` must be escaped or LaTeX will truncate the row after `%`.
- `kableExtra::add_header_above()` can create the two-line dependent-variable header. Use `line = FALSE` on the upper `Dependent variable` header to avoid a rule between the two lines.
- Use `kableExtra::row_spec(<last_ci_row>, hline_after = TRUE)` to add the separator before model-summary rows.
- Use `threeparttable = TRUE` for long notes so they stay attached to the table.
- If the note is too narrow, use `column_spec()` to widen columns enough for a readable note.
