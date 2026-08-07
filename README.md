# Helping Agents Work on Books, Articles, and Dissertations

This folder contains agent instructions, helper files, and a project structure developed for writing a data-driven book. The same workflow can also help with academic articles, dissertations, and other long research manuscripts that combine prose, citations, figures, tables, and code.

The basic idea is simple: keep prose, manuscript-facing code, data construction, notes, and agent instructions in predictable places so you can ask an agent to work on a chapter, section, figure, table, citation, model result, or data problem without dumping the whole project into context.

I have used this setup mainly with Codex. It should work with other coding agents, including Claude Code, but I have not tested those workflows as carefully. I would be glad to hear what breaks, what transfers cleanly, and what other agents need documented differently.

So you can see how it all works, this repo includes placeholder chapters in `book/chapters/` and fake data in the data folders. You can ask an agent to render the toy book, inspect the output, and start modifying those chapters. For an article, you can pare the manuscript down to a single chapter and ask the agent to adapt the structure around that shorter project.

## August 2026 Update

This template already kept source data separate from clean data and used a
shared clean dataset for the toy book. This update makes those instructions
clearer and more consistent for agents.

The revised instructions now spell out where shared data work belongs, which
command rebuilds the book's main datasets, and how figures and tables should
use those datasets. The toy example demonstrates the full path with one
easy-to-find command. The figure guidance is also clearer about simple,
readable design and about checking that filters or display choices do not hide
important observations.

## What Makes This Work

- R Markdown / Bookdown. Chapters are `.Rmd` files, rendered by Bookdown, with citations, cross-references, figures, tables, and inline R values.
- A manuscript source of truth. Drafting happens in `book/chapters/`; `book/bookdown/` is the render wrapper.
- Externalized chunks. Figure, table, and inline-stat code lives in `book/analysis/chXX/...`, so agents can edit one artifact without rewriting a whole chapter.
- Figure/table lookup reports. After render, reports in `book/_reports/` connect rendered-style numbers to the owning chapter or appendix, stable Bookdown labels, captions, and source files. That lets you say things like "fix fig. 1.1" and the agent can find the code.
- Figure and regression-table guidance. Focused notes in `book/_codex/` tell agents how to format figures and manuscript regression tables cleanly, including dependent-variable headers, coefficient/confidence-interval rows, model notes, weights, and fit statistics.
- Empirical writing guidance. Focused notes tell agents how to write about statistical findings, translate model coefficients into meaningful contrasts, and discuss null effects in terms of what effect sizes can plausibly be ruled out.
- Reproducible data work. Dataset cleaning, coding, and assembly follow a
  documented path from saved raw files to shared clean datasets. A small
  number of commands rebuild those datasets, and the book's figures, tables,
  and statistics use them directly. This makes it much easier for other
  people to trace the code behind a finding, check the decisions that shaped
  it, and reproduce the result.
- Literature workflow. PDFs live in `book/literature/`, with helper notes/scripts that let agents inventory sources and summarize only what matters instead of stuffing full articles into the context window.
- Wiki workflow. `book/wiki/` is for agent-maintained concept notes that connect literatures, recurring ideas, mechanisms, rival explanations, and manuscript sections. Agents are especially useful here: they can inventory folders of PDFs, identify the concepts that keep reappearing, and draft short wiki pages about how those ideas fit together.
- Citation workflow. BibTeX files live in `book/citations/`, split between author-managed and agent-added sources. Agents check citation metadata against services like Crossref or a primary source record so authors, titles, journals, books, years, and DOIs are not hallucinated. That does not prove the sentence using the citation is right, but you can also ask the agent to check that against the source.
- Durable lessons. When agents learn something reusable, they add it to focused notes or pipeline lessons instead of leaving it buried in chat history.
- Short agent instructions. `AGENTS.md` files route agents to focused notes instead of filling the context window with every rule.
- Relative paths. The project should work after cloning into a different folder on Windows, macOS, or Linux.

## Folder Map

```text
book/
  chapters/               # manuscript source files edited by author + agent
  citations/              # author.bib and agent.bib
  literature/             # PDFs and literature notes
  wiki/                   # agent-maintained concept and literature-synthesis notes
  bookdown/               # Bookdown render wrapper
  analysis/               # book-facing figures, tables, inline chunks
  data/                   # clean data copied here for rendering
  _reports/               # generated figure/table/artifact lookup reports

data_construction/
  build_all.R             # ordinary command that rebuilds the main data
  builders/               # internal steps called by the master command
  data/raw/               # raw/source-like inputs; do not overwrite in code
  data/clean/             # shared clean datasets
  README.md               # guide to build commands and shared datasets
  documentation/          # source notes and pipeline lessons
```

## Dependencies

This template depends on several tools, but you do not need to manage them by hand. In practice, point your agent at this repository and ask it to install or verify the dependencies.

The dependency list is:

- R
- Pandoc, usually bundled with RStudio or Quarto
- R packages: `bookdown`, `knitr`, `rmarkdown`
- Python 3, used by the optional literature inventory helper
- LaTeX is optional. Install a TeX distribution such as TinyTeX, MacTeX, or MiKTeX if you want PDF output. Without LaTeX, use the HTML fallback.

For agents: dependency check scripts are included at the repo root. Use the script appropriate for the user's machine, or call `Rscript dependencies.R` directly. The repo includes PowerShell wrappers for Windows and shell wrappers for macOS/Linux. Pandoc must be discoverable on `PATH` or through `RSTUDIO_PANDOC`; the scripts check common RStudio and Quarto locations on Windows, macOS, and Linux.

## Render The Toy Book

To render the book, just ask your agent to render it. The agent instructions point it to the render scripts and the dependency checker.

The script:

1. runs the registered master data-build command
2. builds and checks the toy clean datasets from
   `data_construction/data/raw/`
3. copies chapters from `book/chapters/` into `book/bookdown/`
4. copies book-facing code and registered data into the render wrapper
5. renders the Bookdown project
6. writes maps to `book/_reports/` with figure/table numbers, owners, labels, captions, and source files

The PDF is written to:

```text
output/book.pdf
```

If PDF rendering fails because LaTeX is not installed, the script tries an HTML render. The HTML output is:

```text
output/index.html
```

## How To Talk To The Book

Here are some examples of how to talk to your book through your agent:

- "Render the book and tell me where the PDF is."
- "I have just been editing chapter 2, lines 45 through 55. Could you proofread that passage and correct minor mistakes?"
- "Bring all section headings in the entire book, including the appendices, into line with the style guide; they should be sentence case."
- "Increase the size of fig. 1.1 and change the fitted line to a loess smoother."
- "Update the umbrella summary table and report the sample size."
- "Add a shared measure to the main toy dataset, rebuild it, and use it in a new figure."
- "Show me the raw data behind the sentence about the average number of umbrellas."
- "On line 589, add a paragraph discussing the null finding for this variable and what effect sizes the confidence interval lets us plausibly rule out."
- "Rewrite the paragraph about the model results so it translates the coefficient into a concrete 10th-to-90th percentile contrast and compares that with the outcome variation."
- "Check whether any rows were lost when building the clean data."

The small reports in `book/_reports/` are what let you talk naturally about the rendered book. You can say "fix fig. 1.1," and the agent can look up which owner, label, caption, and source file produced that figure. Rendered figure and table numbers can change; labels and source files are the stable parts.

## Advice For Agent-Assisted Research

- Avoid giving agents impossible goals to meet, such as "merge every row" or "make everything match." Ask them to merge accurately, report unmatched rows, explain why they did not match, and suggest defensible follow-up checks.
- Outsource labor, exploration, and even thinking, **but not understanding**. You still need to understand and vet the data construction, sample restrictions, model results, and prose.

## Literature And PDFs

Put PDFs in `book/literature/`. Agents can inventory that folder, create short source notes, and summarize only the PDFs or sections that matter for the task. This keeps irrelevant articles from filling the context window.

If your agent system is connected to email, the instructions can also prompt agents to draft or send polite requests to corresponding authors when a paper uses data that are not publicly available.

## Wiki Notes

Use `book/wiki/` when you want agents to help build a lightweight knowledge base around the manuscript. This is useful when a project has several literatures that need to be connected, or when a concept appears in different sources under different names.

The wiki is not meant to be a pile of source summaries. A good wiki page explains a concept, mechanism, tension, rival explanation, or open question; links it back to sources and manuscript sections; and says what would need to be checked before changing the prose. The agent can help by reading PDFs selectively, finding recurring ideas, and drafting pages that make those connections easier to see.

## Using Obsidian

I have started using Obsidian to edit R Markdown files in `book/chapters/` instead of RStudio because the writing surface is lighter, cleaner, and more elegant for long prose.

Reasons it works well with agents:

- When an agent edits a file, the new text appears quickly in the R Markdown document.
- Community plugins make it highly adaptable; agents can help configure plugin settings when you want the editor to fit your workflow better.

## PDF Reader

I use SumatraPDF on Windows because it stays on the same page and refreshes when a new PDF is rendered. That makes the edit-render-review loop faster. These tools are convenient, not required.
