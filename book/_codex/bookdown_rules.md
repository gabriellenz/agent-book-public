# Bookdown Rules

- `bookdown/index.Rmd` contains the whole-book YAML.
- `bookdown/_bookdown.yml` controls chapter order.
- Chapter source files live in `chapters/` and are copied into `bookdown/` by `render_book.R`.
- Use forward-slash relative paths.
- Use chunk labels for cross-references: `\@ref(fig:chunk-label)` and `\@ref(tab:chunk-label)`.
- Keep figure/table captions in the chapter file when possible.
- Externalized code uses chunk option `file="analysis/chXX/.../chunk-name.R"`.
- Render from the repo root using the included render script for the user's platform.
- Some Bookdown/R installations return a nonzero process status after writing the expected output. Before treating a render as failed, check whether `output/book.pdf` or `output/index.html` exists.
- `book/_codex/generate_maps.R` runs after render and writes the public lookup maps in `book/_reports/`. Keep it as the single map generator unless you are replacing the whole map workflow.
- If you add appendices, keep them in `_bookdown.yml` order and preserve stable section, figure, and table labels. Appendix letters in rendered output are user-facing; labels and source files are the stable handles agents should edit through.
