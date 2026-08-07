# Data Construction Agent Index

## Start Here

- Project rules: `data_construction/_codex/project-rules.md`
- Production-data policy:
  `data_construction/documentation/replication-policy.md`
- Live build-command and dataset register: `data_construction/README.md`
- Figure guidance: `data_construction/_codex/figure-guidance.md`
- Regression guidance: `data_construction/_codex/regression-guidance.md`

## Do Not Miss

- Keep raw data raw.
- Put generated outputs in `data/clean/`.
- Use relative paths.
- Keep ordinary build commands few and easy to find; master commands should
  call their own internal builders.
- Report row counts, lost rows, unmatched rows, and validation checks.
