#' Write a region of the specified level of a slide to a PNG image.
#'
#' Write a region of the specified level of a slide to a PNG image. x and y are pixel coordinates in level 0, the highest-resolution slide level.
#' Width and height are pixel dimensions in the specified level.
#' If output-file is not specified, the image will be written to standard output.
#' The dimensions of each level of a slide can be obtained with slidetool prop list.
#'
#' @return Path to region file.
#'
#' @export
slidetool_region_read <- function(path, x, y, level, width, height, output_file = NULL) {
  rlang::check_required(path)
  path <- fs::path_real(path)
  if (isFALSE(is.null(output_file))) {
    output_file <- fs::path_expand(output_file)
  }
  px_res <- slidetool(
    "region", "read", path, x, y, level, width, height, output_file
  )
  if (isTRUE(px_res$status == 0)) {
    if (isFALSE(fs::file_exists(output_file))) {
      cli::cli_abort(
        message = c(
          `x` = "{.path {output_file}} could not be created"),
        class = "slidetool_region_read_file_missing"
      )
    }
  }
  invisible(output_file)
}
