library(reticulate)

py_datasets <<- import("sklearn.datasets")

data_breast_cancer = py_datasets$load_breast_cancer(TRUE)
X <- data_breast_cancer[[1]]
Y <- data_breast_cancer[[2]]


clas1 <- create_classifier()
fit_classifier(clas1, np_array(X),as.integer(Y))

predicciones <- predict_classifier(clas1, np_array(X))
predicciones_prob <- predict_classifier_prob(clas1, np_array(X))
predicciones_dist <- predict_classifier_dist(clas1, np_array(X))
