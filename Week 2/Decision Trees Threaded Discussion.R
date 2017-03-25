#Packages to install
#install.packages("ISLR")
#install.packages("tree")

library(ISLR)
library(tree)

attach(Carseats)


head(Carseats)

### Start Data Manipulation
range(Sales)
#create a categorical variable based on sales
High = ifelse(Sales >=8, "Yes", "No")
# Append High to Carseats dataset
Carseats = data.frame(Carseats, High)

Carseats = Carseats[,-1]

### Split data into testing and training
set.seed(2)
train = sample(1:nrow(Carseats), nrow(Carseats)/2)
test = -train
training_data = Carseats[train,]
testing_data = Carseats[test,]
testing_high = High[test]