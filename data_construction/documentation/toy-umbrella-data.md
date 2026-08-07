# Toy Umbrella Data

This is fake data for demonstrating the workflow.

- Raw input: `data/raw/umbrella_observations.csv`
- Ordinary build command: `Rscript build_all.R`
- Internal builder: `builders/build_toy_umbrella_data.R`
- Clean output: `data/clean/toy_umbrella.csv`
- Accounting output: `data/clean/toy_umbrella_accounting.csv`

The master command builds both registered outputs and checks their expected
columns, town-year key, usable-row rule, and row accounting. The internal
builder reports original rows, retained rows, and lost rows so the example
models the habit of checking sample changes.
