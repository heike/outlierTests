#' The Grubbs G Distribution
#'
#' Quantile function and distribution function for Grubbs G distribution.
#' @param p vector of probabilities.
#' @param x vector of quantiles.
#' @param n sample size.
#' @param two.sided logical; if TRUE, an outlier can be either a minimum or a maximum.
#' @param lower.tail logical; if FALSE (default), probabilities are
#' \eqn{P(G > g)}, otherwise \eqn{P(G \le g)}.
#' @references
#' Grubbs, F. (1950).
#' *Sample Criteria for Testing Outlying Observations.*
#' *Annals of Mathematical Statistics,* 21(1), 27–58.
#' [https://doi.org/10.1214/aoms/1177729885](https://doi.org/10.1214/aoms/1177729885)
qGrubbs <- function(p, n, two.sided, lower.tail = FALSE) {
  denom <- n
  if (two.sided) denom <- denom*2
  if (lower.tail) {
    p <- 1 - p
    lower.tail <- FALSE
  }

  # result is ratio of two t-quantiles
  # For one sided tests, quantile is p/n
  # for two-sided tests quantile is p/(2*n)

  # expressions of the form c - p are introducing
  # numeric inaccuracies for small p  (for any c != 0)
  # For the purpose of testing we are interested in the
  # extreme quantiles of the distribution
  t_stat1 <- qt(1-p/denom, df=n-2, lower.tail = F)
  t_stat2 <- qt(p/denom, df=n-2, lower.tail = T)
  #  browser()
  t_stat <- pmax(abs(t_stat1), abs(t_stat2))

  (n - 1)/sqrt(n) * t_stat/sqrt(n - 2 + t_stat^2)
}



#' @rdname qGrubbs
pGrubbs <- function(x, n, two.sided, lower.tail = FALSE) {
  stopifnot(is.numeric(x), n > 0)
  pvals <- sapply(x, FUN = function(xx) {
    if (xx < qGrubbs(.999999999999, n, two.sided = two.sided)) return(1)
    if (is.infinite(xx) | is.na(xx)) browser()
    if (xx > qGrubbs(1e2*.Machine$double.eps, n, two.sided = two.sided)) return(0)
    uniroot(function(y){qGrubbs(y,n, two.sided = two.sided) - xx},
            lower = 1e2*.Machine$double.eps,
            upper = .999999999999,
            tol=1e8*.Machine$double.eps,
            trace=5)$root}
  )
  if (lower.tail) pvals <- 1 - pvals
  pvals
}
