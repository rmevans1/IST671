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

# fit the tree model using training data

tree_model = tree(High ~., training_data)

plot(tree_model)
text(tree_model, pretty=0)


# check the models performance

tree_pred = predict(tree_model, testing_data, type="class")
mean(tree_pred != testing_high) #28.5%

### Prune the tree

## cross validation to check where to stop pruning

set.seed(3)

cv_tree = cv.tree(tree_model, FUN = prune.misclass)
names(cv_tree)


plot(cv_tree$size,
     cv_tree$dev,
     type = "b")



### prune the tree
pruned_model = prune.misclass(tree_model, best = 9)
plot(pruned_model)
text(pruned_model, pretty=0)


### check how it is doing
tree_pred = predict(pruned_model, testing_data, type="class")
mean(tree_pred != testing_high) #23%