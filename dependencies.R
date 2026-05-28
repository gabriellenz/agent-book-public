required_r_packages <- c("bookdown", "knitr", "rmarkdown")

missing <- required_r_packages[
  !vapply(required_r_packages, requireNamespace, logical(1), quietly = TRUE)
]

cat("R version:", R.version.string, "\n")

if (length(missing)) {
  cat("Missing R packages:", paste(missing, collapse = ", "), "\n")
  cat("Install with:\n")
  cat("install.packages(c(", paste(sprintf('\"%s\"', missing), collapse = ", "), "))\n", sep = "")
  quit(save = "no", status = 1)
}

cat("Required R packages are installed:", paste(required_r_packages, collapse = ", "), "\n")

python <- Sys.which("python")
if (!nzchar(python)) {
  python <- Sys.which("python3")
}

if (nzchar(python)) {
  cat("Python available for optional literature helper scripts:", python, "\n")
} else {
  cat("Python not found. Book rendering can still work, but optional literature helper scripts may not run.\n")
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

pandoc <- rmarkdown::pandoc_available()
cat("Pandoc available:", pandoc, "\n")

if (!pandoc) {
  cat("Install RStudio, Quarto, or Pandoc before rendering.\n")
  quit(save = "no", status = 1)
}

cat("Dependency check passed.\n")
quit(save = "no", status = 0)
