test_that("slidetool region read SVS", {
  test_slide <- fs::path_package("slidetool", "extdata", "CMU-1-Small-Region.svs")

  temp_path <- fs::file_temp("slidetool", ext = "png")

  region_path <- slidetool_region_read(
    test_slide,
    x = 10, y = 10, level = 0, width = 1000, height = 1000,
    temp_path
  )
  region_pointer <- magick::image_read(temp_path)
  region_info <- magick::image_attributes(region_pointer)

  testthat::expect_true(
    stringr::str_detect(
      string = region_info[region_info$property == "Software", "value"],
      pattern = "OpenSlide"
    )
  )

  testthat::expect_equal(temp_path, region_path)
  testthat::expect_true(fs::file_exists(temp_path))
})

test_that("slidetool region read DICOM", {
  test_slide <- fs::path_package("slidetool", "extdata", "test_dicom.dcm")

  temp_path <- fs::file_temp("slidetool", ext = "png")

  testthat::expect_error({
    region_path <- slidetool_region_read(
      test_slide,
      x = 10,
      y = 10,
      level = 1,
      width = 1000,
      height = 1000,
      output_file = temp_path
    )
  })

  expect_false(fs::file_exists(temp_path))
})
