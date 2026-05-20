args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_path <- if (length(file_arg)) normalizePath(sub("^--file=", "", file_arg[[1]])) else normalizePath("data_construction/code/build_toy_umbrella_data.R")
dc_root <- normalizePath(file.path(dirname(script_path), ".."))

raw_path <- file.path(dc_root, "data", "raw", "umbrella_observations.csv")
clean_dir <- file.path(dc_root, "data", "clean")
dir.create(clean_dir, recursive = TRUE, showWarnings = FALSE)

raw <- read.csv(raw_path, stringsAsFactors = FALSE)
original_rows <- nrow(raw)

clean <- raw
clean$umbrellas_per_puddle <- round(clean$umbrellas / pmax(clean$puddles, 1), 2)
clean$cocoa_per_notebook <- round(clean$cocoa_cups / pmax(clean$notebooks, 1), 2)
clean$quality_flag <- ifelse(clean$puddles > 0 & clean$umbrellas > 0, "usable", "check")

clean <- clean[clean$quality_flag == "usable", ]
retained_rows <- nrow(clean)
lost_rows <- original_rows - retained_rows

write.csv(clean, file.path(clean_dir, "toy_umbrella.csv"), row.names = FALSE)

accounting <- data.frame(
  step = c("raw rows", "retained rows", "lost rows"),
  rows = c(original_rows, retained_rows, lost_rows),
  reason = c("rows in raw source file", "usable toy rows", "none in this toy example")
)
write.csv(accounting, file.path(clean_dir, "toy_umbrella_accounting.csv"), row.names = FALSE)

message("Wrote clean toy data: ", file.path(clean_dir, "toy_umbrella.csv"))
message("Rows retained: ", retained_rows, " of ", original_rows)
