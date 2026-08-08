# Empirical Writing

Use this note when drafting or revising prose that interprets model estimates, null effects, confidence intervals, robustness checks, or descriptive statistical patterns.

## Core Stance

- Treat empirical prose as a translation task: convert model output into claims about meaningful contrasts in the world.
- Name the substantive concept rather than the code variable.
- Do not write only that a coefficient is insignificant, small, positive, negative, or robust. Explain what the estimate implies over a concrete contrast and whether that implication is large enough to matter for the manuscript's argument.
- Keep calculations reproducible in hidden chunks under `analysis/chXX/chunks/`; do not hard-code empirical quantities in manuscript prose when they can be computed.
- Round reader-facing quantities enough to be memorable. Preserve greater
  precision in hidden calculations, tables, and appendices when it matters.
- Explain adjustments and model choices in plain language. Move technical
  details to a caption, note, footnote, or appendix when they would interrupt
  the argument.

## Writing About Null Or Near-Null Effects

1. State the theory or threat the null result is addressing.
2. Show that the predictor has enough variation for the null to be informative.
3. Translate the relevant confidence interval into a concrete contrast, usually a weighted 10th-to-90th percentile change or a pair of named cases near those percentiles.
4. Match the comparison scale: if the predictor contrast is weighted 10th-to-90th percentile, compare it with the outcome's weighted 10th-to-90th percentile spread unless there is a clear reason to use a different range.
5. For theories predicting a positive effect, focus on the largest positive effect still allowed by the confidence interval. Be precise: say the result rules out a large positive effect, not all meaningful effects, if the negative side of the interval remains large.
6. Compare the largest plausible effect with the outcome variation to be explained.
7. Add named examples when available. Readers understand "roughly the difference between case A and case B" faster than a percentile contrast alone.
8. Put coefficient details, specification caveats, and pooled-model warnings in a short reference-style footnote when they would interrupt the paragraph.

## Useful Prose Pattern

> Within [sample], there is plenty of variation in [predictor], but little evidence that it explains [outcome]. Moving from the weighted 10th to the 90th percentile of [predictor] means moving from [low] to [high], roughly the difference between [case A] and [case B]. Even using the top of the 95% confidence interval, a change that large could raise [outcome] by only [effect]. That is small compared with the weighted 10th-to-90th-percentile spread in [outcome], about [spread], roughly the difference between [case C] and [case D].

## Descriptive and appendix evidence

- Say what the data directly show before offering a mechanism.
- Put a source-category or coding caveat where the data are first introduced,
  not in a detached later section.
- A useful sequence is: explain the source and coding rule; report relevant
  observation and unit counts; present one targeted diagnostic; show the
  figure or table; state the takeaway and limitation.
- Use concrete labels such as `Observed value` and `Imputed value` rather than
  internal bookkeeping terms.
- Report cell counts for subgroup or period comparisons when some cells may be
  sparse.
- Explain results in sentences rather than dumping syntax, model objects, raw
  summaries, or unexplained fixed-effect terminology.
- Separate a robustness result from the main result. State exactly what
  changes, what remains stable, and which threat the check addresses.

## Common Mistakes

- Do not imply that a null estimate proves the effect is zero.
- Do not claim the data rule out a meaningful effect if only one substantively relevant direction is ruled out.
- Do not use inconsistent percentile ranges for predictor and outcome unless the prose explains why.
- Do not leave readers to infer units from a coefficient.
- Do not let a control variable that proxies for a broad category carry a causal interpretation without explaining what it may absorb.
- Do not treat a robustness check as proof that every alternative explanation
  has been eliminated.
- Do not describe a measure as directly observing a mechanism when it is only
  a proxy.
