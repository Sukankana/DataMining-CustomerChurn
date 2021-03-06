library (party)
library (randomForest)


#Random Forest
inputData <- read.csv("C:/Users/Sukankana/Documents/DataSets/cleaned.csv",header = T)
input.roughfix <- na.roughfix(inputData)
input.roughfix$churn <- as.character(input.roughfix$churn)
input.roughfix$churn <- as.factor(input.roughfix$churn)
rf <- randomForest(churn ~pre_hnd_price+hnd_price+asl_flag+hnd_webcap+models+phones, data=input.roughfix, importance=TRUE, proximity=TRUE)
print(rf)
getTree(rf)


#Random Forest using CForestMod
set.seed (100)
train <- sample(1:nrow(input.roughfix), 0.7*nrow(input.roughfix))
trainData <- input.roughfix[train,]
testData <- input.roughfix[-train,]
cForestMod <- cforest(churn ~ pre_hnd_price + hnd_price + asl_flag +      hnd_webcap + models + phones, data = trainData)
actuals <- testData$churn
predicted <- predict(cForestMod, newdata = testData)
table (true = actuals, pred = predict(cForestMod, newdata = testData))
mean (testData$churn != predicted)

#Decision Tree
cTreeMod <- ctree (churn ~ pre_hnd_price + hnd_price + asl_flag +      hnd_webcap + models + phones, data = trainData)
predicted <- predict(cTreeMod, newdata = testData)
mean (testData$churn != predicted)
plot(cTreeMod)
