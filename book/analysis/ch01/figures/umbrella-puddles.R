toy <- read.csv("data/toy_umbrella.csv", stringsAsFactors = FALSE)

plot(
  toy$puddles,
  toy$umbrellas,
  pch = 19,
  col = "#2f6f73",
  xlab = "Puddles",
  ylab = "Umbrellas",
  main = ""
)
grid(col = "gray85")
fit <- lm(umbrellas ~ puddles, data = toy)
abline(fit, col = "#b4473f", lwd = 2)
text(
  toy$puddles,
  toy$umbrellas,
  labels = toy$town,
  pos = 3,
  cex = 0.72,
  col = "gray25"
)
