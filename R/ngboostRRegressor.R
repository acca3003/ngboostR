#' @rdname create_regressor
#' @export
create_regressor <- function() {
  classifier <- NULL
  print("Creating regressorr...")
  nboost <- import("ngboost")
  regressor <- ngboost$NGBRegressor()
  regressor
}
#' @rdname fit_regressor
#' @export
fit_regressor <- function( ngbr_reg, X_train, Y_train) {
  print("Fitting the regressor")
  ngbr_reg$fit(X_train, Y_train)
}
#' @rdname predict_regressor
#' @export
predict_regressor <- function( ngbr_reg, new_data) {
  pred <- ngbr_reg$predict(new_data)
  pred
}

#' @rdname predict_regressor_dist
#' @export
predict_regressor_dist <- function( ngbr_reg, new_data) {
  pred_temp <- ngbr_reg$pred_dist(new_data)
  pred <- list( "loc"=pred_temp$loc, "scale"=pred_temp$scale)
  pred
}
