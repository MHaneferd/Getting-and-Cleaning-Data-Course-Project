---
title: "Codebook for the Getting and Cleaning Data Course Project at Coursera"
author: "Martin Haneferd"
date: "07. aug. 2016"
output:
  html_document:
    keep_md: yes
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

###The logic of the files is as followed:

1. The X_ files has the accleometer, gyro, etc. variables. ( No header, only a lot of values)
2. The y_ files has the activity types (connected 1:1) for each rows in the X_ files. The activity type is a value identifier (1 - 6). The values for the identifier is in the activity_labels file.
3. The features.txt has the column names for the X_ files. It has the same column lenght, and must be placed as column variables for the values in the X_ files.
4. The subject files identifies the subject who performed the activity. It is also connected (1:1) to the X_ and y_ file rows.
5. The X_ , y_ and subject files can be *columnized* togheter (They fit.)
6. The activity_labels file is connected to the identifiers in the y_files, and can replace the identifier in y_files with text for the activity ( standing, walking_, etc.) 

###Collection of the raw data
The collection of the .zip file in the project is downloaded by my R-script, run_analysis.R. It is downlodaded and unpacked in a data directory.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Notes on the original (raw) data 
In this project I am not using the Inertial Signals provided in the dataset.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file (1. download the data, ...)/

###Cleaning of the data
Short, high-level description of what the cleaning script does. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the tiny_data.txt file
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)
