toy <- read.csv(
  "../../data_construction/data/clean/toy_umbrella.csv",
  stringsAsFactors = FALSE
)

plot(
  toy$puddles,
  toy$umbrellas,
  pch = 19,
  col = "gray25",
  xlim = range(toy$puddles) + c(-1.5, 1.5),
  ylim = range(toy$umbrellas) + c(-2, 2),
  xlab = "Puddles",
  ylab = "Umbrellas",
  main = ""
)
grid(col = "gray85")
fit <- lm(umbrellas ~ puddles, data = toy)
abline(fit, col = "gray55", lwd = 1.5)

label_toy <- toy[toy$year == max(toy$year), ]
text(
  label_toy$puddles,
  label_toy$umbrellas,
  labels = label_toy$town,
  pos = c(2, 3, 2, 3, 2, 2),
  offset = 0.45,
  cex = 0.68,
  col = "gray20"
)
