# Project Agent Defaults

Keep this public template small and reproducible.

- Use repository-relative paths for project files. Dependency checkers may
  probe standard operating-system installation locations, but data, analysis,
  manuscript, and render code must not depend on a machine-specific project
  path.
- Keep raw data raw; generated data belongs in clean/output folders.
- Keep `AGENTS.md` files as routers and put detailed rules in focused notes.
- For production-data or replication-interface work, follow
  `data_construction/documentation/replication-policy.md` and maintain the
  live command and dataset register in `data_construction/README.md`.
- Keep scratch work out of production folders.
- Prefer accuracy over impressive completion. Report unmatched, missing, ambiguous, and excluded cases.
- Fix production problems in the pipeline that creates the data, figure, or
  table rather than leaving the real fix in scratch or display code.
- Before debugging render failures, run the repo's dependency checker. This template needs R, Pandoc, the R packages `bookdown`, `knitr`, and `rmarkdown`, and optional Python 3 helpers. Stata is not required.
