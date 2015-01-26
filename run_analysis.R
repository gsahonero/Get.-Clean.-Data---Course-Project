## run_analysis Script
## Check if the data directory exists and create if it doesn't
## Also, it downloads the data
if(!file.exists("./data")) {
    dir.create("./data")
    ## Download and unzip dataset
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    tempFile <- tempfile()
    download.file(fileURL, tempFile, method = "curl")
    unzip(tempFile, exdir = "./data")
}

## Reading the files as CSV
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                          header = F, stringsAsFactors = F, fill = T)
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                    header = F, stringsAsFactors = F, fill = T)
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                    header = F, stringsAsFactors = F, fill = T)
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                           header = F, stringsAsFactors = F, fill = T)
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                     header = F, stringsAsFactors = F, fill = T)
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                     header = F, stringsAsFactors = F, fill = T)

#### Merging, combining the data
mergedData <- cbind(rbind(testSubject, trainSubject),
                    rbind(testY, trainY),
                    rbind(testX, trainX))

## Reading the columns' names features.txt
features <- read.table("./data/UCI HAR Dataset/features.txt",
                       header = F, stringsAsFactors = F, fill = T)
## Setting the names
colnames(mergedData)[1:2] <- c("Subject", "Activity")
colnames(mergedData)[3:563] <- features[, 2]

## Finding the columns where mean or std are located
mergedData <- mergedData[, grepl("mean()|std()|Activity|Subject", colnames(mergedData)) & !grepl("meanFreq", colnames(mergedData))]

## Read activity names from activity_labels.txt
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                         header = F, stringsAsFactors = F, fill = T)

## Descriptive names from the activity_labels file
mergedData$Activity <- factor(mergedData$Activity, levels = activities[, 1], labels = activities[, 2])

## Create a second data set with the average of each variable given each activity and subject.
require(plyr)

tidyData <- ddply(mergedData,
                  .(Subject, Activity),
                  .fun=function(x) { colMeans(x[ ,-c(1:2)]) })
## Creating the tidy data set
write.csv(tidyData, "./tidydata.txt", row.names = FALSE)