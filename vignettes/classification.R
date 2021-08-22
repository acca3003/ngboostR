#np_array
library(reticulate)

py_datasets <<- import("sklearn.datasets")

library(mlbench)
data(iris)
str(iris)
#data_breast_cancer = py_datasets$load_breast_cancer(TRUE)
X <- iris[,1:4]
Y <- iris[,5]
Y <- as.integer(Y)

clas1 <- create_classifier(Dist=ngboost$distns$k_categorical(as.integer(3)))
# Tipo para la clase tiene que ser numerico

fit_classifier(clas1, X, Y)

predicciones <- predict_classifier(clas1, np_array(X))
predicciones_prob <- predict_classifier_prob(clas1, np_array(X))
predicciones_dist <- predict_classifier_dist(clas1, np_array(X))
