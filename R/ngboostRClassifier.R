create_classifier <- function(Dist="Bernoulli",
                              Score="LogScore",
                              Base="default_tree_learner",
                              natural_gradient=TRUE,
                              n_estimators=500,
                              learning_rate=0.01,
                              minibatch_frac=1.0,
                              col_sample=1.0,
                              verbose=TRUE,
                              verbose_eval=100,
                              tol=1e-4) {
  classifier <- NULL
  print("Creating classifier...")
  nboost <- import("ngboost")
  classifier <- ngboost$NGBClassifier(Dist,
                                      Score,
                                      Base,
                                      natural_gradient,
                                      n_estimators,
                                      learning_rate,
                                      minibatch_frac,
                                      col_sample,
                                      verbose,
                                      verbose_eval,
                                      tol)
  classifier
}

fit_classifier <- function( ngbr_class, X_train, Y_train) {
  print("Fit the classifier")
  ngbr_class$fit(X_train, Y_train)
}

predict_classifier <- function( ngbr_class, new_data) {
  pred <- ngbr_class$predict(new_data)
  pred
}

predict_classifier_prob <- function( ngbr_class, new_data) {
  pred <- ngbr_class$predict_proba(new_data)
  pred
}

predict_classifier_dist <- function( ngbr_class, new_data) {
  pred <- ngbr_class$pred_dist(new_data)
  pred
}
