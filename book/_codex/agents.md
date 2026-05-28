# Book Agent Index

## Start Here

- Bookdown structure and paths: `book/_codex/bookdown_rules.md`
- Figures, tables, and inline chunks: `book/_codex/figures_tables.md`
- Empirical-result prose, null effects, coefficient interpretation, and effect-size writing: `book/_codex/empirical_writing.md`
- Data interface: `book/_codex/data.md`
- Citations: `book/_codex/library.md`
- Literature/PDF workflow: `book/_codex/literature_workflow.md`
- Wiki/concept notes: `book/wiki/AGENTS.md`
- End-of-task checks: `book/_codex/definition_of_done.md`

## Do Not Miss

- `chapters/` is the manuscript source of truth.
- `bookdown/` is the render wrapper.
- `analysis/chXX/` holds book-facing R code.
- Preserve chunk labels and captions unless explicitly asked.
- Use generated maps in `_reports/` to resolve figure/table numbers, owners, labels, captions, and source files.
- `book/_codex/generate_maps.R` is the only map generator in this template. It runs after the render and writes `figure_map.md`, `table_map.md`, and `artifact_map.md`.
- When a user asks for a rendered figure or table number, look it up in the maps, then edit by stable label/source file. Do not rely on remembered numbering from an earlier render.
- Keep PDF work selective: inventory first, then summarize only sources relevant to the task.
