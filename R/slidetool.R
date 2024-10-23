#' Retrieve data from whole slide images
#' Slidetool uses OpenSlide to retrieve data from whole slide images, also known as virtual slide files.
#' @export
slidetool <- function(...) {
  px_res <- condathis::run(
    "slidetool",
    ...,
    env_name = "slidetool-r-env",
    error = "continue"
  )
  if (isFALSE(px_res$status == 0)) {
    cli::cli_abort(
      message = c(
        `x` = "slidetool failed <<weird error>>",
        `!` = "{px_res$stderr}"
      ),
      class = "slidetool_error"
    )
  }
  return(px_res)
}
