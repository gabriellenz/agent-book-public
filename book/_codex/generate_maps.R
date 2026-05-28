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

read_bookdown_order <- function(path) {
  if (!file.exists(path)) return(character())
  lines <- readLines(path, warn = FALSE)
  start <- grep("^rmd_files\\s*:", lines)
  if (!length(start)) return(character())
  if (start[[1]] >= length(lines)) return(character())

  out <- character()
  for (line in lines[(start[[1]] + 1):length(lines)]) {
    if (grepl("^[^[:space:]-].*:", line)) break
    hit <- regexec("^\\s*-\\s*['\"]?([^'\"]+[.]Rmd)['\"]?\\s*$", line)
    val <- regmatches(line, hit)[[1]]
    if (length(val) >= 2) out <- c(out, val[[2]])
  }
  out
}

rmd_names <- read_bookdown_order(file.path(bookdown_dir, "_bookdown.yml"))
if (!length(rmd_names)) {
  rmd_names <- list.files(bookdown_dir, pattern = "[.]Rmd$")
  rmd_names <- rmd_names[order(rmd_names)]
}
rmd_names <- rmd_names[basename(rmd_names) != "index.Rmd"]
rmd_files <- file.path(bookdown_dir, rmd_names)
rmd_files <- rmd_files[file.exists(rmd_files)]

source_chapters <- file.path(book_root, "chapters", basename(rmd_files))
source_chapters <- source_chapters[file.exists(source_chapters)]
if (length(source_chapters)) {
  copied <- file.path(bookdown_dir, basename(source_chapters))
  stale <- file.exists(copied) &
    as.numeric(difftime(file.mtime(source_chapters), file.mtime(copied), units = "secs")) > 1
  if (any(stale)) {
    stop(
      "Bookdown chapter copies are older than book/chapters. ",
      "Run the included render script so maps are generated from the rendered inputs."
    )
  }
}

render_outputs <- c(
  file.path(bookdown_dir, "book.pdf"),
  file.path(bookdown_dir, "_book", "book.pdf"),
  file.path(bookdown_dir, "book.html"),
  file.path(bookdown_dir, "_book", "index.html")
)
render_outputs <- render_outputs[file.exists(render_outputs)]
if (!length(render_outputs)) {
  stop("No rendered output found. Run the included render script before generating maps.")
}
latest_render <- max(file.mtime(render_outputs))
if (length(rmd_files) && any(as.numeric(difftime(file.mtime(rmd_files), latest_render, units = "secs")) > 1)) {
  stop("Rendered output is older than the Bookdown inputs. Rerender before generating maps.")
}

extract_ref <- function(line, key) {
  pattern <- paste0(key, "\\s*=\\s*['\"]([^'\"]+)['\"]")
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

first_heading <- function(lines) {
  hits <- grep("^#\\s+", lines)
  if (!length(hits)) return("Untitled")
  title <- sub("^#\\s+", "", lines[[hits[[1]]]])
  title <- gsub("\\s*\\{[^}]+\\}\\s*$", "", title)
  title <- gsub("\\(APPENDIX\\)", "", title, fixed = TRUE)
  trimws(title)
}

resolve_caption <- function(value, refs) {
  if (is.na(value) || !nzchar(value)) return("")
  hit <- regexec("^\\(ref:([^)]+)\\)$", value)
  val <- regmatches(value, hit)[[1]]
  if (length(val) >= 2) {
    key <- val[[2]]
    if (!is.null(refs[[key]])) return(refs[[key]])
    return(key)
  }
  value
}

source_target <- function(source_file, chapter_path) {
  if (!is.na(source_file) && nzchar(source_file)) {
    return(gsub("\\\\", "/", source_file))
  }
  paste0("chapters/", basename(chapter_path))
}

escape_md <- function(value) {
  value <- ifelse(is.na(value), "", as.character(value))
  value <- gsub("\\|", "\\\\|", value)
  value <- gsub("\r?\n", " ", value)
  value
}

row <- function(...) data.frame(..., stringsAsFactors = FALSE)

figures <- list()
tables <- list()
inline_chunks <- list()

chapter_n <- 0
appendix_mode <- FALSE
appendix_n <- 0

for (path in rmd_files) {
  lines <- readLines(path, warn = FALSE)
  title <- first_heading(lines)
  has_chunks <- any(grepl("^```\\{r\\s+", lines))

  if (any(grepl("\\(APPENDIX\\)", lines))) {
    appendix_mode <- TRUE
    if (!has_chunks) next
  }

  if (appendix_mode) {
    appendix_n <- appendix_n + 1
    owner_id <- LETTERS[[appendix_n]]
    owner <- paste0("Appendix ", owner_id, ": ", title)
  } else {
    chapter_n <- chapter_n + 1
    owner_id <- as.character(chapter_n)
    owner <- paste0("Chapter ", owner_id, ": ", title)
  }

  refs <- read_text_refs(lines)
  fig_n <- 0
  tab_n <- 0

  for (line in lines) {
    if (!grepl("^```\\{r\\s+", line)) next

    label <- sub("^```\\{r\\s+([^,} ]+).*$", "\\1", line)
    source_file <- extract_ref(line, "file")
    fig_cap <- extract_ref(line, "fig.cap")
    caption_ref <- extract_ref(line, "caption_ref")
    source <- source_target(source_file, path)

    if (!is.na(fig_cap)) {
      fig_n <- fig_n + 1
      figures[[length(figures) + 1]] <- row(
        number = paste0(owner_id, ".", fig_n),
        owner = owner,
        label = paste0("fig:", label),
        caption = resolve_caption(fig_cap, refs),
        source = source
      )
    }

    is_table_chunk <- !is.na(caption_ref) ||
      (!is.na(source_file) && grepl("/tables/|\\\\tables\\\\", source_file))
    if (is_table_chunk) {
      tab_n <- tab_n + 1
      cap_key <- ifelse(is.na(caption_ref), NA_character_, caption_ref)
      tables[[length(tables) + 1]] <- row(
        number = paste0(owner_id, ".", tab_n),
        owner = owner,
        label = paste0("tab:", label),
        caption = resolve_caption(
          ifelse(is.na(cap_key), paste0("(ref:", label, ")"), paste0("(ref:", cap_key, ")")),
          refs
        ),
        source = source
      )
    }

    if (!is.na(source_file) && grepl("/chunks/|\\\\chunks\\\\", source_file)) {
      inline_chunks[[length(inline_chunks) + 1]] <- row(
        type = "inline chunk",
        owner = owner,
        label = label,
        source = source
      )
    }
  }
}

map_header <- function(title) {
  c(
    paste0("# ", title),
    "",
    "Generated by `book/_codex/generate_maps.R` after render. Use labels and source files as the stable edit handles; rendered numbers can change after the next render.",
    ""
  )
}

write_numbered_map <- function(path, title, rows, prefix) {
  out <- map_header(title)
  if (!length(rows)) {
    out <- c(out, "No entries found.")
  } else {
    df <- do.call(rbind, rows)
    out <- c(out, "| Number | Owner | Label | Caption | Source |", "| --- | --- | --- | --- | --- |")
    for (i in seq_len(nrow(df))) {
      out <- c(out, paste0(
        "| ", prefix, " ", escape_md(df$number[[i]]),
        " | ", escape_md(df$owner[[i]]),
        " | `", escape_md(df$label[[i]]), "`",
        " | ", escape_md(df$caption[[i]]),
        " | `", escape_md(df$source[[i]]), "` |"
      ))
    }
  }
  writeLines(out, path)
}

append_numbered_section <- function(out, heading, rows, prefix) {
  out <- c(out, paste0("## ", heading), "")
  if (!length(rows)) {
    return(c(out, "No entries found.", ""))
  }
  df <- do.call(rbind, rows)
  out <- c(out, "| Number | Owner | Label | Caption | Source |", "| --- | --- | --- | --- | --- |")
  for (i in seq_len(nrow(df))) {
    out <- c(out, paste0(
      "| ", prefix, " ", escape_md(df$number[[i]]),
      " | ", escape_md(df$owner[[i]]),
      " | `", escape_md(df$label[[i]]), "`",
      " | ", escape_md(df$caption[[i]]),
      " | `", escape_md(df$source[[i]]), "` |"
    ))
  }
  c(out, "")
}

write_artifact_map <- function(path, figures, tables, inline_chunks) {
  out <- map_header("Artifact Map")
  out <- append_numbered_section(out, "Figures", figures, "fig.")
  out <- append_numbered_section(out, "Tables", tables, "table")
  out <- c(out, "## Inline Chunks", "")
  if (!length(inline_chunks)) {
    out <- c(out, "No entries found.")
  } else {
    df <- do.call(rbind, inline_chunks)
    out <- c(out, "| Type | Owner | Label | Source |", "| --- | --- | --- | --- |")
    for (i in seq_len(nrow(df))) {
      out <- c(out, paste0(
        "| ", escape_md(df$type[[i]]),
        " | ", escape_md(df$owner[[i]]),
        " | `", escape_md(df$label[[i]]), "`",
        " | `", escape_md(df$source[[i]]), "` |"
      ))
    }
  }
  writeLines(out, path)
}

write_numbered_map(file.path(reports_dir, "figure_map.md"), "Figure Map", figures, "fig.")
write_numbered_map(file.path(reports_dir, "table_map.md"), "Table Map", tables, "table")
write_artifact_map(file.path(reports_dir, "artifact_map.md"), figures, tables, inline_chunks)

message("Wrote maps to ", reports_dir)
