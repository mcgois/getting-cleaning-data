Getting and Cleaning Data Course Project
========================================

This repository is for the final project of Cousera's Getting and Cleaning Data Course 
(Course 3 of Data Science Specialization).

Repository Contents:
--------------------
    
1. data (directory) - directory where all given data is.
2. README.md - this readme file.
3. run_analisys.R - scripts to manipulate data and generate tidy data.
4. tidy.txt - tidy data, final output of the assignment.
5. codebook.md - codebook o the tidy data.

Instructions to run:
--------------------

* On R environment, just execute source("run_analisys.R"). 
* The script will download and unzip the data (if necessary).
* The script will generate two dataframes: **all.data** and **tidy**).
* Dataframe **all.data** contains the merged data (with mean and std measurements) of train and test.
* Dataframe **tidy** contains the average of each variable for each activity and each subject.
* Dataframe **tidy** will be writen to a file called "tidy.txt".

Overview of run_analisys.R
--------------------------

### Script part (end of file)

1. Calls download.file.and.unzip
2. Creates all.data by calling create.all.data
3. Creates tidy by calling create.tidy

### Function *download.file.and.unzip*

Function that extracts the given zip file (assignment input). If file does not exists, it will download it.

### Function *read.activities.labels*

Function that returns the dataframe of code-activity_labels.

### Function *read.features*

Function that returns a vector of all features in dataset, including the ones we don't want.

### Function *read.data*

Function that reads train and test data (measurements, activities, subjects) and returns the data frame.
 
* To return train data frame, call read.data with dataType argument equal to "train".
* To return test data frame, call read.data with dataType argument equal to "test".

### Function *create.all.data*

Function that orchestrates previous functions and returns a merged data frame of both train and test data.

### Function *create.tidy*

Function that transforms the "all.data" dataframe into another dataframe with 
the average of each variable for each activity and each subject.