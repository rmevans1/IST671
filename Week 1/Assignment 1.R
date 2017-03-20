str(iris)

#Chapter 1
#Commenting the install.packages out to prevent installation from running multiple times
#install.packages("mboost")
library(mboost)
#This no longer works data is now in TH.data
#source: http://www.rdatamining.com/books/rdm/faq/whereistofindthebodyfatdata
#data("bodyfat", package="mboost")
data("bodyfat", package = "TH.data")
str(bodyfat)

#Chapter 2- Data Import/Exmport

#Export/Import to Rdata
a <- 1:10
save(a, file="data/dumData.Rdata")
rm(a)
load("data/dumData.Rdata")
print(a)

#Export/Import to CSV
var1 <- 1:5
var2 <- (1:5) / 10
var3 <- c("R", "and", "Data Mining", "Examples", "Case Studies")
a <- data.frame(var1, var2, var3)
names(a) <- c("VariableInt", "VariableReal", "VariableChar")
write.csv(a, "data/dummyData.csv", row.names = FALSE)
b <- read.csv("data/dummyData.csv")
print(b)