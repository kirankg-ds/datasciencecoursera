---
title: "CodeBook for run_analysis.R"
author: "Kiran Garimella"
date: "August 23, 2015"
output: html_document
---

## run_analysis.R
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names. 
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Assumptions:
### 1. The data was first downloaded from 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzipped to ./data/UCI HAR Dataset directory
### 2. Package dplyr is installed for data table manipulation
### 3. Package data.table is installed

#Steps and transformations

1. Load data.table and dplyr package
2. Create names of columns for activities and featuers
3. Create variables for train data

## Exercise 1: Merge the training and the test sets to create one data set.
Each pairs of datasets for subject, activity, and features are merged:
Merging is done with rbind (i.e., merge rows)

## Exercise 2: Extract only the measurements on the mean and standard deviation for each measurement. 
1. We use the grep command to look for "Mean" and "Std" ignoring the case
2. We add back the Activities and Subjects columns, which are columns 562 and 563
3. Create an extract of the specified columns from the full data set

## Exercise 3. Use descriptive activity names to name the activities in the data set
Assume that this exercise deals with the subset of data from exercise 2 (i.e., all observations with ony mean and std columsn)
The values in the Activities column are numeric. Change the column's type to character.

## Exercise 4. Appropriately labels the data set with descriptive variable names. 
From examining the names, the following substitutions must be made:
* Names starting with t: "t" replaced by Time
* Names starting with f: "f" replaced by Frequency
* "Acc" with "Accelerometer"
* "Gyro" with "Gyroscope"
* "BodyBody" with "Body"
* "Mag" with "Magnitude"

## Exercise 5. Using data in exercise 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

###Names of tidyData columns:

 [1] "Subjects"                                           "Activities"                                        
 [3] "TimeBodyAccelerometer-mean()-X"                     "TimeBodyAccelerometer-mean()-Y"                    
 [5] "TimeBodyAccelerometer-mean()-Z"                     "TimeBodyAccelerometer-std()-X"                     
 [7] "TimeBodyAccelerometer-std()-Y"                      "TimeBodyAccelerometer-std()-Z"                     
 [9] "TimeGravityAccelerometer-mean()-X"                  "TimeGravityAccelerometer-mean()-Y"                 
[11] "TimeGravityAccelerometer-mean()-Z"                  "TimeGravityAccelerometer-std()-X"                  
[13] "TimeGravityAccelerometer-std()-Y"                   "TimeGravityAccelerometer-std()-Z"                  
[15] "TimeBodyAccelerometerJerk-mean()-X"                 "TimeBodyAccelerometerJerk-mean()-Y"                
[17] "TimeBodyAccelerometerJerk-mean()-Z"                 "TimeBodyAccelerometerJerk-std()-X"                 
[19] "TimeBodyAccelerometerJerk-std()-Y"                  "TimeBodyAccelerometerJerk-std()-Z"                 
[21] "TimeBodyGyroscope-mean()-X"                         "TimeBodyGyroscope-mean()-Y"                        
[23] "TimeBodyGyroscope-mean()-Z"                         "TimeBodyGyroscope-std()-X"                         
[25] "TimeBodyGyroscope-std()-Y"                          "TimeBodyGyroscope-std()-Z"                         
[27] "TimeBodyGyroscopeJerk-mean()-X"                     "TimeBodyGyroscopeJerk-mean()-Y"                    
[29] "TimeBodyGyroscopeJerk-mean()-Z"                     "TimeBodyGyroscopeJerk-std()-X"                     
[31] "TimeBodyGyroscopeJerk-std()-Y"                      "TimeBodyGyroscopeJerk-std()-Z"                     
[33] "TimeBodyAccelerometerMagnitude-mean()"              "TimeBodyAccelerometerMagnitude-std()"              
[35] "TimeGravityAccelerometerMagnitude-mean()"           "TimeGravityAccelerometerMagnitude-std()"           
[37] "TimeBodyAccelerometerJerkMagnitude-mean()"          "TimeBodyAccelerometerJerkMagnitude-std()"          
[39] "TimeBodyGyroscopeMagnitude-mean()"                  "TimeBodyGyroscopeMagnitude-std()"                  
[41] "TimeBodyGyroscopeJerkMagnitude-mean()"              "TimeBodyGyroscopeJerkMagnitude-std()"              
[43] "FrequencyBodyAccelerometer-mean()-X"                "FrequencyBodyAccelerometer-mean()-Y"               
[45] "FrequencyBodyAccelerometer-mean()-Z"                "FrequencyBodyAccelerometer-std()-X"                
[47] "FrequencyBodyAccelerometer-std()-Y"                 "FrequencyBodyAccelerometer-std()-Z"                
[49] "FrequencyBodyAccelerometer-meanFreq()-X"            "FrequencyBodyAccelerometer-meanFreq()-Y"           
[51] "FrequencyBodyAccelerometer-meanFreq()-Z"            "FrequencyBodyAccelerometerJerk-mean()-X"           
[53] "FrequencyBodyAccelerometerJerk-mean()-Y"            "FrequencyBodyAccelerometerJerk-mean()-Z"           
[55] "FrequencyBodyAccelerometerJerk-std()-X"             "FrequencyBodyAccelerometerJerk-std()-Y"            
[57] "FrequencyBodyAccelerometerJerk-std()-Z"             "FrequencyBodyAccelerometerJerk-meanFreq()-X"       
[59] "FrequencyBodyAccelerometerJerk-meanFreq()-Y"        "FrequencyBodyAccelerometerJerk-meanFreq()-Z"       
[61] "FrequencyBodyGyroscope-mean()-X"                    "FrequencyBodyGyroscope-mean()-Y"                   
[63] "FrequencyBodyGyroscope-mean()-Z"                    "FrequencyBodyGyroscope-std()-X"                    
[65] "FrequencyBodyGyroscope-std()-Y"                     "FrequencyBodyGyroscope-std()-Z"                    
[67] "FrequencyBodyGyroscope-meanFreq()-X"                "FrequencyBodyGyroscope-meanFreq()-Y"               
[69] "FrequencyBodyGyroscope-meanFreq()-Z"                "FrequencyBodyAccelerometerMagnitude-mean()"        
[71] "FrequencyBodyAccelerometerMagnitude-std()"          "FrequencyBodyAccelerometerMagnitude-meanFreq()"    
[73] "FrequencyBodyAccelerometerJerkMagnitude-mean()"     "FrequencyBodyAccelerometerJerkMagnitude-std()"     
[75] "FrequencyBodyAccelerometerJerkMagnitude-meanFreq()" "FrequencyBodyGyroscopeMagnitude-mean()"            
[77] "FrequencyBodyGyroscopeMagnitude-std()"              "FrequencyBodyGyroscopeMagnitude-meanFreq()"        
[79] "FrequencyBodyGyroscopeJerkMagnitude-mean()"         "FrequencyBodyGyroscopeJerkMagnitude-std()"         
[81] "FrequencyBodyGyroscopeJerkMagnitude-meanFreq()"     "angle(tBodyAccelerometerMean,gravity)"             
[83] "angle(tBodyAccelerometerJerkMean),gravityMean)"     "angle(tBodyGyroscopeMean,gravityMean)"             
[85] "angle(tBodyGyroscopeJerkMean,gravityMean)"          "angle(X,gravityMean)"                              
[87] "angle(Y,gravityMean)"                               "angle(Z,gravityMean)"

###dim(tidyData)
180 rows, 88 columns

