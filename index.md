# outlierTests

The goal of outlierTests is to …

## Installation

You can install the development version of outlierTests like so:

``` r
remotes::install_github("heike/outlierTests")
#> Using GitHub PAT from the git credential store.
#> Skipping install of 'outlierTests' from a github remote, the SHA1 (c0867832) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

This is a basic example which shows you how to solve a common problem:

From the NIST [Engineering Statistics
Handbook](https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h1.htm):
the following set of 8 numbers are mass spectrometer measurements on a
uranium isotope (Tietjen and
Moore)\[doi/abs/10.1080/00401706.1972.10488948\]:

``` r
x <- c(199.31, 199.53, 200.19, 200.82, 201.92, 201.95, 202.18, 245.57)
grubbsTest(x)
#> $statistic
#> [1] 2.468765
#> 
#> $parameter
#> $parameter$df
#> [1] 8
#> 
#> $parameter$sigma
#> [1] 15.85256
#> 
#> 
#> $p.value
#> [1] 1.547663e-07
#> 
#> $estimate
#> $estimate$max
#> [1] 245.57
#> 
#> 
#> $method
#> [1] "Grubbs test"
#> 
#> $critical
#> [1] 2.031652
#> 
#> $alpha
#> [1] 0.05
#> 
#> $alternative
#> [1] "max"
#> 
#> attr(,"class")
#> [1] "grubbsTest"
```
