## This code is a demonstration of applying ARIMA and SARIMA to a time series data

### Loading necessary libraries
options(warn=-1)
library(astsa) #provides time series model functions (arima, sarima)
library(TSstudio) #plotly library for plotting time series data
library(xts) #library to convert data frame to time series object

### Load the daily female births in California data set
birth.data=read.csv("daily-total-female-births-CA.csv")
head(birth.data)

str(birth.data)


### Converting dates in string format to datetime object
birth.data$date<-as.Date(birth.data$date)
head(birth.data)

#creating a separate variable for just the number of births for further calculations
number_of_births<-birth.data$births


### Converting the data frame object to time series object for plotting
#converting data frame to time series object
birth.ts <- xts(birth.data[,-1], order.by=birth.data[,1])
#rename second column to appropriate name
names(birth.ts)[1] <- "births"
head(birth.ts)


## Plotting the time series data
ts_plot(birth.ts, title = "Daily total female births in California in 1959",
        Xtitle = "Month",
        Ytitle = "Number of female births",
        slider=TRUE)


#There is definitely some trend in the time series
  
## We perform the Ljung-Box test to check for correlations between lags
  
#Null Hypothesis (H0): There is no autocorrelation between the lags

#Alternate Hypothesis (H1): There is significant autocorrelation between the lags
Box.test(x=birth.ts,lag=log(length(birth.ts)))

#Since the p-value is less than 0.05, we reject the Null Hypothesis and conclude that there is significant autocorrelation between the lags in the time series data.
  
### In order to remove the trend, we use the difference operator on the number of births. Specifically, a new series is constructed where the value at the current time step is calculated as the difference between the original observation and the observation at the previous time step.
  
#value(t) = observation(t) - observation(t-1)
  
ts_plot(diff(birth.ts),title='Differenced data')
#hence, the trend is removed with outliers at Sept 2 and 3

#Again checking the p-values for the above differenced data. 

Box.test(diff(birth.ts),lag=log(length(birth.ts)))
#p-value is again very less than 0.05. therefore, autocorrelation is still there and cannot be further eliminated. 

### Building the ARIMA model: Deciding parameters for the model through ACF and PACF


par(mfrow=c(2,1))
acf(diff(number_of_births))
pacf(diff(number_of_births))

#Hence, we can make out that:
  
#1. ACF- there is one significant spike 
#2. PACF- there are significant spikes up until lag 7 

#We create 4 models with: p=0,7, d=1(since we have differenced the Time Series once) and q=1,2
  
  

model1<-arima(birth.ts,order=c(0,1,1))
model1.test<-Box.test(model1$residuals,lag=log(length(model1$residuals)))

model2<-arima(birth.ts,order=c(7,1,1))
model2.test<-Box.test(model2$residuals,lag=log(length(model2$residuals)))

model3<- arima(birth.ts,order=c(0,1,2))
model3.test<-Box.test(model3$residuals,lag=log(length(model3$residuals)))

model4<-arima(birth.ts,order=c(7,1,2))
model4.test<-Box.test(model4$residuals,lag=log(length(model4$residuals)))


#collecting all data into a single data frame
df<-data.frame(row.names=c("AIC","p-value"),c(model1$aic,model1.test$p.value),
               c(model2$aic,model2.test$p.value),
               c(model3$aic,model3.test$p.value),
               c(model4$aic,model4.test$p.value))
colnames(df)<-c('Arima(0,1,1)','Arima(7,1,1)', 'Arima(0,1,2)', 'Arima(7,1,2)')
df




### We select the model with lowest AIC i.e. ARIMA(0,1,2)
# Fitting the SARIMA Model: Does this perform better than the ARIMA model? 
sarima(birth.ts, 0,1,2,0,0,0)

#Looking at the p-values of Moving Averages, there is no autocorrelation between the lags. The AIC of the SARIMA model is somewhat similar to that of ARIMA model. The Q-Q plot is almost linear. 