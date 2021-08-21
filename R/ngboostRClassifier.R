#' Create a NGBoostClassifier object
#'
#' @param Dist Distribution should be used
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
create_classifier <- function(Dist=NULL,
                              natural_gradient=TRUE,
                              n_estimators=as.integer(500),
                              learning_rate=0.01,
                              minibatch_frac=1.0,
                              col_sample=1.0,
                              verbose=TRUE,
                              verbose_eval=as.integer(100),
                              tol=1e-4) {
  
  classifier <- ngboost$NGBClassifier(Dist=Dist,
                                      natural_gradient=natural_gradient,
                                      n_estimators=as.integer(n_estimators),
                                      minibatch_frac=minibatch_frac,
                                      col_sample=col_sample,
                                      verbose=verbose,
                                      verbose_eval=as.integer(verbose_eval),
                                      tol=tol
                                      )
  classifier
}
#' Train a NGBoostClassifier object
#'
#' @param ngbr_reg NGBoostRegressor obcjet
#' @param X_train Training data (numeric). Is an object where samples are in rows and features are in columns.
#' @param Y_train Training data. A numeric (integer)  vector containing the outcome for each sample.
#' @param X_val validattion data (numeric). Is an object where samples are in rows and features are in columns.
#' @param Y_val Validation data. A numeric (integer)  vector containing the outcome for each sample.
#' @export
fit_classifier <- function( ngbr_cla, X_train, Y_train, X_val=NULL, Y_val=NULL) {
  print("Fitting the classifier")
  ngbr_cla$fit(X_train, as.integer(Y_train), X_val, as.integer(Y_val))
}

#' Predict using a NGBoostClassifier object
#'
#' @param ngbr_cla NGBoostClassifier obcjet
#' @param new_Data Is an object where new samples are in rows and features are in columns.
#' @return Predictions
#' @export
predict_classifier <- function( ngbr_cla, new_data) {
  pred <- ngbr_cla$predict(new_data)
  pred
}


#' Predict using a NGBoostClassifier object as a probability
#'
#' @param ngbr_cla NGBoostClassifier obcjet
#' @param new_Data Is an object where new samples are in rows and features are in columns.
#' @return Predictions
#' @export
predict_classifier_prob <- function( ngbr_cla, new_data) {
  pred <- ngbr_cla$predict_proba(new_data)
  pred
}


#' Predict Distribution (Bernoulli o Cateogiral) using NGBoostClassifierr object
#'
#' @param ngbr_reg NGBoostClassifier obcjet
#' @param new_Data Is an object where new samples are in rows and features are in columns.
#' @return A list with loc(mean) and scale(desviation)
#' @export
predict_classifier_dist <- function( ngbr_cla, new_data) {
  pred_temp <- ngbr_cla$pred_dist(new_data)
  pred <- list( "p0"=pred_temp$loc, "p1"=pred_temp$scale)
  pred
}
