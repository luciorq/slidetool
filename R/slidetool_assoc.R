#' List of Associated Images
#'
#' List associated images for one or more slides. Associated images are small non-pyramidal images containing additional information about the slide, such as its label.
#'
#' @return Character vector with names of associated images.
#'
#' @export
slidetool_assoc_list <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("assoc", "list", path)
  parsed_out <- stringr::str_squish(px_res$stdout)
  parsed_out <- stringr::str_split_1(parsed_out, "[[:space:]]")
  return(parsed_out)
}


#' slidetool assoc icc read
#' Write the associated image's ICC color profile to output-file if specified, and otherwise to standard output. If no ICC color profile is available, fail.
#' @export
slidetool_assoc_icc_read <- function(path, assoc) {
  path <- fs::path_real(path)
  px_res <- slidetool("assoc", "icc", "read", path, assoc)
  # parsed_out <- stringr::str_squish(px_res$stdout)
  # parsed_out <- stringr::str_split_1(parsed_out, "[[:space:]]")
  return(px_res)
}
