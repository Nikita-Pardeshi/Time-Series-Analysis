# Time Series Analysis

This project contains applications of Time Series modeling on different data sets. With a focus on advanced models such as ARIMA and SARIMA, step-by-step analysis of the data set was performed along with addressing trends and seasonality in the data and using forecasting methods for specific periods of time. The common steps performed in Time Series Analysis and modeling are: 

1. Load the data set. If the data set is not a time series object, convert it using different packages in R such as [xts](https://www.rdocumentation.org/packages/xts/versions/0.12.1/topics/xts). See more resources [here](https://stackoverflow.com/questions/29046311/how-to-convert-dataframe-into-time-series).
 
2. Plot the time series data- in R, one can use the basic plot() function or plotly's ts_plot() from [TSstudio library](https://cran.r-project.org/web/packages/TSstudio/TSstudio.pdf)
3. Initial analysis: check for trends and seasonality in the time series data. Use the decompose() function in R to view trends, seasonality, outliers and any other patterns in the data.
4. Perfom the Ljung-Box test to check for correlation between the lags of the time series. If p-value <0.05, there is significant autocorrelation between the lags in the time series data. 
5. Remove trend- Differentiate the data using diff() operator in R. **value(t) = observation(t) - observation(t-1)**. Plot the differenced time series data and check for trends again.
6. Perform Ljung-Box test again to check whether the trend was removed (p-value >0.05). 
7. Plot ACF and PACF for the time series data to decide the parameters for the ARIMA model. 
8. Apply ARIMA model to the time series data and chose the model with the lowest AIC. 
