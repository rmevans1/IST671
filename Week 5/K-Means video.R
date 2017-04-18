#load iris data set
Iris <- iris

Iris.features = Iris
Iris.features$Species <- NULL
View(Iris.features)

results <- kmeans(Iris.features, 3)
results

table(Iris$Species, results$cluster)
