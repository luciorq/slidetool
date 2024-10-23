test_that("slidetool assoc list", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  prop_vector <- slidetool_assoc_list(test_slide)
  expect_equal(prop_vector, c("label", "macro", "thumbnail"))
})

test_that("slidetool assoc icc", {
  # test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  # prop <- slidetool_assoc_icc_read(test_slide, "label")
  # expect_equal(prop_vector, c("label", "macro", "thumbnail"))

  expect_true(TRUE)
})
