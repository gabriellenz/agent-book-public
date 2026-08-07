# Data construction and replication guide

This folder has one ordinary data-build command:

```text
Rscript build_all.R
```

Run it from `data_construction/`. The command rebuilds every registered
production dataset below and checks important features of the results. A
person reproducing the project should not have to discover and run the
internal builder scripts separately.

The policy behind this layout is
`documentation/replication-policy.md`.

## Registered production datasets

| Dataset | Owning command | Unit | Intended use |
|---|---|---|---|
| `data/clean/toy_umbrella.csv` | `Rscript build_all.R` | town-year | Shared toy data for book figures, tables, and inline statistics |
| `data/clean/toy_umbrella_accounting.csv` | `Rscript build_all.R` | construction step | Row-count checks for the toy build |

This register is deliberately shorter than a listing of every generated file.
A production dataset needs a clear owner, unit of observation, and intended
use.

## Figure and table interface

Book figures, tables, and inline statistics should use the registered
production datasets above whenever those datasets fit the task. They may
filter, reshape, summarize, estimate, label, or join registered datasets when
the keys and checks are clear.

Shared measures and corrections belong in the owning data builder, not in one
figure or table script. Before creating a new clean-data offshoot, ask whether
the needed fields belong in an existing registered dataset. If a display must
use raw, scratch, specially built, or unregistered data, explain why beside
the display script and report any rows or matches lost.

## Source refreshes

The toy source is already archived at
`data/raw/umbrella_observations.csv`. There are no live downloads or
credentialed refresh commands in this example.
