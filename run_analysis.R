#------------------------------------------------------------------------------
# This is my R script submission for the peer assesment in the Coursera 
# training, (Getting and Cleaning Data)
#
# Created by Martin Haneferd, 07. Aug. 2016
#
# It is organized in the following sections:
# 
# 0.  Load libraries used in the project
#
# 1. Merges the training and the test sets to create one data set.
#
# 2. Extracts only the measurements on the mean and standard 
#    deviation for each measurement.
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropriately labels the data set with descriptive variable names.
#
# 5. From the data set in step 4, creates a second, independent tidy 
#    data set with the average of each variable for each activity 
#    and each subject.
#
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 0. Load libraries used in the project
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Load RCurl and dplyr:
library(RCurl)
library(dplyr)


#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 1. Merge the test and train dataset into mergeRecords dataset
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Download and unpack the data for the project
#------------------------------------------------------------------------------

# Create data directory for all the data files.
if(!file.exists("./data")){ dir.create("./data") }

# Download the zipped files containing datasets
zipfile="./data/projectfiles.zip"
if(!file.exists("./data/projectfiles.zip")){
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, destfile=zipfile, method="libcurl")
}

# Unpack files to data directory
unzip(zipfile, exdir = "./data")

# Clean up unneccesary values from environment:
rm(fileUrl)
rm(zipfile)

#------------------------------------------------------------------------------
# Read the datasets 
#------------------------------------------------------------------------------

trainRecords <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
str(trainRecords) # data.frame':	7352 obs. of  561 variables

trainLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
str(trainLabels) # data.frame':	7352 obs. of  1 variable

trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
str(trainSubject) # data.frame':	7352 obs. of  1 variable

testRecords <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
str(testRecords) # 'data.frame':	2947 obs. of  561 variables

testLabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt") 
str(testLabels) # 'data.frame':	2947 obs. of  1 variable

testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
str(testLabels) # 'data.frame':	2947 obs. of  1 variable

features <- read.table("./data/UCI HAR Dataset/features.txt")
str(features) # 'data.frame':	561 obs. of  2 variables

activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
str(activityLabels) # 'data.frame':	6 obs. of  2 variables


#------------------------------------------------------------------------------
# Merge the training and the test dataset records. 
#------------------------------------------------------------------------------

mergeRecords <- rbind(trainRecords, testRecords) 
dim(mergeRecords) # [1] 10299   561

mergeLabels <- rbind(trainLabels, testLabels)
dim(mergeLabels) # [1] 10299   1

mergeSubject <- rbind(trainSubject, testSubject)
dim(mergeLabels) # [1] 10299   1

# Get rid of the environment data no longer to be used to free up memory:
rm(testSubject)
rm(testLabels)
rm(testRecords)
rm(trainLabels)
rm(trainSubject)
rm(trainRecords)


#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 2. Extracts only the measurements on the mean and 
#    standard deviation for each measurement.
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# features has the variable names, but we only need the mean and std, 
mean_std_variables <- grep('-(mean|std)\\(', features[, 2])

# Extract only the mean and std variables out of the merged records, 
mergeRecords <- mergeRecords[, mean_std_variables]


#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 3. Uses descriptive activity names to name the activities in the data set
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------


# Make all words lowercase to ease reading 
# ( I think lowercase is better than uppercase )
activityLabels[, 2] <- tolower(activityLabels[, 2]) 

# fill the activity labels
fullActivityLabels <- activityLabels[mergeLabels[, 1], 2] 

# Replace the activityindex in the merged label dataframe with the real 
# activity labels
mergeLabels[, 1] <- fullActivityLabels

# Get rid of the environment data no longer to be used to free up memory:
rm(fullActivityLabels)
rm(activityLabels)


# In RStudio, Verify the final result of the activity label dataset.
# View(mergeLabels)

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 4. Appropriately labels the data set with descriptive variable names.
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Put a descriptive variable name in the Merged label dataframe.
names(mergeLabels) <- "activity"

# Put a descriptive variable name in the Merged subject dataframe.
names(mergeSubject) <- "subject"

# Make the variable names appropriate for the main dataset.
# I will remove the () and - from the variable name.
# I will use full names to avoid confusion
names(mergeRecords) <- features[mean_std_variables, 2] # Give the variables names.
names(mergeRecords) <- gsub("\\(\\)", "", names(mergeRecords)) # Remove "()"
names(mergeRecords) <- gsub("-", "", names(mergeRecords)) # Remove "-"
names(mergeRecords) <- gsub("std", "Std", names(mergeRecords))
names(mergeRecords) <- gsub("mean", "Mean", names(mergeRecords)) 
names(mergeRecords) <- gsub("^t", "time", names(mergeRecords))
names(mergeRecords) <- gsub("^f", "freq", names(mergeRecords))
names(mergeRecords) <- gsub("BodyBody", "Body", names(mergeRecords))

# Get rid of the environment data no longer to be used to free up memory:
rm(mean_std_variables)
rm(features)


#------------------------------------------------------------------------------
# Merge the subject and activity label dataset with the activity records into 
# a new dataframe (tidyactivityData)
# The activityData dataframe has descriptive variable names, and the 
# information of each subject activity with Mean and Standard Deviation values.
#------------------------------------------------------------------------------
tidyActivityData <- cbind(mergeSubject, mergeLabels, mergeRecords)

dim(tidyActivityData) # Should be: [1] 10299    68

# tidyActivityData[1:3, 1:5] # Light Checking content:

# Get rid of the environment data no longer to be used to free up memory:
rm(mergeLabels)
rm(mergeRecords)
rm(mergeSubject)


# Write the Tidy dataset to disk in the current data directory
write.table(tidyActivityData, "./data/tidy_activity_data.txt") 

#------------------------------------------------------------------------------
# Verify that the saving of the data set is succsessful, and it can be read.
#------------------------------------------------------------------------------
verifyTidyActivityData <- read.table("./data/tidy_activity_data.txt", header=TRUE)
str(verifyTidyActivityData) # 'data.frame':	10299 obs. of  68 variables
View(verifyTidyActivityData)
# Remove the verification dataset from memory:
rm(verifyTidyActivityData) 

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#
# 5. From the data set in step 4, creates a second, independent 
#    tidy data set with the average of each variable for 
#    each activity and each subject.
#
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Calculate the average of each variable for each activity and each subject. 
# Here we aggregate columns 3 to 68 of data.frame tidyActivityData, grouping by 
# subject and activity, and applying the mean function.
newTidyDataset <- aggregate(tidyActivityData[, 3:68], list(subject = tidyActivityData$subject,activity = tidyActivityData$activity), mean)
dim(newTidyDataset) # [1] 180  68

# Remove the old tidy dataset from memory:
rm(tidyActivityData) 

# Sort the new dataset by subject:
newTidyDataset <- arrange(newTidyDataset,subject)

# Update the variable names with Average, since the rows contains the average
# of the values in each group (Subject, Activity) now.
names(newTidyDataset) <- gsub("^time", "averageTime", names(newTidyDataset))
names(newTidyDataset) <- gsub("^freq", "averageFreq", names(newTidyDataset))

# Write the new tidy dataset to disk in the current data directory
write.table(newTidyDataset, "./data/tidy_average_activity_data.txt") 


# Remove the tidy dataset from memory
rm(newTidyDataset)

#------------------------------------------------------------------------------
# Verify that the saving of the data set is succsessful, and it can be read.
#------------------------------------------------------------------------------
verifyTidyAverageData <- read.table("./data/tidy_average_activity_data.txt", header=TRUE)
str(verifyTidyAverageData) # data.frame':	180 obs. of  68 variables:
View(verifyTidyAverageData)
# Remove the verification dataset from memory:
rm(verifyTidyAverageData) 
