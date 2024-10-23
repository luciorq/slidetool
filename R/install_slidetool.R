#' Install OpenSlide Dependencies
#'
#' Installs OpenSlide dependencies in a conda environment for use with `slidetool`.
#'
#' @param env_name Character string specifying the name of the conda environment. Defaults to `"slidetool-r-env"`.
#'
#' @return Invisibly returns the result of the conda environment creation.
#'
#' @details
#' The `install_slidetool()` function creates a conda environment containing the necessary OpenSlide dependencies.
#' This environment is required for running `slidetool` commands.
#'
#' @examples
#' \dontrun{
#' # Install OpenSlide dependencies
#' install_slidetool()
#' }
#'
#' @export
install_slidetool <- function(env_name = "slidetool-r-env") {
  px_res <- condathis::create_env(
    "conda-forge::openslide==4.0.0",
    overwrite = FALSE,
    verbose = FALSE,
    env_name = env_name
  )
  invisible(px_res)
}
