library(nnet)
library(party)
library(randomForest)
library(e1071)
set.seed(65)
train <- read.csv("C:/Users/Hamed/Desktop/Data Science/Kaggle/Forest Cover Type Prediction/Question/train.csv")
test <- read.csv("C:/Users/Hamed/Desktop/Data Science/Kaggle/Forest Cover Type Prediction/Question/test.csv")

train <- data.frame(train)
train <- train[,-1]

test <- data.frame(test)
test <- test[,-1]

#with PCA
#transData <- preProcess(train[,1:54], c("BoxCox", "center", "scale"))
#predictorsTransData = data.frame(trans = predict(transData, train[,1:54]))
#transTarget = preProcess(test, c("BoxCox", "center", "scale"))
#predictorsTransTarget = data.frame(trans = predict(transTarget, test))
#train.rf <- nnet(as.factor(train$Cover_Type)~. , data = predictorsTransData, size = 27,decay=.1,MaxNWts= 2000, maxit=1000)
#pre <- predict(train.rf, predictorsTransTarget, type = "class")
#train.rf <- cforest(as.factor(Cover_Type) ~ ., data=train, control = cforest_unbiased(ntree =50))
#pre <- predict(train.rf, test, OOB=TRUE, type = "response")
#pre1 <- predict(train.rf, test[1:10000,], OOB=TRUE, type = "response") ba in khub kar kard!
#pre2 <- predict(train.rf, test[300001:565892,], OOB=TRUE, type = "response")
#train.rf <- nnet(as.factor(Cover_Type)~. , data = train, size = 27,decay=.01, MaxNWts= 2000,maxit=1000)
#pre <- predict(train.rf, test, type = "class")


#train.rf <- randomForest(as.factor(train$Cover_Type) ~. , data = train)
#pre <- predict(train.rf,test, type = "response")
train.rf <- randomForest(as.factor(train$Cover_Type) ~. , data = train, ntree=600, mtry=18)
pre <- predict(train.rf,test, type = "response")

high_importance <- which(importance(train.rf) > 50)
train1 <- cbind(train[,high_importance], train[55])
test1 <- cbind(test[,high_importance])
train1.rf <- randomForest(as.factor(train1$Cover_Type) ~. , data = train1, ntree=600, mtry=18)
pre1 <- predict(train1.rf,test1, type = "response")
#train.svm <- svm(as.factor(train1$Cover_Type)~. , data = train1, type = "nu-classification")
#pre.svm <- predict(train.svm, test1)

#train.nnet <- nnet(as.factor(Cover_Type)~. , data = train1, size = 15,decay=.01, MaxNWts=
2000, maxit=1000)
#pre.nnet <- predict(train.nnet, test1, type = "class")
#train.cf <- cforest(as.factor(Cover_Type) ~ ., data=train1, control = cforest_unbiased(ntree =
50))
#pre.cf <- predict(train.cf, test1, OOB=TRUE, type = "response")
t <- 15121:581012
t <- data.frame(t)
t[,2] <- pre1

colnames(t) <- c("Id","Cover_Type")
write.csv(t, file = "C:/Users/Hamed/Desktop/Windows/Data Science/Kaggle/Forest Cover Type Prediction/Question/submission.csv", row.names = FALSE)

