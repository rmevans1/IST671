#Market basket analysis
  #Used for product recomendations
  #Uses transactional data- data where each row is a transaction (i.e. order on amazon)

  #create a sparse matrix
    #matrix of mostly empty values- each row is a transaction each column is an item
      #1 represents item in transaction
      #empty value represents item not in transaction
    #gives structure to unstructured data
    #saves on memory

#arules handles this kind of dataa
#install.packages("arules")
require(arules)
Groc <- read.transactions("data/groceries.csv", sep=",")
Groc

#Summary of data
  #density is the number of non empty cells / total number of cells
  #gives a list of most frequent items
  #gives a list of transactions item counts (transaction with 1, 2, 3, etc. items)
  #shows min/max/median/mean transaction item counts
summary(Groc)
