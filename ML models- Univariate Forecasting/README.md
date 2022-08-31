The code file- ml_univariate_forecast.ipynb is the main code file in this repository. 

It performs predictive analysis on Time Series data using Machine Learning models instead of traditional models such as ARIMA etc. which do not have the capability to handle non-linear data. Although Linear Regression cannot handle non-linear data, deep learning models using ANNs will be added in this folder soon for better predictions/ accuracy. 

**Time Series data is converted to dataframe/ format** which can be used by ML models such as Linear Regressor and Random Forest Regressor. The *function time_series_to_supervised()* provides flexibility for the number of lags taken into consideration for input to the models and number of forecasts for model predictions. The same function can be used for both univariate and multivariate data. Multivariate forecasts are covered in ml_multivariate_forecast.ipynb file. 
