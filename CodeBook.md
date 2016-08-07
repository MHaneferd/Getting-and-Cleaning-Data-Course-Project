---
title: "Codebook for the Getting and Cleaning Data Course Project at Coursera"
author: "Martin Haneferd"
date: "07. aug. 2016"
---

## Project Description

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis. 

The outcome of the project is:

1. a tidy data set to be uploaded to Coursera. *(It will not be included in this Repo, but it can be created with the run_analysis.R script.)*
2. a link to a Github repository with my script for performing the analysis
3. a code book in the repo **(This File)** that describes the variables, the data, and any transformations or work performed to clean up the data
4. a README.md in the repo. This explains how all of the scripts work and how they are connected.
5. a R script in the repo called run_analysis.R that does the following
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used for cleaning can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Study design and data processing
The data collected from the accelerometers from the Samsung Galaxy S smartphone, provided by the datalink (.zip file), includes a collection of files inside the "UCI HAR Dataset" folder. 
The most important file is the README.txt file which decribes how the dataset was collected. And the layout of the dataset.

The dataset includes the following files, which I use in this project:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

###The logic of the Raw datafiles is as followed:

1. The X_ files has the accleometer, gyro, etc. variables. ( No header, only a lot of values)
2. The y_ files has the activity types (connected 1:1) for each rows in the X_ files. The activity type is a value identifier (1 - 6). The values for the identifier is in the activity_labels file.
3. The features.txt has the column names for the X_ files. It has the same column lenght, and must be placed as column variables for the values in the X_ files.
4. The subject files identifies the subject who performed the activity. It is also connected (1:1) to the X_ and y_ file rows.
5. The X_ , y_ and subject files can be *columnized* togheter (They fit.)
6. The activity_labels file is connected to the identifiers in the y_files, and can replace the identifier in y_files with text for the activity ( standing, walking_, etc.) 

###Collection of the raw data
The collection of the .zip file in the project is downloaded by my R-script, run_analysis.R. It is downlodaded and unpacked in a data directory.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

####For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Notes on the original (raw) data 
In this project I am not using the Inertial Signals provided in the dataset.

##Creating the tidy datafile

###Guide to create the tidy data file
The final tidy data file can be created as followed;

1. Make sure that the libraries dplyr and RCurl is installed. It is required by the tidy script.
2. source the run_analysis.R script.
3. The script will create two output .txt files in the data directory of the working directory. The tidy_average_activity_data.txt file is the end result. 

###Cleaning of the data, Process steps
The run_analysis.R script runs trough the following process steps to get the tidy dataset. For a more detailed description please see the readme dcoument here:  [link to the readme document that describes the code in greater detail](https://github.com/MHaneferd/Getting-and-Cleaning-Data-Course-Project/blob/master/README.md)

1. It loads the neccesarry libries (RCurl, dplyr)
2. It creates a data directory to hold all the raw data and the tidy datafiles.
3. It downloads the file containing the raw data to the data directory
4. It unpacks the data in the data directory, creating a new directory (UCI HAR Dataset) with the raw data.
5. It loads all the datasets into the environment
6. It merges the train and test datasets into three merged datasets.
7. It filter out only the mean and standard deviation columns for the dataset.
8. It lowercase the activity labels to provide more readibillity.
9. It parse trough the activity records for the dataset and replaces the ID's with the corresponding activity label.
10. It creates a variable name for the activity column ('activity')
11. It creates a variable name for the subject column ('subject')
12. It uses the feature dataset to name the variables in the main dataset.
13. The main data set variable names are then cleaned a bit (Removing:'()' and '-', capitalize M and S in Mean and Std, and replacing t and f indicator with time and freq. Where it has two names (BodyBody) is replaced with single Body)
14. It creates a dataframe where it binds togheter the main dataset, the subject and the activity datasets. So all is now connected and tidy.
15. It writes the tidy dataset to ./data/tidy_activity_data.txt
16. It verifies that the dataset has been written by reading in into a verification dataset that is displayed.
17. It calculates the average of each variable for each activity and each subject by using the aggregate function and puts the result in a new aggregated dataframe.
18. It updates the new dataframe with an average indicator in each column.
19. It writes the new tidy dataset to ./data/tidy_average_activity_data.txt
20. It verifies that the dataset has been written by reading in into a verification dataset that is displayed.

##Description of the variables in the tidy_average_activity_data.txt file

The dataset contains 180 observations of  68 variables
1 integer variable containg the subjects.
1 factor variable containing the activity type.
66 numeric float variables containg the average measured data from the samsung unit.

The summary of the data indicates that all subjects (30) are performing all the activities (6). That sums up to 180 observations.

####Variables in the dataset

**subject**
Identifies the unique subject the variables relates to
- class integer
- units 1 to 30

**Activity**
Identifies the activity type the subjects has performed.
- class Factor with 6 levels containing:
  - walking
  - walking_upstairs
  - walking_downstairs
  - sitting
  - standing
  - laying

The variables below are the average of the measurement for each subject and activity. 
The variable has an initial average in the variable name.
All values are floating point numbers, ranging between -1 to 1
class numeric.
The variables is natural grouped.
They are also decribed in the features_info.txt file in the Samsung dataset.

**Average time body acceleration mean along X, Y, Z axis**
- averageTimeBodyAccMeanX
- averageTimeBodyAccMeanY
- averageTimeBodyAccMeanZ

**Average time body acceleration standard deviation along X, Y, Z axis**
- averageTimeBodyAccStdX
- averageTimeBodyAccStdY
- averageTimeBodyAccStdZ

**Average time gravity acceleration mean along X, Y, Z axis**
- averageTimeGravityAccMeanX
- averageTimeGravityAccMeanY
- averageTimeGravityAccMeanZ

**Average time gravity acceleration standard deviation along X, Y, Z axis**
- averageTimeGravityAccStdX
- averageTimeGravityAccStdY
- averageTimeGravityAccStdZ

**Average time body acceleration jerk mean along X, Y, Z axis**
- averageTimeBodyAccJerkMeanX
- averageTimeBodyAccJerkMeanY
- averageTimeBodyAccJerkMeanZ

**Average time body acceleration jerk standard deviation along X, Y, Z axis**
- averageTimeBodyAccJerkStdX
- averageTimeBodyAccJerkStdY
- averageTimeBodyAccJerkStdZ

**Average time body gyroscope mean along X, Y, Z axis**
- averageTimeBodyGyroMeanX
- averageTimeBodyGyroMeanY
- averageTimeBodyGyroMeanZ

**Average time body gyroscope standard deviation along X, Y, Z axis**
- averageTimeBodyGyroStdX
- averageTimeBodyGyroStdY
- averageTimeBodyGyroStdZ

**Average time body gyroscope jerk mean along X, Y, Z axis**
- averageTimeBodyGyroJerkMeanX
- averageTimeBodyGyroJerkMeanY
- averageTimeBodyGyroJerkMeanZ

**Average time body gyroscope jerk standard deviation along X, Y, Z axis**
- averageTimeBodyGyroJerkStdX
- averageTimeBodyGyroJerkStdY
- averageTimeBodyGyroJerkStdZ

**Average time body acceleration magnitude mean**
- averageTimeBodyAccMagMean

**Average time body acceleration magnitude standard deviation**
- averageTimeBodyAccMagStd

**Average time gravity acceleration magnitude mean**
- averageTimeGravityAccMagMean

**Average time gravity acceleration magnitude standard deviation**
- averageTimeGravityAccMagStd

**Average time body acceleration jerk magnitude mean**
- averageTimeBodyAccJerkMagMean

**Average time body acceleration jerk magnitude standard deviation**
- averageTimeBodyAccJerkMagStd

**Average time body gyroscope magnitude mean**
- averageTimeBodyGyroMagMean

**Average time body gyroscope magnitude standard deviation**
- averageTimeBodyGyroMagStd

**Average time body gyroscope jerk magnitude mean**
- averageTimeBodyGyroJerkMagMean

**Average time body gyroscope jerk magnitude standard deviation**
- averageTimeBodyGyroJerkMagStd

**Average frequency body acceleration mean along X, Y, Z axis**
- averageFreqBodyAccMeanX
- averageFreqBodyAccMeanY
- averageFreqBodyAccMeanZ

**Average frequency body acceleration standard deviation along X, Y, Z axis**
- averageFreqBodyAccStdX
- averageFreqBodyAccStdY
- averageFreqBodyAccStdZ

**Average frequency body acceleration jerk mean along X, Y, Z axis**
- averageFreqBodyAccJerkMeanX
- averageFreqBodyAccJerkMeanY
- averageFreqBodyAccJerkMeanZ

**Average frequency body acceleration jerk standard deviation along X, Y, Z axis**
- averageFreqBodyAccJerkStdX
- averageFreqBodyAccJerkStdY
- averageFreqBodyAccJerkStdZ

**Average frequency body gyroscope mean along X, Y, Z axis**
- averageFreqBodyGyroMeanX
- averageFreqBodyGyroMeanY
- averageFreqBodyGyroMeanZ

**Average frequency body gyroscope standard deviation along X, Y, Z axis**
- averageFreqBodyGyroStdX
- averageFreqBodyGyroStdY
- averageFreqBodyGyroStdZ

**Average frequency body acceleration magnitude mean**
- averageFreqBodyAccMagMean

**Average frequency body acceleration magnitude standard deviation**
- averageFreqBodyAccMagStd

**Average frequency body acceleration jerk magnitude mean**
- averageFreqBodyAccJerkMagMean

**Average frequency body acceleration jerk magnitude standard deviation**
- averageFreqBodyAccJerkMagStd

**Average frequency body gyroscope magnitude mean**
- averageFreqBodyGyroMagMean

**Average frequency body gyroscope magnitude standard deviation**
- averageFreqBodyGyroMagStd

**Average frequency body gyroscope jerk magnitude mean**
- averageFreqBodyGyroJerkMagMean

**Average frequency body gyroscope jerk magnitude standard deviation**
- averageFreqBodyGyroJerkMagStd

##Sources
- README.txt from the UCI HAR Dataset
- features_info.txt from the UCI HAR Dataset
- The codebook template mentioned in the Coursera forum: https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41
- The infamous and much celebrated post by David Hood: https://thoughtfulbloke.wordpress.com/2015/09/09/

