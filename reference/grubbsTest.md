# Grubbs Test for one outlier in a normal sample

The original paper states to reject the absolute maximum deviate G at a
significance level of alpha/n for one-sided tests and alpha/(2n) for two
sided tests.

## Usage

``` r
grubbsTest(x, alternative = c("max", "min", "two.sided"), alpha = 0.05)
```

## Arguments

- x:

  vector of normally distributed data values

- alternative:

  character value specifying the alternative hypothesis. It must be one
  of "max" (default), "min" or "two.sided".

- alpha:

  significance level for the rejection, acceptable Type 1 error.

## References

Grubbs, F. (1950). *Sample Criteria for Testing Outlying Observations.*
*Annals of Mathematical Statistics,* 21(1), 27–58.
<https://doi.org/10.1214/aoms/1177729885>

## Examples

``` r
# example code
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
