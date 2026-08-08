# Wiki Workflow

Use this note when working in `book/wiki/`. Keep `AGENTS.md` short and put operational detail here.

## Purpose

- Build around the manuscript's concepts, mechanisms, alternative explanations, and conceptual tensions, not around whatever topics individual sources emphasize most.
- Treat the wiki as a thinking aid for the manuscript. It should help identify what the project might be missing, where an argument is too narrow, which rival explanations deserve attention, and which literatures change how a chapter should be framed.
- Use the wiki to synthesize across PDFs, source notes, and manuscript sections. Agents are good at reading a folder of sources, finding recurring concepts, and drafting short pages that explain how those ideas connect.
- Favor synthesis, comparison, and explicit uncertainty over source-by-source summaries.

## Topic Folder Structure

Use one numbered folder per durable wiki topic, directly under `book/wiki/`.

```text
wiki/
  0100_<topic-slug>/
    index.md
    <concept-or-idea>.md
    <concept-or-idea>.md
    open_questions.md
    outputs/
  0200_<topic-slug>/
    index.md
    <concept-or-idea>.md
    open_questions.md
```

- Number folders by the order the theme first becomes important in the manuscript, not by creation date or perceived importance.
- Use stable four-digit prefixes such as `0100`, `0200`, and `0300`, leaving room to insert later topics between existing folders.
- `index.md` states the topic's manuscript relevance and links the most important pages.
- The main contents of each topic folder are Markdown pages for individual concepts, ideas, mechanisms, comparisons, distinctions, tensions, rival explanations, objections, and boundary conditions.
- `open_questions.md` records unresolved questions and next searches.
- `outputs/` holds generated memos, slide drafts, figures, or query results that should remain attached to the topic.

## Source Handling

- Start with `book/literature/`, source notes, and the relevant manuscript sections.
- Do not recursively load every PDF by default. Inventory the folder first, identify likely relevant sources, then read selectively.
- Prioritize sources by direct relevance, evidence quality, and ability to
  resolve an important question. Citation counts can help prioritize, but do
  not replace substantive judgment; a local, archival, or primary source may
  be decisive even when little cited.
- Do not create separate source-ledger pages such as `sources.md`.
- Every substantive factual claim should point back inline to a source note, citekey, PDF, manuscript section, or source file.
- Put source references where they do interpretive work: next to the claim, mechanism, contrast, alternative explanation, or question they support.
- When building wiki pages from sources, pull only a few short, concrete quotes. Prefer quotes that preserve the author's exact mechanism, striking formulation, or evidentiary detail, and attach page numbers or PDF-page markers when available.
- For important claims, summarize the evidence the source uses—not only its
  conclusion. Note the data, cases, comparisons, examples, tables, figures,
  archives, interviews, or reasoning that carry the claim.
- Separate verified evidence from interpretation, speculation, and open questions.
- Mark source-access limits clearly: metadata-only, abstract-only, snippet-only, partial PDF, full-text checked, or uncertain.
- Do not duplicate canonical source notes. Link to them and synthesize across them.

## Research Workflow

1. State the manuscript question and the claims, mechanisms, or rival
   explanations to test.
2. Check the relevant manuscript section, wiki index, open questions, and
   local literature notes before searching elsewhere.
3. Brainstorm likely source types and search terms for claims, actors,
   institutions, places, dates, and quotations.
4. Search broadly enough to find disagreement and boundary conditions, then
   verify the most important material in full text or primary records.
5. Draft concept-centered pages that synthesize across sources.
6. Mark direct evidence, plausible interpretation, unresolved inference, and
   contrary evidence separately.
7. Update `index.md` and `open_questions.md` so later agents can find both the
   synthesis and the remaining gaps.

Stop when the evidence is sufficient for the question. Do not let a minor
locator or inaccessible source prevent a bounded conclusion when the
limitation can be recorded honestly.

## Retrieval Backlog

- Keep one short, ranked list of high-value inaccessible sources in
  `open_questions.md` unless the topic already has a clearly named priority
  page.
- For each target, record the source, exact question it could answer, why it
  matters, current access status, failed route and date, and best next step.
- Rank by expected contribution to the argument, not ease of access.
- Deduplicate by DOI, edition, or title-author identity. Update an existing
  item rather than creating another ledger.
- Remove or mark a target complete when access is obtained and update the
  canonical source note.

## Scratch and Promotion

- Put searches, extracts, intermediate memos, OCR, screenshots, and
  exploratory synthesis under `scratch/`.
- When scratch research becomes useful, promote the evidence into canonical
  source notes and the synthesis into the relevant wiki pages. Add links from
  `index.md` and cite or link the underlying source.
- Final wiki claims must not depend on an unexplained scratch file.
- Add durable research-workflow lessons to the narrowest focused note and
  mention them at handoff.

## Relationship To The Manuscript

- When a wiki page has manuscript implications, name the relevant chapter, section, figure, table, or claim if known.
- If the implication is uncertain, say what would need to be checked before changing prose.
- Durable chapter-specific research notes can live elsewhere; wiki pages may point to them but should not replace them.
- Do not change manuscript prose merely because a wiki implication seems
  promising. Verify the source and wait for authorization when the task is
  research-only.
