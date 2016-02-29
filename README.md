### Read common files

ftr <- read.table("features.txt")  
alr <- read.table("activity_labels.txt")  

### Read training related files, and build a dataframe "df_train" containing mean and standard deviation for the measurements, along with subject and activity

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

### Read test related files, and build a dataframe "df_test" containing mean and standard deviation for the measurements, along with subject and activity

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

### Merge (rowwise) both training and test dataframes 

df_comb_train_test <- rbind(df_train, df_test)  

### Aggregate data on key (subject, activity) using Mean function , removing columns that are not required 

oas_comb_train_test <- df_comb_train_test[order(df_comb_train_test$act, df_comb_train_test$subject),]  
oas_aggdata <- aggregate(oas_comb_train_test, by=list(oas_comb_train_test$act, oas_comb_train_test$subject), FUN=mean)  
oas_aggdata$Group.1 <- NULL  
oas_aggdata$Group.2 <- NULL  
oas_aggdata$type <- NULL  

### Substitute the Activity code with the corresponding label, removing columns that are not required, the final result is stored in dataframe "df_result",
### and written to result.txt 

oas_aggdata$id <- 1:nrow(oas_aggdata)  
oas_al_merge = merge(alr, oas_aggdata, by.x="V1", by.y="activity", sort = FALSE)  
oas_al_order <- oas_al_merge[order(oas_al_merge$id),]  
oas_al_order$V1 <- NULL  
names(oas_al_order)[1] <- "activity"  
df_result <- oas_al_order  
write.table(df_result,file="result.txt",row.names=FALSE,sep=",")  

### Dataframes
df_train - dataframe containing mean and standard deviation for Training measurements, along with subject and activity  
df_test - dataframe containing mean and standard deviation for Test measurements, along with subject and activity  
df_comb_train_test - dataframe comtaining merged (rowwise) Training aand Test data  
oas_aggdata  - dataframe containing Mean aggregate data on the key(subject, activity  
df_result - dataframe containing final results  
