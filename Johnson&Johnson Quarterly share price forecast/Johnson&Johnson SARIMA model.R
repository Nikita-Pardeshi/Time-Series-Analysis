library(astsa)
library(TSstudio)
ts_plot(JohnsonJohnson,title='Quaterly earnings of J&J share',
        Xtitle='Year',Ytitle='Share price')

par(mfrow=c(3,1))
#1. Log-return transformation 
ts_plot(diff(log(JohnsonJohnson)), title ='Log-return transformation i.e. differencing') #d=1
acf(diff(log(JohnsonJohnson)),main="ACF") #there is seasonality after every 4 lags 
pacf(diff(log(JohnsonJohnson)),main='pacf')

#2. Seasonal differencing 
ts_plot(diff(diff(log(JohnsonJohnson)),4))

#3. Ljung Box test
Box.test(JohnsonJohnson,lag=log(length(JohnsonJohnson)))

par(mfrow=c(2,1))
acf(diff(diff(log(JohnsonJohnson)),4))
pacf(diff(diff(log(JohnsonJohnson)),4))

#4. fitting the model

d=1
D=1
s=4

for(p in 1:2)
{for(q in 1:2)
{for(P in 1:2)
{for(Q in 1:2)
{if(p+d+q+P+D+Q<=10)
{model<-arima(x=log(JohnsonJohnson),order=c(p-1,d,q-1),seasonal=list(order=c(P-1,D,Q-1),period=s))
test<-Box.test(model$residuals,lag=log(length(model$residuals)))
sse=sum(model$residuals^2)
cat(p-1,d,q-1,P-1,D,Q-1, "AIC:",model$aic,"SSE:",sse,'p-value:',test$p.value,'\n')

}
}
}
}
}

#hence we chose the model (0,1,1,1,1,0)

#5. plotting seasonal arima of the model
sarima(log(JohnsonJohnson),0,1,1,1,1,0,4)
#acf plot shows that there is no autocorrelation between previous lags since no spike is above the noise line 
#p-value verified that there is no autocorrelation 
#Q-Q plot for residuals is almost linear

#6. forecasting 
library(forecast)
par(mfrow=c(1,1))
model.fit<-arima(x=(JohnsonJohnson),order=c(0,1,1),seasonal=list(order=c(1,1,0),period=4))
print(model.fit)


plot(forecast(model.fit))

forecast(model.fit)
