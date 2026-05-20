# Literature Workflow

Use this note when working with PDFs or source notes in `book/literature/`.

## Goals

- Help agents find relevant sources without filling the context window with irrelevant PDFs.
- Keep source notes short and useful.
- Make citation provenance easy to inspect.

## Workflow

1. Inventory `book/literature/` before reading deeply.
2. Use filenames, existing notes, abstracts, introductions, headings, and search terms to identify likely relevant PDFs.
3. Summarize only the sources and sections needed for the task.
4. Create or update a short `.md` note next to the PDF when the summary is durable.
5. Add citation metadata to `book/citations/agent.bib` only after checking for duplicates and verifying basic metadata.

## Source Note Template

```text
# Citekey Or Short Title

- Status:
- Why it matters:
- Key claims:
- Evidence to verify:
- Used in:
- Citation key:
```

## Corresponding Authors

If a paper uses data that cannot be found publicly, suggest emailing the corresponding author. If the user's agent system is connected to email, draft a short, polite request that identifies the paper, the data sought, and the research purpose.
