# ngboostR

R wrapper for NGBoost python module

[![Github License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

ngboost is a Python library that implements Natural Gradient Boosting, as described in ["NGBoost: Natural Gradient Boosting for Probabilistic Prediction"](https://stanfordmlgroup.github.io/projects/ngboost/). It is built on top of [Scikit-Learn](https://scikit-learn.org/stable/), and is designed to be scalable and modular with respect to choice of proper scoring rule, distribution, and base learner. A didactic introduction to the methodology underlying NGBoost is available in this [slide deck](https://drive.google.com/file/d/183BWFAdFms81MKy6hSku8qI97OwS_JH_/view?usp=sharing).

## Installation

### Python installation

```{r}
# Install reticulate package (python interface with R)
install.packages("reticulate")

# Load reticulate package
library(reticulate)

# Install Miniconda (python distribution)
install_miniconda()
```

### R package installation

```{r}
# Install ngboostR package from github repository
install_github("acca3003/ngboostR")

# Load ngbootR Library
library(ngboostR)

# Install ngboost python module
install_ngboost()

```

## Usage

#### Regression

```{r}
#Install last ve
#library(devtools)


library(ngboostR) # R implementation for NGBoost
library(Metrics) # Métrics
library(MASS) # boston houses dataset
library(caret)


data(Boston)
set.seed(999)
trainIndex <- createDataPartition(Boston$medv, p = .8, 
                                  list = FALSE, 
                                  times = 1)

X_train = Boston[trainIndex,1:13]
Y_train = Boston[trainIndex,14]

X_val = Boston[-trainIndex,1:13]
Y_val = Boston[-trainIndex,14]



# Create the regressor object
# reg_ngboost <- create_regressor() # Default parameters
reg_ngboost <- create_regressor(Dist=Normal(),
                                Base=DecisionTreeRegressor(
                                  criterion="mae",
                                  min_samples_split=2,
                                  min_samples_leaf=1,
                                  min_weight_fraction_leaf=0.0,
                                  max_depth=5,
                                  splitter="best",
                                  random_state=NULL),
                                natural_gradient=TRUE,
                                n_estimators=as.integer(600),
                                learning_rate=0.002,
                                minibatch_frac=0.8,
                                col_sample=0.9,
                                verbose=TRUE,
                                verbose_eval=as.integer(50),
                                tol=1e-5)
# Train with the boston data
fit_regressor(reg_ngboost, X_train, Y_train, X_val, Y_val)

# Predict the price
predictions <- predict_regressor(reg_ngboost, X_val)
Metrics::rmse(Y_val,predictions)

# Predict the price as a distribution
predictions_dist <- predict_regressor_dist(reg_ngboost, X_val)
predictions_dist

```

### Classification

```{r}
#Install last ve
#library(devtools)
#install_github("acca3003/ngboostR")

library(ngboostR) # R implementation for NGBoost
library(Metrics) # Métrics
library(mlbench) # Breast Cancer dataset
library(caret)


data("BreastCancer")
set.seed(999)
BreastCancer <- na.omit(BreastCancer)
trainIndex <- createDataPartition(BreastCancer$Class, p = .8, 
                                  list = FALSE, 
                                  times = 1)

X_train <- BreastCancer[trainIndex,2:10]
Y_train <- BreastCancer[trainIndex,11]
Y_train <- as.integer(as.integer(Y_train)-1)

X_val <- BreastCancer[-trainIndex,2:10]
Y_val <- BreastCancer[-trainIndex,11]
Y_val <- as.integer(as.integer(Y_val)-1)


# Create the regressor object
# reg_ngboost <- create_regressor() # Default parameters
class_ngboost <- create_classifier()
# Train with the boston data
fit_classifier(class_ngboost, X_train, Y_train, X_val, Y_val)


# Predict
predictions <- predict_classifier(class_ngboost, X_val)
Metrics::accuracy(Y_val,predictions)

# Predict with probabilities
predictions_prob <- predict_classifier_prob(class_ngboost, X_val)
predictions_prob

# Predict as a distribution
predictions_dist <- predict_classifier_dist(class_ngboost, X_val)
predictions_dist

```

## License

[Apache License 2.0](https://github.com/stanfordmlgroup/ngboost/blob/master/LICENSE).

## Reference

Tony Duan, Anand Avati, Daisy Yi Ding, Khanh K. Thai, Sanjay Basu, Andrew Y. Ng, Alejandro Schuler. 2019. NGBoost: Natural Gradient Boosting for Probabilistic Prediction. [arXiv](https://arxiv.org/abs/1910.03225)
