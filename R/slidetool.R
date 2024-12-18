#' Run OpenSlide Command-Line Tool
#'
#' Executes the OpenSlide command-line tool `slidetool` with the specified arguments.
#' This function uses the `condathis` package to manage the execution environment.
#'
#' @param ... Additional arguments passed to the `slidetool` command-line tool.
#'
#' @return A list containing the result of the `slidetool` command execution, including standard output and error messages.
#'
#' @details
#' The `slidetool()` function serves as a wrapper for the OpenSlide `slidetool` command.
#' It allows you to execute any `slidetool` subcommands by passing them as arguments.
#'
#' @examples
#' \dontrun{
#' # List associated images in a slide
#' slidetool("assoc", "list", "path/to/slide.svs")
#' }
#'
#' @export
slidetool <- function(...) {
  px_res <- condathis::run_bin(
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
