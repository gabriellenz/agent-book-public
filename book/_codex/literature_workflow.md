# Literature Workflow

Use this note when working with PDFs or source notes in `book/literature/`.

## Goals

- Help agents find relevant sources without filling the context window with irrelevant PDFs.
- Keep source notes short and useful.
- Make citation provenance easy to inspect.

## Workflow

1. Inventory `book/literature/` before reading deeply.
2. Search filenames, existing notes, abstracts, introductions, headings, and
   the exact concepts or mechanisms in the question.
3. Rank likely sources by relevance and evidentiary value before spending time
   on full-text reading.
4. Read only the sources and sections needed for the task.
5. Verify important claims and quotations against the PDF page, not only
   extracted text.
6. Create or update a short `.md` note next to the PDF when the summary is
   durable.
7. Add citation metadata to `book/citations/agent.bib` only after checking for
   duplicates and verifying the complete record.

## Extraction

- Put temporary PDF text, OCR, screenshots, and page renders under
  `scratch/`.
- Use `pdftotext` when the PDF has usable text and retain visible page
  boundaries in any extraction used for quote hunting.
- Render only the pages needed when tables, figures, scans, or page layout
  matter. Do not rasterize a whole library by default.
- Treat machine-extracted text as a search aid. Check the source page before
  using a quotation or a page-specific claim.
- Promote only durable source notes and lawful local source files into
  `book/literature/`.

## Source Note Template

```text
# Citekey Or Short Title

- Status:
- Why it matters:
- Key claims:
- Evidence to verify:
- Used in:
- Citation key:
- Access and verification limits:
```

## Corresponding Authors

If a paper uses data that cannot be found publicly, suggest emailing the
corresponding author. Draft a short, polite request that identifies the paper,
the material sought, and the research purpose. Do not send it without the
user's authorization.
