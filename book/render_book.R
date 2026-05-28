args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_path <- if (length(file_arg)) normalizePath(sub("^--file=", "", file_arg[[1]])) else normalizePath("book/render_book.R")
book_root <- normalizePath(dirname(script_path))
repo_root <- normalizePath(file.path(book_root, ".."))
bookdown_dir <- file.path(book_root, "bookdown")

required <- c("bookdown", "knitr", "rmarkdown")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) {
  stop("Install required R packages first: ", paste(missing, collapse = ", "))
}

set_pandoc_env <- function() {
  if (nzchar(Sys.getenv("RSTUDIO_PANDOC"))) return(invisible(TRUE))

  path_pandoc <- Sys.which("pandoc")
  if (nzchar(path_pandoc)) {
    Sys.setenv(RSTUDIO_PANDOC = dirname(path_pandoc))
    return(invisible(TRUE))
  }

  pandoc_candidates <- c(
    "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools",
    "C:/Program Files/RStudio/bin/pandoc",
    "/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools",
    "/Applications/RStudio.app/Contents/Resources/app/bin/pandoc",
    "/Applications/Quarto.app/Contents/Resources/app/bin/tools",
    "/opt/quarto/bin/tools",
    "/usr/lib/rstudio/resources/app/bin/quarto/bin/tools",
    "/usr/lib/rstudio/resources/app/bin/pandoc"
  )
  pandoc_hit <- pandoc_candidates[dir.exists(pandoc_candidates)]
  if (length(pandoc_hit)) Sys.setenv(RSTUDIO_PANDOC = pandoc_hit[[1]])
  invisible(length(pandoc_hit) > 0)
}

set_pandoc_env()

message("Building toy clean data...")
build_script <- file.path(repo_root, "data_construction", "code", "build_toy_umbrella_data.R")
status <- system2(file.path(R.home("bin"), "Rscript"), shQuote(build_script))
if (!identical(status, 0L)) stop("Data construction failed.")

copy_clean <- function(from, to) {
  if (dir.exists(to)) unlink(to, recursive = TRUE)
  dir.create(to, recursive = TRUE, showWarnings = FALSE)
  files <- list.files(from, full.names = TRUE, all.files = FALSE)
  if (length(files)) invisible(file.copy(files, to, recursive = TRUE))
}

message("Preparing Bookdown render folder...")
invisible(file.copy(
  list.files(file.path(book_root, "chapters"), pattern = "[.]Rmd$", full.names = TRUE),
  bookdown_dir,
  overwrite = TRUE
))
copy_clean(file.path(book_root, "citations"), file.path(bookdown_dir, "citations"))
copy_clean(file.path(book_root, "analysis"), file.path(bookdown_dir, "analysis"))
copy_clean(file.path(repo_root, "data_construction", "data", "clean"), file.path(book_root, "data"))
copy_clean(file.path(book_root, "data"), file.path(bookdown_dir, "data"))
unlink(c(
  Sys.glob(file.path(bookdown_dir, "book.*")),
  file.path(bookdown_dir, "book_files")
), recursive = TRUE, force = TRUE)
unlink(file.path(repo_root, "output"), recursive = TRUE, force = TRUE)

oldwd <- getwd()
setwd(bookdown_dir)
on.exit(setwd(oldwd), add = TRUE)

run_child_render <- function(format) {
  child <- file.path(book_root, "_codex", "render_child.R")
  rscript <- file.path(R.home("bin"), if (.Platform$OS.type == "windows") "Rscript.exe" else "Rscript")
  system2(rscript, c(shQuote(child), shQuote(bookdown_dir), format))
}

message("Rendering PDF...")
pdf_status <- run_child_render("pdf")
pdf_path <- file.path(bookdown_dir, "_book", "book.pdf")
pdf_root_path <- file.path(bookdown_dir, "book.pdf")
pdf_ok <- file.exists(pdf_path) || file.exists(pdf_root_path)

if (!pdf_ok) {
  message("PDF render did not produce an expected PDF.")
  message("Trying HTML render instead...")
  html_status <- run_child_render("html")
  html_path <- file.path(bookdown_dir, "_book", "index.html")
  if (!file.exists(html_path)) stop("HTML render failed with status ", html_status)
} else if (!identical(pdf_status, 0L)) {
  message("PDF tool returned status ", pdf_status, " after writing the PDF; continuing because the expected PDF exists.")
}

message("Generating figure/table maps...")
Sys.setenv(BOOK_ROOT_FOR_MAPS = book_root)
source(file.path(book_root, "_codex", "generate_maps.R"), local = TRUE)

output_dir <- file.path(repo_root, "output")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

pdf_candidates <- c(
  file.path(bookdown_dir, "_book", "book.pdf"),
  file.path(bookdown_dir, "book.pdf")
)
pdf_candidates <- pdf_candidates[file.exists(pdf_candidates)]
if (length(pdf_candidates)) {
  file.copy(pdf_candidates[[1]], file.path(output_dir, "book.pdf"), overwrite = TRUE)
  message("PDF: ", file.path(output_dir, "book.pdf"))
}

html_candidates <- c(
  file.path(bookdown_dir, "_book", "index.html"),
  file.path(bookdown_dir, "book.html")
)
html_candidates <- html_candidates[file.exists(html_candidates)]
if (length(html_candidates)) {
  file.copy(html_candidates[[1]], file.path(output_dir, "index.html"), overwrite = TRUE)
  message("HTML: ", file.path(output_dir, "index.html"))
}

quit(save = "no", status = 0)
