#' Create a NGBoostRegressor object
#'
#' @param natural_gradient logical flag indicating whether the natural gradient should be used
#' @param n_estimators the number of boosting iterations to fit
#' @param learning_rate the learning rate
#' @param minibatch_frac the percent subsample of rows to use in each boosting iteration
#' @param col_sample the percent subsample of columns to use in each boosting iteration
#' @param verbose flag indicating whether output should be printed during fitting
#' @param verbose_eval increment (in boosting iterations) at which output should be printed
#' @param tol numerical tolerance to be used in optimization
#' @return A NGBoostRegressor object
#' @export
create_regressor <- function(natural_gradient=TRUE,
                             n_estimators=as.integer(500),
                             learning_rate=0.01,
                             minibatch_frac=1.0,
                             col_sample=1.0,
                             verbose=TRUE,
                             verbose_eval=as.integer(100),
                             tol=1e-4) {
  
  regressor <- ngboost$NGBRegressor(Dist=Dist,
                                    natural_gradient=natural_gradient,
                                    n_estimators=as.integer(n_estimators),
                                    learning_rate=learning_rate,
                                    minibatch_frac=minibatch_frac,
                                    col_sample=col_sample,
                                    verbose=verbose,
                                    verbose_eval=as.integer(verbose_eval),
                                    tol=tol)
  regressor
}
#' Train a NGBoostRegressor object
#'
#' @param ngbr_reg NGBoostRegressor obcjet
#' @param X_train Training data. Is an object where samples are in rows and features are in columns.
#' @param Y_train Training data. A numeric  vector containing the outcome for each sample.
#' @param X_val validattion data. Is an object where samples are in rows and features are in columns.
#' @param Y_val Validation data A numeric  vector containing the outcome for each sample.
#' @export
fit_regressor <- function( ngbr_reg, X_train, Y_train, X_val, Y_val) {
  print("Fitting the regressor")
  ngbr_reg$fit(X_train, Y_train, X_val, Y_val)
}

#' Predict using a NGBoostRegressor object
#'
#' @param ngbr_reg NGBoostRegressor obcjet
#' @param new_Data Is an object where new samples are in rows and features are in columns.
#' @return Predictions
#' @export
predict_regressor <- function( ngbr_reg, new_data) {
  pred <- ngbr_reg$predict(new_data)
  pred
}

#' Predict Normal distribution using NGBoostRegressor object
#'
#' @param ngbr_reg NGBoostRegressor obcjet
#' @param new_Data Is an object where new samples are in rows and features are in columns.
#' @return A list with loc(mean) and scale(desviation)
#' @export
predict_regressor_dist <- function( ngbr_reg, new_data) {
  pred_temp <- ngbr_reg$pred_dist(new_data)
  pred <- list( "loc"=pred_temp$loc, "scale"=pred_temp$scale)
  pred
}
