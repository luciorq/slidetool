#' List Associated Images in a Slide
#'
#' Retrieves a list of associated images for a slide. Associated images are small non-pyramidal images containing additional information, such as labels or thumbnails.
#'
#' @param path Character string specifying the path to the slide file.
#'
#' @return A character vector containing the names of associated images.
#'
#' @details
#' This function extracts the names of associated images embedded within a whole slide image file using OpenSlide.
#'
#' @examples
#' \dontrun{
#' # List associated images
#' associated_images <- slidetool_assoc_list("path/to/slide.svs")
#' print(associated_images)
#' }
#'
#' @export
slidetool_assoc_list <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("assoc", "list", path)
  parsed_out <- stringr::str_squish(px_res$stdout)
  parsed_out <- stringr::str_split_1(parsed_out, "[[:space:]]")
  return(parsed_out)
}

#' Read ICC Color Profile of an Associated Image
#'
#' Writes the ICC color profile of a specified associated image to an output file or standard output.
#' If no ICC color profile is available, the function will produce an error.
#'
#' @param path Character string specifying the path to the slide file.
#' @param assoc Character string specifying the name of the associated image.
#'
#' @return A list containing the result of the `slidetool` command execution.
#'
#' @details
#' This function retrieves the ICC color profile of an associated image within a slide using OpenSlide's `slidetool`.
#'
#' @examples
#' \dontrun{
#' # Read ICC profile of an associated image
#' icc_profile <- slidetool_assoc_icc_read("path/to/slide.svs", "label")
#' }
#'
#' @export
slidetool_assoc_icc_read <- function(path, assoc) {
  path <- fs::path_real(path)
  px_res <- slidetool("assoc", "icc", "read", path, assoc)
  # parsed_out <- stringr::str_squish(px_res$stdout)
  # parsed_out <- stringr::str_split_1(parsed_out, "[[:space:]]")
  return(px_res)
}

#' Read an Associated Image from a Slide
#'
#' Extracts a specific associated image from a slide and saves it as a PNG image.
#'
#' @param path Character string specifying the path to the slide file.
#' @param assoc Character string specifying the name of the associated image.
#' @param output_file Character string specifying the path to the output PNG file. If `NULL`, the image will be written to a temporary file output.
#'
#' @examples
#' \dontrun{
#' # Read ICC profile of an associated image
#' thumbnail_path <- slidetool_assoc_read("path/to/slide.svs", "thumbnail")
#' }
#'
#' @export
slidetool_assoc_read <- function(path, assoc, output_file = NULL) {
  rlang::check_required(path)
  path <- fs::path_real(path)
  if (isFALSE(is.null(output_file))) {
    output_file <- fs::path_expand(output_file)
  } else {
    output_file <- fs::file_temp(pattern = "assoc", ext = "png")
  }
  px_res <- slidetool(
    "assoc", "read", path, assoc, output_file
  )
  if (isTRUE(px_res$status == 0)) {
    if (isFALSE(fs::file_exists(output_file))) {
      cli::cli_abort(
        message = c(
          `x` = "{.path {output_file}} could not be created"
        ),
        class = "slidetool_assoc_read_file_missing"
      )
    }
  }
  invisible(output_file)
}
