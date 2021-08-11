
library(ngboostR) # R implementation for NGBoost
library(Metrics) # Métrics
library(MASS) # boston houses dataset


data(Boston)

X = Boston[,1:13]
Y = Boston[,14]

# Create the regressor object
reg_ngboost <- create_regressor()
# Train with the boston data
fit_regressor(reg_ngboost, X, Y)

# Predic the price
predictions <- predict_regressor(reg_ngboost, X)
Metrics::rmse(Y,predictions)

# Predict the price as a Normal distribution (mean/locate and desviation/scale)
predictions_dist <- predict_regressor_dist(reg_ngboost, X)
predictions_dist
