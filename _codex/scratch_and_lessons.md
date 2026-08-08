# Scratch work and durable lessons

## Scratch rule

Put temporary work under the repository's `scratch/` folder. This includes:

- one-off probes and debug scripts;
- logs and command output;
- temporary data, joins, audits, and validation exports;
- PDF text or page-image extracts;
- figure and table drafts;
- experimental prose and research packets.

Use a dated, descriptive packet such as
`scratch/2026-08-07-check-figure-labels/`. Put logs under `scratch/logs/`
when they do not belong to a larger packet.

Do not leave `tmp_*`, `temp_*`, `scratch_*`, debug output, or generated logs
in the repository root, data-construction root, manuscript folders, production
code folders, or `_codex/`. A nontrivial scratch packet should contain a short
README stating its purpose, status, source files, and likely permanent home.

Final data builds, figures, tables, prose, and documentation must not depend on
scratch files. Promote approved work to its permanent location and update
paths before treating it as complete.

## Durable lessons

Do not let a reusable discovery remain only in chat or scratch. Add a concise
operational lesson when work reveals:

- a recurring failure mode;
- a non-obvious data or render contract;
- a validation check that caught or would have caught an error;
- a sample-size, unit-count, merge, or missing-data trap;
- a source-access or citation-verification lesson;
- a figure, table, or manuscript practice likely to recur.

Put each lesson in the narrowest relevant focused note. Use
`data_construction/documentation/pipeline-lessons/` for pipeline-specific
behavior. Keep lessons short, current, and actionable. State what a future
agent should check or do.

At handoff, mention the lesson and the file updated. If the task was explicitly
research-only or did not authorize documentation changes, suggest the exact
lesson and destination instead.
