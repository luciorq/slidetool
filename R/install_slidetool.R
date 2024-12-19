#' Install OpenSlide Dependencies
#'
#' Installs OpenSlide dependencies in a conda environment for use with `slidetool`.
#'
#' @param env_name Character string specifying the name of the conda environment. Defaults to `"slidetool-r-env"`.
#'
#' @param force A logical value indicating whether to force the re-creation of the Conda environment even if it already exist. Default is `FALSE`.
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
    # cli::cli_warn(
    #   message = c(
    #     `!` = "Instalation method for Windows OS is highly experimental."
    #   )
    # )
    px_res <- condathis::create_env(
      packages = NULL,
      overwrite = force,
      verbose = "silent",
      env_name = env_name
    )
    download_url <- "https://github.com/openslide/openslide-bin/releases/download/v4.0.0.6/openslide-bin-4.0.0.6-windows-x64.zip"
    env_path <- condathis::get_env_dir(env_name = env_name)
    slidetool_bin_path <- fs::path(env_path, "bin", "slidetool", ext = "exe")
    if (isFALSE(fs::file_exists(slidetool_bin_path)) || isTRUE(force)) {
      dl_dir <- fs::path(env_path, "tmp")
      if (isFALSE(fs::dir_exists(dl_dir))) {
        fs::dir_create(dl_dir)
      }
      full_dl_path <- fs::path(dl_dir, "openslide-windows-64", ext = "zip")
      timeout_limit = 3600
      download_method = "auto"
      withr::with_options(
        new = base::list(
          timeout = base::max(base::unlist(base::options("timeout")), timeout_limit)),
        code = {
          dl_res <- utils::download.file(
            url = download_url,
            destfile = full_dl_path,
            method = download_method,
            mode = "wb"
          )
        }
      )
      utils::untar(
        tarfile = full_dl_path,
        exdir = fs::path_expand(dl_dir)
      )
      bin_path <- fs::dir_ls(
        path = dl_dir,
        regexp = "openslide-bin-.*windows-.*/bin$",
        recurse = TRUE,
        type = "directory"
      )
      if (fs::dir_exists(fs::path(env_path, "bin"))) {
        fs::dir_delete(fs::path(env_path, "bin"))
      }
      fs::file_move(
        path = bin_path,
        new_path = env_path
      )
      if (fs::dir_exists(dl_dir)) {
        fs::dir_delete(dl_dir)
      }
    }
  } else {
    px_res <- condathis::create_env(
      "conda-forge::openslide>=4.0.*",
      overwrite = force,
      verbose = "silent",
      env_name = env_name
    )
  }
  invisible(px_res)
}
