args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_path <- if (length(file_arg)) {
  normalizePath(sub("^--file=", "", file_arg[[1]]))
} else {
  normalizePath("data_construction/build_all.R")
}
dc_root <- dirname(script_path)

message("Building registered toy production data...")
builder <- file.path(dc_root, "builders", "build_toy_umbrella_data.R")
rscript <- file.path(
  R.home("bin"),
  if (.Platform$OS.type == "windows") "Rscript.exe" else "Rscript"
)
status <- system2(rscript, shQuote(builder))
if (!identical(status, 0L)) stop("Toy data builder failed.")

toy_path <- file.path(dc_root, "data", "clean", "toy_umbrella.csv")
accounting_path <- file.path(
  dc_root,
  "data",
  "clean",
  "toy_umbrella_accounting.csv"
)

stopifnot(file.exists(toy_path), file.exists(accounting_path))
toy <- read.csv(toy_path, stringsAsFactors = FALSE)
accounting <- read.csv(accounting_path, stringsAsFactors = FALSE)

required_columns <- c(
  "town", "year", "puddles", "umbrellas", "notebooks", "cocoa_cups",
  "umbrellas_per_puddle", "cocoa_per_notebook", "quality_flag"
)
stopifnot(all(required_columns %in% names(toy)))
stopifnot(!anyDuplicated(toy[c("town", "year")]))
stopifnot(all(toy$quality_flag == "usable"))
stopifnot(
  identical(accounting$step, c("raw rows", "retained rows", "lost rows"))
)
stopifnot(accounting$rows[1] == accounting$rows[2] + accounting$rows[3])
stopifnot(nrow(toy) == accounting$rows[2])

message("REGISTERED_TOY_DATA_BUILD_OK rows=", nrow(toy))
