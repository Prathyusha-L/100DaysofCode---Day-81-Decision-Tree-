#install.packages("C50")


balanceCSV <- read.csv("c:\\R\\balance-scale - Copy.csv")
str(balanceCSV)
summary(balanceCSV)


balanceDF <- balanceCSV[order(runif(nrow(balanceCSV))),]
tail(balanceDF,25)

balanceDF_train <- balanceDF[1:550,]
balanceDF_test <- balanceDF[551:625,]

nrow(balanceDF_train)
nrow(balanceDF_test)
require(C50)


#C5.0 Train
C50_model<- C5.0(balanceDF_train[,-1],balanceDF_train[,1])
summary(C50_model)

plot(C50_model)


#C5.0 Predict

C50_predict<- predict(C50_model,balanceDF_test)
C50_predict


#Compare
table(balanceDF_test[,1],C50_predict)



#C5.0 Train Improve performance
C50_model<- C5.0(balanceDF_train[,-1],balanceDF_train[,1],trials=10)
summary(C50_model)


#C5.0 Predict Class

C50_predict_class<- predict(C50_model,balanceDF_test, method = "class")
C50_predict_class



#Compare
table(balanceDF_test[,1],C50_predict_class)



#C5.0 Predict Prob

C50_predict_prob<- predict(C50_model,balanceDF_test, method = "prob")
C50_predict_prob

#Compare
table(balanceDF_test[,1],C50_predict_prob)
