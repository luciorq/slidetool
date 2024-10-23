#' Get Slide Vendor Name
#'
#' Reports the detected OpenSlide vendor name for a slide file.
#'
#' @param path Character string specifying the path to the slide file.
#'
#' @return A character string containing the vendor name of the slide.
#'
#' @details
#' This function identifies the vendor (e.g., "aperio") of a slide file using OpenSlide.
#' Knowing the vendor can be useful for handling vendor-specific metadata or features.
#'
#' @examples
#' \dontrun{
#' # Get slide vendor
#' vendor <- slidetool_slide_vendor("path/to/slide.svs")
#' print(vendor)
#' }
#'
#' @export
slidetool_slide_vendor <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("slide", "vendor", path)
  return(stringr::str_squish(px_res$stdout))
}
