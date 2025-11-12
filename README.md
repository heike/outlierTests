
<!-- README.md is generated from README.Rmd. Please edit that file -->

# outlierTests

<!-- badges: start -->

[![R-CMD-check](https://github.com/heike/outlierTests/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/heike/outlierTests/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/heike/outlierTests/graph/badge.svg)](https://app.codecov.io/gh/heike/outlierTests)
<!-- badges: end -->

The goal of outlierTests is to provide an R implementation of the GRubbs
test with a properly controlled type I error for one sided tests.

## Installation

You can install the development version of `outlierTests` like so:

``` r
remotes::install_github("heike/outlierTests")
#> Using GitHub PAT from the git credential store.
#> Downloading GitHub repo heike/outlierTests@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>      checking for file ‘/private/var/folders/1x/tvy5cf5j4glg4_6g8cxvrcbm7qbgrn/T/Rtmppmot4W/remotes7f9f37fb5081/heike-outlierTests-3b16731/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/1x/tvy5cf5j4glg4_6g8cxvrcbm7qbgrn/T/Rtmppmot4W/remotes7f9f37fb5081/heike-outlierTests-3b16731/DESCRIPTION’
#>   ─  preparing ‘outlierTests’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>      Omitted ‘LazyData’ from DESCRIPTION
#>   ─  building ‘outlierTests_0.1.0.tar.gz’
#>      Warning: invalid uid value replaced by that for user 'nobody'
#>    Warning: invalid gid value replaced by that for user 'nobody'
#>      
#> 
```

## Example

This is a basic example which shows you how to solve a common problem:

From the NIST [Engineering Statistics
Handbook](https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h1.htm):
the following set of 8 numbers are mass spectrometer measurements on a
uranium isotope (Tietjen and
Moore)\[doi/abs/10.1080/00401706.1972.10488948\]:

``` r
iso <- c(199.31, 199.53, 200.19, 200.82, 201.92, 201.95, 202.18, 245.57)
grubbsTest(iso)
#> 
#>  Grubbs test for one Outlier
#> 
#> data:  iso
#> G = 2.4688, df = 8, sigma = 15.853, p-value = 1.548e-07
#> alternative hypothesis: The maximum is an outlier.
#> sample estimates:
#>  G1 (min)  Gn (max) 
#> 0.4493752 2.4687646
```

## Control of Type I error

``` r
set.seed(202511)

results <- data.frame(t(replicate(1000, {
  x <- rnorm(6, mean = 0.3, sd = 0.6)
  grubbs1a <- grubbsTest(x, alternative = "max")
  grubbs1b <- grubbsTest(x, alternative = "min")
  grubbs1c <- grubbsTest(x, alternative = "two.sided")
  grubbs2a <- outliers::grubbs.test(x, type = 10, two.sided = FALSE)
  grubbs2b <- outliers::grubbs.test(x, type = 10, two.sided = TRUE)
  c("grubbs.max" = grubbs1a$p.value, 
    "grubbs.min" = grubbs1b$p.value, 
    "grubbs.twosided" = grubbs1c$p.value, 
    "grubbs.outliers.onesided" = grubbs2a$p.value,
    "grubbs.outliers.twosided" = grubbs2b$p.value
    )
})))
```

P-values of 1000 replicates of samples of size 6 from a random normal
distribution.

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Compare the results to output from the `outliers` package:

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" /> In
the case of a single outlier, the one sided grubbs test in the
`outliers` package is not well controlled.
