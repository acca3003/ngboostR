
#' Normal Distribution
#'
#' @return Normal Distribution Object
#' @export
Normal <- function(){
  ngboost$distns$Normal
}

#' Multivariante Normal Distribution
#'
#' @return Multivariante Normal Distribution Object
#' @param k number of dimensions
#' @export
MultivariateNormal <- function( k ){
  ngboost$distns$MultivariateNormal(as.integer( k ) )
}

#' LogNormal Distribution
#'
#' @return LogNormal Distribution Object
#' @export
LogNormal <- function(){
  ngboost$distns$LogNormal
}

#' Exponential Distribution
#'
#' @return Exponential Distribution Object
#' @export
Exponential <- function(  ){
  ngboost$distns$Exponential
}

#' Cauchy Distribution
#'
#' @return Cauchy Distribution Object
#' @export
Cauchy <- function(){
  ngboost$distns$Cauchy
}

#' Laplace Distribution
#'
#' @return Laplaces Distribution Object
#' @export
Laplace <- function(){
  ngboost$distns$Laplace
}

#' Poisson Distribution
#'
#' @return Normal Distribution Object
#' @export
Poisson <- function( ){
  ngboost$distns$Poisson
}

#' Student T Distribution
#'
#' @return Student T Distribution Object
#' @export
T <- function( ){
  ngboost$distns$T
}


#' Categorical Distribution
#'
#' @param K number of categories
#' @return Categorical Distribution Object
#' @export
k_categorical <- function( K ){
  ngboost$distns$k_categorical(as.integer(K))
}

#' Bernoulli Distribution (Categorical with k=1)
#'
#' @return Bernoulli Distribution Object
#' @export
Bernoulli <- function(){
  ngboost$distns$k_categorical(as.integer(2))
}


