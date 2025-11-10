# The Grubbs G Distribution

Quantile function and distribution function for the extreme absolute
deviate G of a normal sample defined as \\ G = \max (G_1, G_n),\\ where
\\G_i = \frac{\|x\_{(i)} - \bar{x}\|}{s}\\ for an ordered sample of
\\x\_{i}\\ with \\x\_{(1)} \le x\_{(2)} \le ... \le x\_{(n)}\\.
\\\bar{x}\\ and \\s^2\\ are sample mean and variance defined as
\$\$\bar{x} = \frac{1}{n} \sum\_{i=1}^n x_i text{ and } s^2 =
\frac{1}{n-1}\sum\_{i=1}^n (x_i - \bar{x})^2.\$\$

## Usage

``` r
qGrubbs(p, n, two.sided, lower.tail = FALSE)

pGrubbs(x, n, two.sided, lower.tail = FALSE)
```

## Arguments

- p:

  vector of probabilities.

- n:

  sample size.

- two.sided:

  logical; if TRUE, an outlier can be either a minimum or a maximum.

- lower.tail:

  logical; if FALSE (default), probabilities are \\P(G \> g)\\,
  otherwise \\P(G \le g)\\.

- x:

  vector of quantiles.

## Details

The quantile and distribution function is derived from rejecting
\$\$\$\$
