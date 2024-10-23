test_that("Environment created", {
  testthat::skip_if_offline()
  testthat::skip_on_cran()
  testthat::skip_on_bioc()
  testthat::skip_on_ci()

  px_res <- install_slidetool(env_name = "slidetool-r-env")

  testthat::expect_equal(px_res$status, 0)

  testthat::expect_true(condathis::env_exists(env_name = "slidetool-r-env"))
})
