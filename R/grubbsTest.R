#' Grubbs Test for one outlier in a normal sample
#'
#' @description
#' The original paper states to reject the absolute maximum deviate G
#' at a significance level of alpha/n for one-sided tests and alpha/(2n) for
#' two sided tests.
#'
#' @examples
#' # example code
#' x <- c(199.31, 199.53, 200.19, 200.82, 201.92, 201.95, 202.18, 245.57)
#' grubbsTest(x)
grubbsTest <- function(x, alternative = c("max", "min", "two.sided"), conf.level = 0.95) {
  stopifnot(is.numeric(x),
            length(x) > 1,
            alternative %in% c("min", "max", "two.sided"))

  if (any(is.na(x))) warning(sprintf("ignoring %d missing values", sum(is.na(x))))

  x <- na.omit(x)
  n <- length(x)
  alternative <- alternative[1]
  two.sided = alternative == "two.sided"
  #  browser()
  Ga <- qGrubbs(1-conf.level, n, two.sided = two.sided)
  x1 <- min(x)
  xn <- max(x)
  mu <- mean(x)
  s <- sd(x)

  G1 <- (x1 - mu)/s
  Gn <- (xn - mu)/s
  G = max(-G1, Gn)

  if (alternative == "two.sided") {
    p.value = pGrubbs(G, n, two.sided = FALSE)
    p.value <- 2*pmin(p.value, 1- p.value)
  }
  if (alternative == "max") {
    p.value = pGrubbs(G, n, two.sided = FALSE)
    if (Gn < -G1) p.value <- 1 - p.value
  }
  if (alternative == "min") {
    p.value = 1-pGrubbs(G, n, two.sided = FALSE)
    Ga <- -Ga
    if (G1 < -Gn) p.value <- 1 - p.value
  }

  structure(list(statistic = G,
                 parameter = list(df = n, sigma = sd(x)),
                 p.value = p.value,
                 estimate = list(max = max(x)),
                 method = "Grubbs test", critical = Ga, alpha = 1-conf.level,
                 alternative = alternative), class = "grubbsTest")
}
