# Replication and production-data policy

## Aim

The replication path should be short and easy to explain. A reader should be
able to find the project's main datasets, see the command that rebuilds them,
and understand how figures and tables use them without reconstructing a
hidden chain of scripts.

The live command and dataset register is `../README.md`. This note explains
the policy; the README records the working implementation.

## Three layers

1. **Archived sources.** Original or source-like files live under `data/raw/`
   or another documented source folder. Ordinary replication should use saved
   inputs rather than silently contacting a website or API.
2. **Production builders and datasets.** A small number of visible master
   commands create the project's main clean datasets. Internal scripts can
   remain modular under `builders/`, but the master calls them.
3. **Book figures and tables.** Book-side scripts consume registered
   production datasets. They should not quietly rebuild shared measures,
   correct the main data locally, or maintain a second version of a common
   merge.

Scratch files and diagnostic exports can be useful, but they are not an
additional production layer and should not become undocumented inputs.

## Master-build contract

- Keep each ordinary replication command easy to find and record it in the
  live register.
- A master command should rebuild or call every derived input needed for its
  registered outputs.
- Use relative paths so the project works after it is cloned elsewhere.
- Prefer saved source files for ordinary builds. Keep downloads, credentials,
  and licensed-data refreshes separate and documented.
- Put checks in the production path: unique keys, expected coverage,
  missingness, merge results, and important changes in row counts.
- Give each registered output a clear unit and purpose. Avoid several nearly
  identical files whose authority is unclear.

## Production-dataset contract

A registered production dataset should have:

- one owning master command;
- a stable path and unit of observation;
- a documented intended use and important limitations;
- reproducible construction from saved sources;
- checks appropriate to its keys, merges, and coverage.

Keep all useful units and time periods in the main dataset unless there is a
substantive reason to exclude them. Put narrower figure, table, or model
samples downstream.

Before creating another clean dataset, ask whether the new variables belong
in an existing registered dataset. A separate dataset is sensible when its
unit, source restrictions, or purpose really differs.

## Figure and table contract

- New or substantially revised figures and tables should use registered
  production datasets whenever reasonably possible. They may use more than
  one.
- Downstream code may filter, reshape, aggregate, estimate, label, and perform
  well-checked joins.
- Shared variable construction and corrections to the main data belong in the
  owning production builder.
- A reusable measure or join should usually move upstream rather than be
  rebuilt separately by several displays.
- If a display must use raw, scratch, specially built, or unregistered data,
  explain why beside its script and report relevant sample or match losses.
- Improve older displays as they are touched; this policy does not require a
  wholesale rewrite.

## When the interface changes

1. Update the command or dataset entry in `../README.md`.
2. Update the focused source documentation.
3. Confirm that the public master command still owns its prerequisites.
4. Check whether a new output should extend or replace an existing one.
5. Run the master command and inspect its checks.
6. If book output changes, render the book and inspect the generated artifact
   maps.

The README is the inventory source of truth. Focused notes explain definitions
and limits; short agent routers should link here instead of repeating it.
