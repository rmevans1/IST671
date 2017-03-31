#4.1- Building Decision Trees with Package party
#This section goes over how to build a decision tree using the party package

#install.packages("party")

#view the iris data set
str(iris)

#set a seed for repeatable results
set.seed(1234)

#build test and training set with a 70/30 split
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

#Load the party package, build a tree and check the prediction
library(party)
myFormula <- Species~Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data=trainData)
#check the prediction
table(predict(iris_ctree), trainData$Species)

#print a text version of the tree
print(iris_ctree)

#graphic tree
plot(iris_ctree)

plot(iris_ctree, type="simple")

#predictions on test data
testPred <- predict(iris_ctree, newdata = testData)

#4.2- Building Decision Trees with Package rpart
#This section will build a decision tree using the bodyfat data. The rpart function will select the tree with the minimum predection error.
#install.packages("mboost")
#install.packages("rpart")
#load the bodyfat dataset
data("bodyfat", package="TH.data")
#looking at the data set
dim(bodyfat)
attributes(bodyfat)
bodyfat[1:5,]

#splitting into training and test subsets
#set a seed for repeatable results
set.seed(1234)
ind <- sample(2, nrow(bodyfat), replace=TRUE, prob=c(0.7,0.3))
bodyfat.train <- bodyfat[ind==1,]
bodyfat.test <- bodyfat[ind==2,]
#train a decision tree
library(rpart)
myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth
bodyfat_rpart <- rpart(myFormula, data = bodyfat.train,
                       control = rpart.control(minsplit = 10))
attributes(bodyfat_rpart)
print(bodyfat_rpart$cptable)
#print a text version of the tree
print(bodyfat_rpart)

#create a graphical tree
plot(bodyfat_rpart)
#add text to graphic
text(bodyfat_rpart, use.n=TRUE)
#get the minimum error
opt <- which.min(bodyfat_rpart$cptable[,"xerror"])
cp <- bodyfat_rpart$cptable[opt, "CP"]
bodyfat_prune <- prune(bodyfat_rpart, cp=cp)
#print the pruned tree
print(bodyfat_prune)

#create predictions
DEXfat_pred <- predict(bodyfat_prune, newdata = bodyfat.test)

xlim <- range(bodyfat$DEXfat)
plot(DEXfat_pred ~ DEXfat, data = bodyfat.test, xlab = "Observed",
     ylab = "Predicted", ylim = xlim, xlim = xlim, jitter=T)
abline(a = 0, b = 1)

#4.3- Random Forest
#The random forest model is used to build a predictive model for the iris data set. When developing random forests there are two limitations. First, this can not handle missing data so that must be handled first. Second categorical values can only have 32 levels.
#install.packages("randomForest")
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

library(randomForest)
#train a random forest on data
rf <- randomForest(Species ~ ., data=trainData, ntree=100, proximity=TRUE)
#print out prediction matrix
table(predict(rf), trainData$Species)

print(rf)
attributes(rf)

#plot the random forest error rate
plot(rf)

#variable importance
importance(rf)
varImpPlot(rf)

#Test the random forest against the test data
irisPred <- predict(rf, newdata = testData)
table(irisPred, testData$Species)

plot(margin(rf, testData$Species))