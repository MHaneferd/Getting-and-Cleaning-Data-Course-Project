#Getting and Cleaning Data Course Project
This repository is my submission to the Coursera Peer Graded Assignment: Getting and Cleaning Data Course Project.

The submission consist of;
- This repo in Github
- A Readme file (this file)
- A CodeBook (CodeBook.md)
- A R-script (run_analysis.R) file
- A tidy dataset uploaded directly to Coursera. ( This file is not in this Repo, but can be created with the run_analysis.R script)

## Files in the deliverables

###README.md
This README.me file is decribing the different deliverables and how they are connected.
It also outlines some of the details in the files in the repo.

###[CodeBook.md](https://github.com/MHaneferd/Getting-and-Cleaning-Data-Course-Project/blob/master/CodeBook.md)
The CodeBook file consists of an overview description of the project goals, and the outcome of the project.
It includes some study design and data processing of the raw data, how it is collected and how the different raw data files are connected to each other.
There is a section of a guide for how to create the Tidy Dataset (Which are uploaded to Coursera), and a process description on how the raw data files are cleaned. And a description of the variables in the output file (The tidy_average_activity_data.txt file.)
At the end of the CodeBook, the major sources for where the information of how I got to the end result are listed.

###[run_analysis.R](https://github.com/MHaneferd/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R)
The run_analysis script is the script that downloads the raw dataset, and produces a tidy file for further analysis. The tidy file is the one that is uploaded to Coursera as decribed in the assignment.
The script is written with many comments to ease the understanding of the operations.
The script is written in a way where it cleans up all the memory usage, to reduce the memory usage when it runs trough.

The script was made in RStudio Version 0.99.903, and Windows-8 Operating system.
It can be executed by the following command in R- (If you have the script in another working directory, you must either change the working directory to the script file, or put in the directory path in the source command:
>source("run_analysis.R")

It will place the tidy dataset in the working directory.
It is the tidy_average_activity_data.txt that is the deliverable to Coursera.

It has been tested in both RStudio and the R-console Version: x64 3.3.1
**Note:** I have seen in the discussion forums some different ways of downloading files depending on which operating syste R- is running on. I needed to use RCurl for my download to happend. If you try to use this script on other configuration/operating system than Windows, you might have to change some of the download code so it fit's your configuration. The download code is in line 62 of the script:
>download.file(fileUrl, destfile=zipfile, method="libcurl")

The script follow a linear order by using the suggested process steps in the project instructions from Coursera.
It first starts with loading the libraries needed. Then it downloads, and unzip the data files into the working directory. It loads all the training and test sets, and merges it together with **rbind** command.
After the merge, the new main merged dataset has 10299 observations and 561 measurements.
It cleans up the memory of the datasets no longer to be used with the **rm** command. This for making sure I have enough memory.

Then it extracts only the measurements on the mean and standard deviation for each measurement. It does so by selecting the variables in the feature file with grep command **grep('-(mean|std)\\(', features[, 2])** getting a TRUE/FALSE result set back where the variables either contain mean or std. Then it uses this output for selecting only matching columns. Reducing the measurements dataset from 561 measurements to 66.

Next step it does is create descriptive activity names to name the activities in the data set. It first lower case the activity labels for better readibillity with a **tolower** command. Then It fill out the full scale (10299) observation with the corresponding activity label based on the activity index from the raw files. It uses standard subsetting [] to do all those operations.

The labels in the data set needs descriptive variable names, so it name both the subject and activity dataframes with activity and subject. For the main dataset with the measurements it use the features table which has been narrowed down to only the mean and std values. It also uses the same (TRUE/FALSE) variable used for filter out the features dataset to filter out the measurement dataset so it connects:
>names(mergeRecords) <- features[mean_std_variables, 2]

The script then reformat the variable names ( removing (), -, changing t/f indicator to time and freq, BodyBody to Body, and make the first letter capital for Mean and Std) using the **gsub** command.
At the end, it connect the three datasets with **cbind** so it gets a full tidy dataset:
>tidyActivityData <- cbind(mergeSubject, mergeLabels, mergeRecords)

The dimensions are now 10299 observations and 68 variables. (2 dimensions and 66 measurements)
The script write the tidy dataset to disk with the **write.table** command. (This section can be left out, since it is not a part of the deliverables, but I felt it was a good check.) It also read it back, and runs a **str** and **View** command to check that it is valid.

From the data set in step 4, the script create a second tidy data set with the average of each variable for each activity and each subject.
To achive this, it uses the aggregate function on the 66 measurements, and group it by a list containing subject and activity variable. >aggregate(tidyActivityData[, 3:68], list(subject = tidyActivityData$subject,activity = tidyActivityData$activity), mean)

The dimension of this dataset is 180 observations and 68 variables.
It sorts the tidy dataset by the **arrange** command with subject as a column:
>arrange(newTidyDataset,subject)

The variable names are also updated with 'average' in front of Time and Freq to indicate that it consists of the average (mean) values.
The new tidy dataset is then saved to disk with the **write.table** command:
>write.table(newTidyDataset, "./data/tidy_average_activity_data.txt", row.names = FALSE)

Then the script tests the writing of the dataset, by loading it into R, and view it.

###tidy_average_activity_data.txt
This is the output file of the run_analysis.R script that is uploaded to Coursera as a part of the project assignment. It is not added in this Repo. You have to source the run_analysis.R script to get hold of it if needed.
