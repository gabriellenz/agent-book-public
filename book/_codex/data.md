# Book Data Interface

- Book-facing code reads shared clean data directly from
  `data_construction/data/clean/` during render.
- External scripts run in the `book/bookdown/` knit context, so their relative
  path to the shared clean-data folder begins
  `../../data_construction/data/clean/`.
- `render_book.R` rebuilds the clean data before rendering; it does not keep a
  second book-side copy.
- Do not recreate `book/data/` or `book/bookdown/data/`. The registered clean
  files under `data_construction/data/clean/` are the single source used by
  book figures, tables, and inline statistics.
- New data acquisition belongs in `data_construction/`, not in chapter chunks.
- For APIs or packages, save a local raw copy and keep credentials outside the repo.
- Treat `data_construction/README.md` as the source of truth for registered
  production datasets and their owning commands. Follow
  `data_construction/documentation/replication-policy.md` when a book change
  needs a new or revised data interface.
- Book code should use registered production datasets whenever reasonably
  possible. It may use several registered inputs and may filter, reshape,
  aggregate, estimate, label, or perform a well-checked join.
- Keep shared measure construction and corrections in the owning data builder.
  Explain and validate any reliance on raw, scratch, specially built, or
  unregistered data beside the book script.
