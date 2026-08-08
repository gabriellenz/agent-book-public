# Regression guidance

## Core rules

- Start with the raw relationship and a simple specification before adding
  controls, interactions, fixed effects, or alternative estimators.
- When observations aggregate people, events, or another relevant base, use
  substantively appropriate weights and explain them.
- For ordinary least squares, use heteroskedasticity-robust standard errors
  when no clustering is called for. HC2 is a good default for new work.
- Cluster when treatment assignment or repeated observations create
  dependence within a meaningful unit. State the clustering level. Do not add
  clustering mechanically when there is only one observation per unit.
- For generalized linear count models, use robust sandwich standard errors
  unless the model-based variance assumption is intentional and defended.
- Report `N` and useful counts of cities, schools, states, people, clusters, or
  other substantive units.
- Treat thin support, sparse cells, separation, extreme weights, and large
  sample changes as first-order warnings.

## Diagnostics

- Confirm the estimation sample rather than assuming it matches the input
  data.
- Report missingness and the reasons rows leave the model.
- Inspect distributions, influential observations, and overlap in important
  predictors.
- Check whether the result depends on coding decisions, a few units, changing
  composition, or extrapolation beyond observed support.
- Compare several reasonable specifications when the result will carry
  substantive weight, but do not use specification searching to manufacture a
  preferred conclusion.

## Reporting

- Name the outcome and its units.
- Name the main predictor and the contrast being interpreted.
- State weights, controls, fixed effects, and standard-error estimator.
- Translate coefficients and confidence intervals into meaningful quantities.
- Distinguish descriptive association, design-based estimate, and causal
  interpretation.
- If support is thin or a result remains exploratory, say so plainly.
- Keep book-facing estimates reproducible in book-side R scripts and follow
  `book/_codex/empirical_writing.md` and
  `book/_codex/regression_tables.md`.
