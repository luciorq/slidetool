test_that("slidetool slide vendor", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")
  vendor_str <- slidetool_slide_vendor(test_slide)
  expect_equal(vendor_str, "aperio")

  test_slide <- fs::path_package("slidetool", "extdata", "test_dicom.dcm")
  vendor_str <- slidetool_slide_vendor(test_slide)
  expect_equal(vendor_str, "dicom")
})
