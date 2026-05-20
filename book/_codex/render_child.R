args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) stop("Usage: render_child.R <bookdown_dir> <pdf|html>")

bookdown_dir <- normalizePath(args[[1]])
format <- args[[2]]

if (!nzchar(Sys.getenv("RSTUDIO_PANDOC"))) {
  pandoc_candidates <- c(
    "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools",
    "C:/Program Files/RStudio/bin/pandoc"
  )
  pandoc_hit <- pandoc_candidates[dir.exists(pandoc_candidates)]
  if (length(pandoc_hit)) Sys.setenv(RSTUDIO_PANDOC = pandoc_hit[[1]])
}

setwd(bookdown_dir)
dir.create("_book", recursive = TRUE, showWarnings = FALSE)
output_format <- switch(
  format,
  pdf = "bookdown::pdf_book",
  html = "bookdown::html_book",
  stop("Unknown render format: ", format)
)

bookdown::render_book("index.Rmd", output_format = output_format, quiet = FALSE)
