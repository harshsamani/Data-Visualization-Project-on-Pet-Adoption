#adoption speed based on pet type
adopt<-read.csv(choose.files())
adopy_copy<-adopt

#SET SEED VALUE 
set.seed(1234)

#CLASSIFYING INTO TRAINING AND DATA SET
ddin<-sample(2, nrow(adopy_copy),replace = TRUE,prob = c(0.7,0.3))

#defining training data and test data
train_data<-adopy_copy[ddin==1,] #where row is marked as 1 we extract as train
test_data<-adopy_copy[ddin==2,] #where row is marked as 2 we extract as test

#choosing a set of variables from the dataset that as an implication on classification

kk<-Type~VideoAmt+Health+AdoptionSpeed

#condition inference tree function

library(party)

#DEFINING TREE FOR THE TRAIN DATA

pet_tree<-ctree(kk, data= train_data)

#COMPARING ORIGINAL TABLE OF THE DATA TO THE TRAIN DATA TREE

table(predict(pet_tree),train_data$Type)

#VISUALIZE THE TABLE
plot(pet_tree,main="ADOPTION SPEED FROM TRAIN DATA")


#DEFINING TREE FOR THE TEST DATA

pet_tree_test<-ctree(kk,data=test_data)


#VISUALIZE THE RESULT
plot(pet_tree_test,main="ADOPTION SPEED FROM TEST DATA")




