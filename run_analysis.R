## This is the code for the course project in "Getting and Cleaning Data".

## After unzipping the files into a directory named "getdata-project" 
## we load the data and merge the training and the test datasets.

traindata <- read.table("getdata-project/UCI HAR Dataset/train/X_train.txt", header=F)
testdata <- read.table("getdata-project/UCI HAR Dataset/test/X_test.txt", header=F)
subjecttestdata <- read.table("getdata-project/UCI HAR Dataset/test/subject_test.txt", header=F)
subjecttraindata <- read.table("getdata-project/UCI HAR Dataset/train/subject_train.txt", header=F)
activitytestdata <- read.table("getdata-project/UCI HAR Dataset/test/y_test.txt", header=F)
activitytraindata <- read.table("getdata-project/UCI HAR Dataset/train/y_train.txt", header=F)

traindata <- cbind(subjecttraindata, activitytraindata, traindata)
testdata <- cbind(subjecttestdata, activitytestdata, testdata)

mergedata <- rbind(traindata, testdata)

## Assign variable names

features <- read.table("getdata-project/UCI HAR Dataset/features.txt", header=F)
measures <- as.character(features[,2])
names(mergedata) <- c("Subject", "Activity", measures)

## Clean the variable names

colnames(mergedata) <- sub("\\(", "", colnames(mergedata))
colnames(mergedata) <- sub("\\)", "", colnames(mergedata))
colnames(mergedata) <- gsub("-", "", colnames(mergedata))
colnames(mergedata) <- sub("mean", "Mean", colnames(mergedata))
colnames(mergedata) <- sub("std", "Std", colnames(mergedata))

## Now, pick only the relevant variables and subset the data. 
## But first avoid picking the mean frequencies and the last 6 measurements.

colnames(mergedata) <- sub("MeanFre", "MF", colnames(mergedata))
mergedata <- mergedata[,1:557]

means <- grep("Mean", colnames(mergedata))
stds <- grep("Std", colnames(mergedata))
data <- subset(mergedata[, c(1,2,means, stds)])

## Replace the activity labels with the activity

for (i in 1:nrow(data))
{    if(data[i,2] == "1")
     {data[i,2] <- "Walking"}
     else if(data[i,2] == "2")
     {data[i,2] <- "Walking_upstairs"}
     else if(data[i,2] == "3")
     {data[i,2] <- "Walking_downstairs"}
     else if(data[i,2] == "4")
     {data[i,2] <- "Sitting"}
     else if(data[i,2] == "5")
     {data[i,2] <- "Standing"}
     else if(data[i,2] == "6")
     {data[i,2] <- "Laying"}
     else
     {data[i,2] <- "Sommersaulting"}
}

## Now that we have a tidy table,
## we can finally create a crosstable with the means of each activity for each subject.

datamelt<- melt(data, id.vars = c("Subject", "Activity"))
finaldata <- dcast(datamelt, Subject + Activity ~ variable, fun.aggregate = mean)

## Write the resulting table to a file

write.csv(finaldata, "tidydata.txt")