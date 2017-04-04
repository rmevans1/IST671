#Section 8.5.1
sc <- read.table("data/synthetic_control.data", header=F, sep="")
classId <- c(rep("1",100), rep("2",100), rep("3",100),
             rep("4",100), rep("5",100), rep("6",100))
newSc <- data.frame(cbind(classId, sc))

library(party)
ct <- ctree(classId ~ ., data=newSc,
            controls = ctree_control(minsplit=30, minbucket=10, maxdepth =5))
pClassId <- predict(ct)
table(classId, pClassId)

#accuracy
(sum(classId==pClassId))/nrow(sc)

#plot decision tree
plot(ct, ip_args=list(pval=FALSE), ep_args=list(digits=0))

#Section 8.5.2
#install.packages("wavelets")
library(wavelets)
wtData <- NULL
for(i in 1:nrow(sc)) {
  a <- t(sc[i,])
  wt <- dwt(a, filter="haar", boundary="periodic")
  wtData <- rbind(wtData,
                  unlist(c(wt@W, wt@V[[wt@level]])))
}
wtData <- as.data.frame(wtData)
wtSc <- data.frame(cbind(classId, wtData))

#Create a decision tree with dwt
ct <- ctree(classId ~ ., data = wtSc,
            controls = ctree_control(minsplit=30, minbucket=10, maxdepth=5))
pClassId <- predict(ct)
table(classId, pClassId)

#accuarcy rate
(sum(classId==pClassId)) / nrow(wtSc)

#plot the decision tree
plot(ct, ip_args=list(pval=FALSE), ep_args=list(digits=0))