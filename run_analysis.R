
library(plyr) 
library(dplyr) #Use for manipulating the data

Xtest  <- tbl_df(read.table(file = "test/X_test.txt"))
Xtrain <- tbl_df(read.table(file = "train/X_train.txt"))

Ytest <- read.table("test/y_test.txt")
Ytrain <- read.table("train/y_train.txt")
SubjectTest <- read.table("test/subject_test.txt")
SubjectTrain <- read.table("train/subject_train.txt")
Features <- read.table("features.txt")
ActLabel <- read.table("activity_labels.txt")

##Manipulating the two datasets

colnames(Xtest) <- Features[,2]
colnames(Xtrain)<- Features[,2]

Xtest$Activity <- Ytest[,1] 
Xtrain$Activity <- Ytrain[,1]
Xtest$Subject <- SubjectTest[,1]
Xtrain$Subject <- SubjectTrain[,1]

##Merging: Assignment 1

merge <- tbl_df(rbind(Xtest,Xtrain))
if(sum(duplicated(colnames(merge)))>0){
        merge <- merge[,!duplicated(colnames(merge))] ##Remove duplicated Variables
}

##Mean and Std Deviation: Assignment 2

Xbar <- merge[,grep("[Mm][e][a][n]",colnames(merge))]
Sbar <- merge[,grep("[Ss][t][d]",colnames(merge))]

##Naming: Assignment 3

merge$Activity <- sapply(X = merge$Activity, y = ActLabel,
                         function(x, y){x <- y[x,2]})

##By the file features_info, there is someabreviations
#f: Frequency; t:Time ; Mag: Magnitude; Acc: Accelerator; Gyro:Gyroscope

names(merge) <- gsub("^f","Frequency",names(merge))
names(merge) <- gsub("^t","Time",names(merge))
names(merge) <- gsub("Mag","MAgnitude",names(merge))
names(merge) <- gsub("Acc","Accelerator",names(merge))
names(merge) <- gsub("Gyro","Gyroscope",names(merge))
##names(merge) <- gsub("()","Gyroscope",names(merge))

merge$Subject <- as.factor(sapply(X = merge$Subject,
                           function(x){x <- paste("Participant", x, sep = " ")}))

merge <- group_by(merge, Subject, Activity)

TidyData <- summarize_each(merge, funs(mean))

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
a = NULL
a <- ls()
a <- a[which(a!="TidyData" & a!="Xtest" & a!="Xtrain")]
rm(list = a)
