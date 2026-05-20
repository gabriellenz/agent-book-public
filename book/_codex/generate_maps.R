args <- commandArgs(trailingOnly = TRUE)
book_root <- if (nzchar(Sys.getenv("BOOK_ROOT_FOR_MAPS"))) {
  normalizePath(Sys.getenv("BOOK_ROOT_FOR_MAPS"))
} else if (length(args)) {
  normalizePath(args[[1]])
} else {
  normalizePath(".")
}
bookdown_dir <- file.path(book_root, "bookdown")
reports_dir <- file.path(book_root, "_reports")
dir.create(reports_dir, recursive = TRUE, showWarnings = FALSE)

rmd_files <- list.files(bookdown_dir, pattern = "^[0-9].*[.]Rmd$", full.names = TRUE)
rmd_files <- rmd_files[order(basename(rmd_files))]

extract_ref <- function(line, key) {
  pattern <- paste0(key, "=['\"]([^'\"]+)['\"]")
  hit <- regexec(pattern, line)
  val <- regmatches(line, hit)[[1]]
  if (length(val) >= 2) val[[2]] else NA_character_
}

read_text_refs <- function(lines) {
  refs <- list()
  for (line in lines) {
    hit <- regexec("^\\(ref:([^)]+)\\)\\s*(.*)$", line)
    val <- regmatches(line, hit)[[1]]
    if (length(val) >= 3) refs[[val[[2]]]] <- val[[3]]
  }
  refs
}

figures <- list()
tables <- list()
artifacts <- list()

for (chapter_index in seq_along(rmd_files)) {
  path <- rmd_files[[chapter_index]]
  lines <- readLines(path, warn = FALSE)
  refs <- read_text_refs(lines)
  fig_n <- 0
  tab_n <- 0

  for (line in lines) {
    if (!grepl("^```\\{r ", line)) next
    label <- sub("^```\\{r\\s+([^,} ]+).*$", "\\1", line)
    source_file <- extract_ref(line, "file")
    fig_cap <- extract_ref(line, "fig.cap")
    caption_ref <- extract_ref(line, "caption_ref")

    if (!is.na(fig_cap)) {
      cap_key <- sub("^\\(ref:([^)]+)\\)$", "\\1", fig_cap)
      fig_n <- fig_n + 1
      figures[[length(figures) + 1]] <- data.frame(
        number = paste0(chapter_index, ".", fig_n),
        chunk = label,
        caption = if (!is.null(refs[[cap_key]])) refs[[cap_key]] else cap_key,
        source = ifelse(is.na(source_file), basename(path), source_file)
      )
    }

    if (!is.na(caption_ref) || (!is.na(source_file) && grepl("/tables/|\\\\tables\\\\", source_file))) {
      tab_n <- tab_n + 1
      cap_key <- ifelse(is.na(caption_ref), label, caption_ref)
      tables[[length(tables) + 1]] <- data.frame(
        number = paste0(chapter_index, ".", tab_n),
        chunk = label,
        caption = if (!is.null(refs[[cap_key]])) refs[[cap_key]] else cap_key,
        source = ifelse(is.na(source_file), basename(path), source_file)
      )
    }

    if (!is.na(source_file) && grepl("/chunks/|\\\\chunks\\\\", source_file)) {
      artifacts[[length(artifacts) + 1]] <- data.frame(
        type = "inline chunk",
        chunk = label,
        source = source_file
      )
    }
  }
}

write_map <- function(path, title, rows, prefix) {
  out <- c(paste0("# ", title), "")
  if (!length(rows)) {
    out <- c(out, "No entries found.")
  } else {
    df <- do.call(rbind, rows)
    if ("number" %in% names(df)) {
      out <- c(out, "| Number | Chunk | Caption | Source |", "| --- | --- | --- | --- |")
      out <- c(out, apply(df, 1, function(x) paste0("| ", prefix, " ", x[["number"]], " | `", x[["chunk"]], "` | ", x[["caption"]], " | `", x[["source"]], "` |")))
    } else {
      out <- c(out, "| Type | Chunk | Source |", "| --- | --- | --- |")
      out <- c(out, apply(df, 1, function(x) paste0("| ", x[["type"]], " | `", x[["chunk"]], "` | `", x[["source"]], "` |")))
    }
  }
  writeLines(out, path)
}

write_map(file.path(reports_dir, "figure_map.md"), "Figure Map", figures, "fig.")
write_map(file.path(reports_dir, "table_map.md"), "Table Map", tables, "table")
write_map(file.path(reports_dir, "artifact_map.md"), "Artifact Map", artifacts, "")

message("Wrote maps to ", reports_dir)
