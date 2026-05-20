toy <- read.csv("data/toy_umbrella.csv", stringsAsFactors = FALSE)

avg_umbrellas <- round(mean(toy$umbrellas), 1)
top_row <- toy[which.max(toy$umbrellas), ]
top_town <- paste0(top_row$town, " in ", top_row$year)
toy_row_count <- nrow(toy)
