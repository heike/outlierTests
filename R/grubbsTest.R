#' Grubbs Test for one outlier in a normal sample
#'
#' The original paper states to reject the absolute maximum deviate G
#' at a significance level of alpha/n for one-sided tests and alpha/(2n) for
#' two sided tests.
#' @param x vector of normally distributed data values
#' @param alternative character value  specifying the alternative hypothesis.
#' It must be one of "max" (default), "min" or "two.sided".
#' @param alpha significance level for the rejection, acceptable Type 1 error.
#' @references
#' Grubbs, F. (1950).
#' *Sample Criteria for Testing Outlying Observations.*
#' *Annals of Mathematical Statistics,* 21(1), 27–58.
#' [https://doi.org/10.1214/aoms/1177729885](https://doi.org/10.1214/aoms/1177729885)
#' @export
#' @examples
#' # example code
#' x <- c(199.31, 199.53, 200.19, 200.82, 201.92, 201.95, 202.18, 245.57)
#' grubbsTest(x)
grubbsTest <- function(x, alternative = c("max", "min", "two.sided"),
                       alpha = 0.05) {
  stopifnot(is.numeric(x),
            length(x) > 1,
            alternative %in% c("min", "max", "two.sided"))

  if (any(is.na(x)))
    warning(sprintf("ignoring %d missing values", sum(is.na(x))))

  x <- na.omit(x)
  n <- length(x)
  alternative <- alternative[1]
  two.sided = alternative == "two.sided"
  #  browser()
  Ga <- qGrubbs(alpha, n, two.sided = two.sided)
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
                 method = "Grubbs test", critical = Ga, alpha = alpha,
                 alternative = alternative), class = "grubbsTest")
}
