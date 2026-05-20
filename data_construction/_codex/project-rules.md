# Data Construction Rules

- `data/raw/` is for source-like inputs. Code reads raw data but does not overwrite it.
- `data/clean/` is for cleaned, merged, recoded, or constructed outputs.
- Production scripts live in `code/`.
- Use relative paths from `data_construction/`.
- For new derived data, report original rows, retained rows, lost rows, and reasons.
- For merges, report match-status counts and inspect unmatched rows.
- For new variables, show descriptives, missingness, cross-tabs or distributions, and correlations when useful.
- For API/package downloads, save a local raw copy and keep the live call disabled unless refreshing.
- Keep API keys in environment variables or private files outside the repo.
