
# Codebook: Getting and Cleaning Data Project
This Codebook relates to tidydataset.txt that has been created by the R script run_analysis.R after processing files from the dataset  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   

## Read data 

The above dataset for the Getting and Cleaning Data Project is downloaded from the UCI website and unzipped into the UCI HAR Dataset folder. 

The key files to read from include: 
* activity_labels.txt (6X2) which describes the six activities (walking, sitting etc) and assigns an ID to each activity  
* features.txt (561X2) which describes each feature recorded from the accelerometer and gyroscope signal, measuring data such as mean, standard deviation, etc with each feature having a unique ID 
* subject_train.txt and subject_test.txt record subject IDs across both test and training sets 
* Label files y_train.txt and y_test.txt lists the activity code 
* Data files X_train.txt and X_test.txt have the records of each feature for each observation  

## Process and merge data 
After reading the data, the training and test data are merged across subject, activity and observations. 

The separate tables are then merged into a single table with subject, activity and measurements. 

## Create the final table and dataset 
Subset the mean and standard deviation measurements from the merged table and assign descriptive names to create the final tidy dataset. 

## Dataset details 
The key variables in tidydataset.txt are: 
Identifiers: 
subject, activity 
Measurements:  
TimeBodyAccelerometer.mean 
TimeBodyAccelerometer.std 
etc 

## 




