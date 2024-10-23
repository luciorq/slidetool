#' Read a Region from a Slide
#'
#' Extracts a specific region from a slide and saves it as a PNG image.
#'
#' @param path Character string specifying the path to the slide file.
#' @param x Numeric value specifying the x-coordinate in level 0 pixels.
#' @param y Numeric value specifying the y-coordinate in level 0 pixels.
#' @param level Integer specifying the slide level to read from (0 is the highest resolution).
#' @param width Numeric value specifying the width of the region in pixels at the specified level.
#' @param height Numeric value specifying the height of the region in pixels at the specified level.
#' @param output_file Character string specifying the path to the output PNG file. If `NULL`, the image will be written to standard output.
#'
#' @return Invisibly returns the path to the output file.
#'
#' @details
#' Coordinates `x` and `y` are specified in pixels at level 0 (highest resolution).
#' The dimensions `width` and `height` are specified at the requested `level`.
#' This function is useful for extracting regions of interest from large slide images.
#'
#' @examples
#' \dontrun{
#' # Read a region and save to a file
#' slidetool_region_read(
#'   path = "path/to/slide.svs",
#'   x = 1000,
#'   y = 1000,
#'   level = 0,
#'   width = 500,
#'   height = 500,
#'   output_file = "region.png"
#' )
#' }
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
          `x` = "{.path {output_file}} could not be created"
        ),
        class = "slidetool_region_read_file_missing"
      )
    }
  }
  invisible(output_file)
}
