# Data Construction Rules

- `data/raw/` is for source-like inputs. Code reads raw data but does not overwrite it.
- `data/clean/` is for cleaned, merged, recoded, or constructed outputs.
- Ordinary production commands stay easy to find at the
  `data_construction/` root. Internal components live under `builders/` and
  are called by their owning master.
- Use relative paths from `data_construction/`.
- Minimize the number of commands a replicator must run. A master command
  should build or invoke every derived prerequisite for its registered output.
- Follow `documentation/replication-policy.md` for production builders,
  registered datasets, source refreshes, and book-data interfaces. Update the
  live register in `README.md` whenever those interfaces change.
- For new derived data, report original rows, retained rows, lost rows, and reasons.
- For merges, report match-status counts and inspect unmatched rows.
- For new variables, show descriptives, missingness, cross-tabs or distributions, and correlations when useful.
- Treat unexpected changes in row counts, unit counts, years, or key coverage
  as first-order warnings.
- Assert important keys and expected coverage in the build itself rather than
  relying only on a one-time manual check.
- For API/package downloads, save a local raw copy and keep the live call disabled unless refreshing.
- Keep API keys in environment variables or private files outside the repo.
- Keep the main production datasets broad enough for their intended uses.
  Put figure-, table-, and model-specific sample restrictions downstream.
- Before creating another clean-data offshoot, ask whether the fields belong
  in an existing registered dataset.
- Put exploratory code in scratch or an exploratory folder. Promote it into
  the documented production path when it becomes part of the evidence base.

## Scratch and documentation

- Put all probes, debug scripts, logs, audit exports, temporary joins, and
  helper datasets under `scratch/` in a dated, purpose-named packet.
- A nontrivial packet should have a short README with purpose, status, source
  files, and intended permanent location.
- Do not leave logs or temporary files in `data_construction/`,
  `data/clean/`, `builders/`, or `_codex/`.
- Final builders and registered datasets must not depend on scratch.
- Update `documentation/` when adding or materially changing a source,
  variable definition, merge, sample restriction, or derived output.
- Add recurring pipeline-specific checks and failure modes to
  `documentation/pipeline-lessons/`.
