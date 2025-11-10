test_that("check Grubbs Test", {
  # The Tietjen and Moore paper gives the following set of 8 mass spectrometer measurements on a uranium isotope:
  x <- c(199.31, 199.53, 200.19, 200.82, 201.92, 201.95, 202.18, 245.57)
  t1_one <- grubbsTest(x, alpha = 0.05, alternative = "max")

  expect_in("htest", class(t1_one))
  expect_in("grubbs", class(t1_one))
  expect_equal(t1_one$parameter$df, length(x))
  expect_equal(t1_one$parameter$sigma, sd(x))
  expect_equal(round(t1_one$statistic$G, digits=6), 2.468765)
  expect_equal(round(t1_one$critical, digits=6), 2.031652)
  expect_equal(round(10^7*t1_one$p.value, digits=6), 1.547663)
})
