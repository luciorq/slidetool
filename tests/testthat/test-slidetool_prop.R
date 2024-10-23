test_that("slidetool prop list - With values", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  prop_res <- slidetool_prop_list(test_slide)

  expect_named(prop_res)

  expect_true(all(c("aperio.Filename", "openslide.vendor", "aperio.ScanScope ID") %in% names(prop_res)))

  expect_equal(names(prop_res), slidetool_prop_list_names(test_slide))
})

test_that("slidetool prop list - Just names", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  prop_names <- slidetool_prop_list_names(test_slide)

  expect_true(is.character(prop_names))
  expect_length(prop_names, 40L)

  expect_true(all(c("aperio.Filename", "openslide.vendor", "aperio.ScanScope ID") %in% prop_names))
})

test_that("slidetool prop get", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  expect_error({
    prop_value <- slidetool_prop_get(test_slide, "ID")
  })

  prop_value <- slidetool_prop_get(test_slide, "openslide.objective-power")
  expect_equal(prop_value, "20")

  prop_value <- slidetool_prop_get(test_slide, "openslide.comment")
  expect_true(is.character(prop_value))
})
