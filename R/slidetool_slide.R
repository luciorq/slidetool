#' Report the detected OpenSlide vendor name for one or more slide files.
#' @export
slidetool_slide_vendor <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("slide", "vendor", path)
  return(stringr::str_squish(px_res$stdout))
}
