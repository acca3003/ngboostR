#' @rdname install_ngboost
#' @export
install_ngboost <- function(method = "auto", conda = "auto") {
  reticulate::py_install("ngboost", method = method, conda = conda)
}


