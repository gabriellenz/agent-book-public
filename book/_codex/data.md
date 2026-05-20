# Book Data Interface

- Book-facing code reads from `bookdown/data/` during render.
- `render_book.R` copies clean data from `data_construction/data/clean/` into `book/data/`, then into `bookdown/data/`.
- New data acquisition belongs in `data_construction/`, not in chapter chunks.
- For APIs or packages, save a local raw copy and keep credentials outside the repo.
