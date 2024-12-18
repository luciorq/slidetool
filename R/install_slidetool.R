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
install_slidetool <- function(env_name = "slidetool-r-env", force = FALSE) {

  if (isTRUE(.Platform$OS.type %in% c("windows"))) {
    cli::cli_warn(
      message = c(
        `!` = "Instalation method is not currently available for Windows OS"
      )
    )
    # create_env_res <- condathis::create_env(
    #   packages = c("python", "pip"),
    #   overwrite = force,
    #   verbose = "silent",
    #   env_name = env_name
    # )
    # pip_res <- condathis::run(
    #   "python", "-m", "pip", "install", "openslide-bin",
    #   env_name = env_name
    # )

  } else {
    px_res <- condathis::create_env(
      "conda-forge::openslide>=4.0.0",
      overwrite = force,
      verbose = "silent",
      env_name = env_name
    )
  }
  invisible(px_res)
}
