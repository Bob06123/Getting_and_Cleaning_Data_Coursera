##########
# This script will perform create a tidy output file based on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# Following main steps will be performed 
# 1. Downloading and unzipping dataset in a directory called "dataUCI", reading in files
# 2. Assigning column names that are stored in the text files
# 3. Merging the sets (train and test) to have one data set
# 4. Getting the mean and standard deviation for each measurement and set activity names
# 5. CCreate Output dataset as requested: Independent tidy data set with the average of each variable for each activity and each subject
##
##########

### Downloading and unzipping dataset in a directory called "dataUCI"
## information about the dataset can be found in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

if(!file.exists("./dataUCI")){dir.create("./dataUCI")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./dataUCI/Dataset.zip")

# Unzip in the /dataUCI directory
unzip(zipfile="./dataUCI/Dataset.zip",exdir="./dataUCI")

# Reading trainings tables, maintaining the same naming for clarity
x_train <- read.table("./dataUCI/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./dataUCI/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./dataUCI/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables again maintaining the naming for clarity
x_test <- read.table("./dataUCI/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./dataUCI/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./dataUCI/UCI HAR Dataset/test/subject_test.txt")

# Reading feature information and activity labels
features <- read.table('./dataUCI/UCI HAR Dataset/features.txt')
activityLabels = read.table('./dataUCI/UCI HAR Dataset/activity_labels.txt')

### Assigning column names that are stored in the text files
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

### Merging the sets (train and test) to have one data set

mergeTrain <- cbind(y_train, subject_train, x_train)
mergeTest <- cbind(y_test, subject_test, x_test)
AllTogether <- rbind(mergeTrain, mergeTest)

### Getting the mean and standard deviation for each measurement and set activity names
## First read the columnnames and then create a vector for ID, mean and Standard Deviation
## Then making a subset to be used further

colNames <- colnames(AllTogether)
meanAndStandarddev <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | 
                         grepl("std.." , colNames))
meanAndStandarddev_list <- AllTogether[ , meanAndStandarddev == TRUE] 

## Merging the dataset with activity names 

baseSetWithNames <- merge(meanAndStandarddev_list, activityLabels,
                          by='activityId',
                          all.x=TRUE)

### Create Output dataset as requested: Independent tidy data set with the average of each variable for each activity and each subject
## This is written to disk as Second_tidy_UCI.txt

tidiedDataset <- aggregate(. ~subjectId + activityId, baseSetWithNames, mean)
write.table(tidiedDataset, "Second_tidy_UCI.txt", row.name=FALSE)

