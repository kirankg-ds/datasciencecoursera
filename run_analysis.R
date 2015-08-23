## run_analysis.R
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Assumptions:
## 1. The data was first downloaded from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzipped to ./data/UCI HAR Dataset directory
## 2. Package dplyr is installed for data table manipulation
## 3. Package data.table is installed

## Load data.table and dplyr package
library(data.table)
library(dplyr)

# Create names of columns for activities and featuers
activityNames = read.table("./data/UCI HAR Dataset/activity_labels.txt",header=FALSE)
featureNames = read.table("./data/UCI HAR Dataset/features.txt")[,2]

# Create variables for train data
activityTrainData <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE)
featureTrainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE)
subjectTrainData <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Create variables for test data
activityTestData <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE)
featureTestData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE)
subjectTestData <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

# Exercise 1: Merge the training and the test sets to create one data set.
# Each pairs of datasets for subject, activity, and features are merged:
# Merging is done with rbind (i.e., merge rows)

activityData <- rbind(activityTrainData, activityTestData)
featureData <- rbind(featureTrainData, featureTestData)
subjectData <- rbind(subjectTrainData, subjectTestData)

colnames(featureData) <- t(featureNames)
colnames(activityData) <- "Activities"
colnames(subjectData) <- "Subjects"

merged_HAR_Data <- cbind(featureData,activityData,subjectData)


## Exercise 2: Extract only the measurements on the mean and standard deviation for each measurement. 
## We use the grep command to look for "Mean" and "Std" ignoring the case
colsSubsetMeanStd <- grep(".*Mean.*|.*Std.*", names(merged_HAR_Data),ignore.case=TRUE)

## The above line returns only columns that have 'mean' or 'std' in them.
## So, we now need to add back the Activities and Subjects columns, which are columns 562 and 563

ex2ColumnsMerged_HAR_Data <- c(colsSubsetMeanStd, 562, 563)

## Now, create an extract of the specified columns from the full data set
ex2Merged_HAR_Data <- merged_HAR_Data[,ex2ColumnsMerged_HAR_Data]

## Exercise 3. Use descriptive activity names to name the activities in the data set
## Assume that this exercise deals with the subset of data from exercise 2 (i.e., all observations with ony mean and std columsn)
## The values in the Activities column are numeric. Change the column's type to character
 ex2Merged_HAR_Data$Activities <- as.character(ex2Merged_HAR_Data$Activities)
 
 for (i in 1:6) {
   ex2Merged_HAR_Data$Activities[ex2Merged_HAR_Data$Activities == i] <- as.character(activityNames[i,2])
 }
 
 ex2Merged_HAR_Data$Activities <- as.factor(ex2Merged_HAR_Data$Activities)
 
 ## Check that the substitution has taken place:
 head(ex2Merged_HAR_Data$Activities,45)
 
 ## Exercise 4. Appropriately labels the data set with descriptive variable names. 
 ## From examining the names, the following substitutions must be made:
 ## Names starting with t: "t" replaced by Time
 ## Names starting with f: "f" replaced by Frequency
 ## "Acc" with "Accelerometer"
 ## "Gyro" with "Gyroscope"
 ## "BodyBody" with "Body"
 ## "Mag" with "Magnitude"

 names(ex2Merged_HAR_Data)<-gsub("^t", "Time", names(ex2Merged_HAR_Data))
 names(ex2Merged_HAR_Data)<-gsub("^f", "Frequency", names(ex2Merged_HAR_Data))
 names(ex2Merged_HAR_Data)<-gsub("Acc", "Accelerometer", names(ex2Merged_HAR_Data))
 names(ex2Merged_HAR_Data)<-gsub("Gyro", "Gyroscope", names(ex2Merged_HAR_Data))
 names(ex2Merged_HAR_Data)<-gsub("BodyBody", "Body", names(ex2Merged_HAR_Data))
 names(ex2Merged_HAR_Data)<-gsub("Mag", "Magnitude", names(ex2Merged_HAR_Data))

 ## Check that the names have changed in the ex2Merged_HAR_Data:
 names(ex2Merged_HAR_Data)
 
 ## Exercise 5. Using data in exercise 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
 ## We use dplyr here
 ex2Merged_HAR_Data_tb <- data.table(ex2Merged_HAR_Data)
 tidyData <- aggregate(. ~Subjects + Activities, ex2Merged_HAR_Data_tb, mean)
 tidyData <- tidyData[order(tidyData$Subjects,tidyData$Activities),]
 write.table(tidyData,file="tidydata.txt", row.names = FALSE)


