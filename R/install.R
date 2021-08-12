#' Installation Python ngboost module
#'
#' @export
install_ngboost <- function(method = "auto", conda = "auto") {
  reticulate::py_install("ngboost", method = method, conda = conda)
}


