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

###Collection of the raw data
Description of how the data was collected.

###Notes on the original (raw) data 
Some additional notes (if avaialble, otherwise you can leave this section out).

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
