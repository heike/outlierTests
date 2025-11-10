#' The Grubbs G Distribution
#'
#' Quantile function and distribution function for the extreme absolute deviate G of a
#' normal sample defined as \eqn{ G = \max (G_1, G_n),}
#' where \eqn{G_i = \frac{|x_{(i)} - \bar{x}|}{s}} for an ordered sample of
#' \eqn{x_{i}} with \eqn{x_{(1)} \le x_{(2)} \le ... \le x_{(n)}}.
#' \eqn{\bar{x}} and \eqn{s^2} are sample mean and variance defined as
#' \deqn{\bar{x} = \frac{1}{n} \sum_{i=1}^n x_i text{ and } s^2 = \frac{1}{n-1}\sum_{i=1}^n (x_i - \bar{x})^2.}
#' @details
#' The quantile and distribution function is derived from
#' rejecting
#' \deqn{}
#' @param p vector of probabilities.
#' @param x vector of quantiles.
#' @param n sample size.
#' @param two.sided logical; if TRUE, an outlier can be either a minimum or a maximum.
#' @param lower.tail logical; if FALSE (default), probabilities are
#' \eqn{P(G > g)}, otherwise \eqn{P(G \le g)}.
#' @importFrom stats qt na.omit sd uniroot
#' @export
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
