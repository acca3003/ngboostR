#' NGBoost for R
#'
#' \href{https://stanfordmlgroup.github.io}{NGBoost} bla bla bla
#' @import reticulate
#'
#' @docType package
#' @name ngboost


#' @export
ngboost <- NULL

.onLoad <- function(libname, pkgname) {
  # delay load foo module (will only be loaded when accessed via $)
  # ngbR <<- reticulate:import("ngboost", delay_load = TRUE)
  #packageStartupMessage("Cargando ngbR")
  #reticulate::configure_environment(pkgname)
  ngboost <<- reticulate::import("ngboost",delay_load = TRUE)
  #packageStartupMessage("Cargado ngbR")
}



#' Version Number of the python module NGBoost
#'
#' @return Version Number of the python module NGBoost
#' @export
ngboost_python_version <- function() {
  print("Incoming...")
}


