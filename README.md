---
title: "README"
author: "Kiran Garimella"
date: "August 23, 2015"
output: html_document
---

#This document explains the sequence of steps and purpose of the various functions


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

### Load data.table and dplyr package
library(data.table)
library(dplyr)

### Create names of columns for activities and featuers
### Create variables for train data
### Create variables for test data


## Exercise 1: Merge the training and the test sets to create one data set.
Each pairs of datasets for subject, activity, and features are merged:
Merging is done with rbind (i.e., merge rows)

## Exercise 2: Extract only the measurements on the mean and standard deviation for each measurement. 
We use the grep command to look for "Mean" and "Std" ignoring the case
The above line returns only columns that have 'mean' or 'std' in them.
So, we now need to add back the Activities and Subjects columns, which are columns 562 and 563

Now, create an extract of the specified columns from the full data set
ex2Merged_HAR_Data <- merged_HAR_Data[,ex2ColumnsMerged_HAR_Data]

## Exercise 3. Use descriptive activity names to name the activities in the data set
Assume that this exercise deals with the subset of data from exercise 2 (i.e., all observations with ony mean and std columsn)
The values in the Activities column are numeric. Change the column's type to character

 
## Exercise 4. Appropriately labels the data set with descriptive variable names. 
From examining the names, the following substitutions must be made:
* Names starting with t: "t" replaced by Time
* Names starting with f: "f" replaced by Frequency
* "Acc" with "Accelerometer"
* "Gyro" with "Gyroscope"
* "BodyBody" with "Body"
* "Mag" with "Magnitude"

## Exercise 5. Using data in exercise 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
We use dplyr here


