#' Installation Python ngboost module
#'
#' @param envname  The name, or full path, of the environment in which Python packages are to be installed. When NULL (the default), the active environment as set by the RETICULATE_PYTHON_ENV variable will be used; if that is unset, then the r-reticulate environment will be used.
#' @param method  Installation method. By default, "auto" automatically finds a method that will work in the local environment. Change the default to force a specific installation method. Note that the "virtualenv" method is not available on Windows.
#' @param conda  The path to a conda executable. Use "auto" to allow reticulate to automatically find an appropriate conda binary. See Finding Conda for more details.
#' @export
install_ngboost <- function(envname = NULL,
                            method = "auto", 
                            conda = "auto") {
  
  reticulate::py_install("ngboost", method = method, conda = conda)
  
}


