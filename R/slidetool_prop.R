#' List Slide Properties
#'
#' Retrieves all OpenSlide properties and their values for a given slide.
#'
#' @param path Character string specifying the path to the slide file.
#'
#' @return A named character vector with property names and their corresponding values.
#'
#' @details
#' Properties are individual pieces of textual metadata about the slide.
#' Properties prefixed with `"openslide.*"` are defined by OpenSlide.
#' Other properties are defined by the slide format and may vary by vendor.
#'
#' @examples
#' \dontrun{
#' # List slide properties
#' properties <- slidetool_prop_list("path/to/slide.svs")
#' print(properties)
#' }
#'
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

#' List Slide Property Names
#'
#' Retrieves the names of all OpenSlide properties for a given slide.
#'
#' @param path Character string specifying the path to the slide file.
#'
#' @return A character vector containing the names of all properties.
#'
#' @details
#' This function provides the names of all available properties without their values, useful for exploring available metadata.
#'
#' @examples
#' \dontrun{
#' # Get property names
#' property_names <- slidetool_prop_list_names("path/to/slide.svs")
#' print(property_names)
#' }
#'
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

#' Get a Slide Property Value
#'
#' Retrieves the value of a specific OpenSlide property for a given slide.
#'
#' @param path Character string specifying the path to the slide file.
#' @param property Character string specifying the name of the property to retrieve.
#'
#' @return A character string containing the value of the specified property.
#'
#' @details
#' This function allows you to access individual pieces of metadata by specifying the property name.
#'
#' @examples
#' \dontrun{
#' # Get a specific property value
#' vendor <- slidetool_prop_get("path/to/slide.svs", "openslide.vendor")
#' print(vendor)
#' }
#'
#' @export
slidetool_prop_get <- function(path, property) {
  path <- fs::path_real(path)
  stopifnot(length(property) == 1L)
  px_res <- slidetool("prop", "get", property, path)
  parsed_out <- stringr::str_squish(px_res$stdout)
  return(parsed_out)
}
