check_numeric_scalar <- function(x, name) {
  if (length(x) != 1 || !is.numeric(x) || !is.finite(x)) {
    stop(paste0(name, " must be a numeric scalar"))
  }
}
