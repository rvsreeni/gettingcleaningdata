ftr <- read.table("features.txt")
alr <- read.table("activity_labels.txt")

xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
sjtrain <- read.table("subject_train.txt")
names(xtrain) <- ftr$V2
colv <- grep("mean\\(\\)|std\\(\\)", names(xtrain))
xtrain_sub <- xtrain[,colv]
names(sjtrain) <- c("subject")
names(ytrain) <- c("activity")
df_train <- data.frame("train", sjtrain, ytrain, xtrain_sub)
names(df_train)[1] <- "type"

xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
sjtest <- read.table("subject_test.txt")
names(xtest) <- ftr$V2
colv <- grep("mean\\(\\)|std\\(\\)", names(xtest))
xtest_sub <- xtest[,colv]
names(sjtest) <- c("subject")
names(ytest) <- c("activity")
df_test <- data.frame("test", sjtest, ytest, xtest_sub)
names(df_test)[1] <- "type"

df_comb_train_test <- rbind(df_train, df_test)

oas_comb_train_test <- df_comb_train_test[order(df_comb_train_test$act, df_comb_train_test$subject),]
oas_aggdata <- aggregate(oas_comb_train_test, by=list(oas_comb_train_test$act, oas_comb_train_test$subject), FUN=mean)
oas_aggdata$Group.1 <- NULL
oas_aggdata$Group.2 <- NULL
oas_aggdata$type <- NULL

oas_aggdata$id <- 1:nrow(oas_aggdata)
oas_al_merge = merge(alr, oas_aggdata, by.x="V1", by.y="activity", sort = FALSE)
oas_al_order <- oas_al_merge[order(oas_al_merge$id),]
oas_al_order$V1 <- NULL
names(oas_al_order)[1] <- "activity"
df_result <- oas_al_order
write.table(df_result,file="result.txt",row.names=FALSE,sep=",")




