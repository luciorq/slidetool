#' Retrieve all OpenSlide properties with values.
#'
#' @return named list with property values as character strings.
#' @export
slidetool_prop_list <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("prop", "list", path)
  parsed_out <- stringr::str_squish(px_res$stdout)
  parsed_out <- stringr::str_split_1(parsed_out, "'[[:space:]]")
  name_vector <- stringr::str_squish(stringr::str_remove_all(parsed_out, ":\\W*'.*"))
  value_vector <- stringr::str_squish(stringr::str_remove_all(parsed_out, ".*:\\W+'"))
  base::names(value_vector) <- name_vector
  return(value_vector)
}

#' Retrieve all OpenSlide properties names for one slide.
#' @export
slidetool_prop_list_names <- function(path) {
  path <- fs::path_real(path)
  px_res <- slidetool("prop", "list", "--names", path)

  parsed_out <- stringr::str_replace_all(px_res$stdout, pattern = "\\h", replacement = stringr::fixed("||||"))
  parsed_out <- stringr::str_squish(parsed_out)

  parsed_out <- stringr::str_split_1(parsed_out, pattern = "[[:space:]]")

  parsed_out <- stringr::str_replace(parsed_out, pattern = stringr::fixed("||||"), replacement = " ")
  return(parsed_out)
}


#' Retrieve a single OpenSlide property value for one or more slides.
#'
#' Properties are individual pieces of textual metadata about the slide.
#' Properties prefixed with `"openslide.{...}"` are defined by OpenSlide.
#' Others are defined by the individual slide format and will vary by vendor.
#'
#' @export
slidetool_prop_get <- function(path, property) {
  path <- fs::path_real(path)
  stopifnot(length(property) == 1L)
  px_res <- slidetool("prop", "get", property, path)
  parsed_out <- stringr::str_squish(px_res$stdout)
  return(parsed_out)
}
