#' NGBoost for R
#'
#' \href{https://stanfordmlgroup.github.io}{NGBoost} bla bla bla
#' @import reticulate
#'
#' @docType package
#' @name ngboost


# python 'scipy' module I want to use in my package
ngboost <- NULL

.onLoad <- function(libname, pkgname) {
  # delay load foo module (will only be loaded when accessed via $)
  # ngbR <<- reticulate:import("ngboost", delay_load = TRUE)
  #packageStartupMessage("Cargando ngbR")
  #reticulate::configure_environment(pkgname)
  ngboost <<- reticulate::import("ngboost",delay_load = TRUE)
  #packageStartupMessage("Cargado ngbR")
}



#' @rdname ngboost_version
#' @keywords internal
#' @export
ngboost_version <- function() {
  print("0.0.1")
}


