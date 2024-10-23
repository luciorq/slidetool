test_that("Native cmd", {
  testthat::expect_true(
    stringr::str_detect(slidetool("--help")$stdout, "Usage:")
  )
  testthat::expect_true(
    stringr::str_detect(slidetool("--version")$stderr, "slidetool")
  )
})
