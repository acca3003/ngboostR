sklearn <<- reticulate::import("sklearn",delay_load = TRUE)

#' DecisionTreeRegressor
#' @param criterion criterion
#' @param min_samples_split min_samples_split
#' @param min_samples_leaf min_samples_leaf
#' @param max_depth max_depth
#' @param splitter splitter
#' @param random_state random_state
#' @return DecisionTreeRegressor Object
#' @export
DecisionTreeRegressor <- function(
  criterion="friedman_mse",
  min_samples_split=2,
  min_samples_leaf=1,
  min_weight_fraction_leaf=0.0,
  max_depth=3,
  splitter="best",
  random_state=NULL){
  

  sklearn$tree$DecisionTreeRegressor(criterion=criterion,
                min_samples_split=as.integer(min_samples_split),
                min_samples_leaf=as.integer(min_samples_leaf),
                min_weight_fraction_leaf=min_weight_fraction_leaf,
                max_depth=max_depth,
                splitter=splitter,
                random_state=random_state)
}

#' Default DecisionTreeRegressor
#'
#' @return Default DecisionTreeRegressor
#' @export
default_tree_learner <- function(){
  sklearn$tree$DecisionTreeRegressor(
    criterion="friedman_mse",
    min_samples_split=2,
    min_samples_leaf=1,
    min_weight_fraction_leaf=0.0,
    max_depth=3,
    splitter="best",
    random_state=NULL)
}


#' LinearTreeRegressor
#'
#' @param alpha alpha
#' @param random_state random_state
#' @return LinearTreeRegressor Object
#' @export
Ridge <- function(
  alpha=0.0,
  random_state=NULL
){
  sklearn$linear_model$Ridge(alpha=alpha,
                       random_state=random_state)
}

#' Default LinearTreeRegressor
#'
#' @return Default LinearTreeRegressor
#' @export
default_linear_learner <-  function(){
  sklearn$linear_model$Ridge(alpha=0.0,random_state=NULL)
}