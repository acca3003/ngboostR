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
create_regressor <- function(Dist=NULL,
                             Base=default_tree_learner,
                             natural_gradient=TRUE,
                             n_estimators=as.integer(500),
                             learning_rate=0.01,
                             minibatch_frac=1.0,
                             col_sample=1.0,
                             verbose=TRUE,
                             verbose_eval=as.integer(100),
                             tol=1e-4) {
  
  regressor <- ngboost$NGBRegressor(Dist=Dist,
                                    Base = Base,
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
fit_regressor <- function( ngbr_reg, X_train, Y_train, X_val=NULL, Y_val=NULL) {
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
  
  # We have to detect the Distribution to build the prediction
  # <class 'ngboost.distns.laplace.Laplace'>
  # Buscaremos el texto adecuado y luego cogeremos los 

  if( toString(ngbr_reg$Dist) == "<class 'ngboost.distns.laplace.Laplace'>") 
  {
    # Laplace Distribution
    pred <- list( "distribution"="Laplace","loc"=pred_temp$params$loc, "scale"=pred_temp$params$scale)
    
  } else if(toString(ngbr_reg$Dist) == "<class 'ngboost.distns.cauchy.Cauchy'>")
  {
    # Cauchy Distribution
    pred <- list( "distribution"="Cauchy","loc"=pred_temp$params$loc, "scale"=pred_temp$params$scale)
  }
  else if(toString(ngbr_reg$Dist) == "<class 'ngboost.distns.poisson.Poisson'>")
  {
    # Poisson Distribution
    pred <- list( "distribution"="Poisson","mu"=pred_temp$params$mu)
    
  } else if( toString(ngbr_reg$Dist) == "<class 'ngboost.distns.normal.Normal'>")
  {
    # Normal Distribution
    pred <- list( "distribution"="Normal","loc"=pred_temp$params$loc, "scale"=pred_temp$params$scale)

    
  }else if( toString(ngbr_reg$Dist) == "<class 'ngboost.distns.t.T'>")
  {
    # T student Distribution
    pred <- list( "distribution"="TStudent","loc"=pred_temp$params$loc, "scale"=pred_temp$params$scale)
    
  }else if( toString(ngbr_reg$Dist) == "<class 'ngboost.distns.multivariate_normal.MultivariateNormal.<locals>.MVN'>")
  {
    # MultivarianteNormal Distribution
    pred <- list( "distribution"="MultivariateNormal","loc"=pred_temp$params$loc, "scale"=pred_temp$params$scale)
  }
  else if( toString(ngbr_reg$Dist) == "<class 'ngboost.distns.distn.Distn.uncensor.<locals>.DistWithUncensoredScore'>")
  {
    if( toString(ngbr_reg$Dist$censored_scores[[1]])=="<class 'ngboost.distns.lognormal.LogNormalLogScoreCensored'>")
    {
      # LogNormal Distribution
      print("LogNormal......")
      pred <- list( "distribution"="LogNormal","s"=pred_temp$params$s, "scale"=pred_temp$params$scale)
    }else
    {
      # Exponential Distribution
      pred <- list( "distribution"="Exponential","scale"=pred_temp$params$scale)
    }
  }
  else
  {
    print("Nothing Distribution")
    print(toString(ngbr_reg$Dist))

  }

  pred
}
