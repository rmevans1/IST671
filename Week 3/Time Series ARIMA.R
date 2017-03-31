#install.packages("tseries")
library(tseries)

mydata <- read.csv("timeseries_ppi.csv")
attach(mydata)

# Defining variables
Y <- ppi
d.Y <- diff(Y)
t <- yearqrt

# Descriptive statistics and plotting the data
summary(Y)
summary(d.Y)

plot(t,Y)
plot(d.Y)

#Display fuller test for variable
adf.test(Y, alternative="stationary", k=0)
adf.test(Y, alternative="explosive", k=0)

summary(lm(dppi ~ lppi, na.action=na.omit))
summary(lm(dppi ~ lppi + trend, na.action=na.omit))

# Augmented Dickey fuller test
adf.test(Y, alternative = "stationary")

#DF and ADF tests for differenced variable
adf.test(d.Y, k=0)
adf.test(d.Y)

#ACF and PACF
acf(Y)
pacf(Y)

acf(d.Y)
pacf(d.Y)

# ARIMA(1.0.0) or AR(1)
arima(Y, order=c(1,0,0))
