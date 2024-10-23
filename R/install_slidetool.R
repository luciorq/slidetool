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
