str(iris)

#Commenting the install.packages out to prevent installation from running multiple times
#install.packages("mboost")
library(mboost)
#This no longer works data is now in TH.data
#source: http://www.rdatamining.com/books/rdm/faq/whereistofindthebodyfatdata
#data("bodyfat", package="mboost")
data("bodyfat", package = "TH.data")
str(bodyfat)