# Manuscript and display style

Use this note for reader-facing prose, headings, captions, tables, axes, and
labels. Apply it to new material and to passages already being revised. Do not
run a book-wide normalization pass unless the user asks.

## Core stance

- Write for an intelligent reader who does not need to know the project's file
  layout or variable names.
- Prefer direct sentences, concrete actors, and meaningful quantities.
- Distinguish evidence, interpretation, mechanism, and limitation.
- Preserve vivid, well-supported details. Remove machinery that belongs in
  code, methods notes, or appendices.
- Keep the author's voice and citation placement when making small edits.

## Capitalization

- Use sentence case for section headings below the chapter title, run-in
  headings, figure captions, table titles, axis labels, legends, and bullet
  lead-ins.
- Use title case for actual titles of books, articles, periodicals,
  organizations, and formal names.
- Capitalize only the first word and proper nouns in descriptive labels.
- Preserve the official capitalization of a cited work.

## Headings and structure

- Each chapter begins with a level-one heading.
- Make headings informative rather than generic. Prefer a claim, question, or
  concrete subject to `Background` or `More results`.
- Keep run-in headings short.
- Do not add process banners such as `Drafting instructions` to manuscript
  prose.
- Use stable automatic cross-references rather than typing figure, table, or
  appendix numbers by hand.

## Captions and labels

- Let captions identify the quantity, population or unit, and time period when
  those are not obvious.
- A caption may state the main takeaway, but should not repeat every fact
  already visible in the display.
- Put methods, sample restrictions, and important category differences in the
  caption or note when readers need them to interpret the display.
- Keep series names and axis labels short, concrete, and reader-facing.
- Include units in axis labels and table headings.
- Define abbreviations in a note unless they are universally familiar to the
  intended audience.

## Numbers and statistical language

- Do not put Markdown code formatting around ordinary years, counts,
  percentages, rates, page numbers, or monetary amounts.
- Reserve backticks for code, commands, paths, chunk labels, literal variable
  names, and inline R expressions.
- Round main-text numbers enough to be memorable; retain greater precision in
  tables, appendices, or hidden calculations when it matters.
- Name the substantive concept in prose rather than the code variable.
- Translate coefficients and uncertainty into meaningful contrasts. Follow
  `book/_codex/empirical_writing.md`.
- Do not use causal language for a descriptive pattern without a defensible
  design and an explicit argument.

## Editing policy

- Make the smallest edit that fully solves the problem.
- Preserve citations, quotation wording, chunk labels, caption references,
  and inline calculations unless the task requires changing them.
- Do not silently strengthen a claim, generalize beyond the evidence, or turn
  lack of evidence into evidence of absence.
- For quotations, preserve exact wording and attach a printed-page or reliable
  PDF-page locator when available.
- After a bulk or scripted rewrite, inspect the diff and scan for encoding
  damage, broken citations, malformed Markdown, and unintended changes inside
  code blocks.
