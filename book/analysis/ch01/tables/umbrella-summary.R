toy <- read.csv("data/toy_umbrella.csv", stringsAsFactors = FALSE)

summary_table <- aggregate(
  cbind(puddles, umbrellas, notebooks, cocoa_cups) ~ town,
  data = toy,
  FUN = mean
)
summary_table$puddles <- round(summary_table$puddles, 1)
summary_table$umbrellas <- round(summary_table$umbrellas, 1)
summary_table$notebooks <- round(summary_table$notebooks, 1)
summary_table$cocoa_cups <- round(summary_table$cocoa_cups, 1)
names(summary_table) <- c("Town", "Avg. puddles", "Avg. umbrellas", "Avg. notebooks", "Avg. cocoa cups")

knitr::kable(summary_table, caption = "(ref:umbrella-summary-caption)")
