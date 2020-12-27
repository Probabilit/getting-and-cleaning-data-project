
library(dplyr)
# Confirm that filename doesn't exist and download file 
filename <- "Coursera_Data_Final.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = filename)
}
# Unzip file after checking if folder exists
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}
# Read all the tables and assign column names
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("n", "features"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                       col.names = c("activity_label", "activity"))
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                           col.names = "subject")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt", 
                                        col.names = "activity_label")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt", 
                         col.names = "activity_label")
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", 
                         col.names = features$features)
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", 
                        col.names = features$features)

#1A. Merge test and training sets 
Subject <- rbind(train_subject, test_subject)
Label <- rbind(train_label, test_label)
Data <- rbind(train_data, test_data)

#1B. Merge Subject, Label and Data tables 
Merged_data <- cbind(Subject, Label, Data)

#2. Extract measurements only for mean and standard deviation 
#for each measurement
Mean_SD <- select(Merged_data, subject, activity_label, contains("mean"), contains ("std"))

#3. Assign descriptive activity names instead of labels 
Mean_SD$activity_label <- activities[Mean_SD$activity_label, 2]

#4. Make variables descriptive such as time for t and Accelerometer for Acc
names(Mean_SD)<-sub("activity_label", "activity", names(Mean_SD))
names(Mean_SD)<-gsub("^t", "Time", names(Mean_SD))
names(Mean_SD)<-gsub("^f", "Frequency", names(Mean_SD))
names(Mean_SD)<-gsub("Acc", "Accelerometer", names(Mean_SD))
names(Mean_SD)<-gsub("Gyro", "Gyroscope", names(Mean_SD))
names(Mean_SD)<-gsub("BodyBody", "Body", names(Mean_SD))
names(Mean_SD)<-gsub("Mag", "Magnitude", names(Mean_SD))
names(Mean_SD)<-gsub("tBody", "TimeBody", names(Mean_SD))
names(Mean_SD)<-gsub("-mean()", "Mean", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("-std()", "STD", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("-freq()", "Frequency", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("angle", "Angle", names(Mean_SD))
names(Mean_SD)<-gsub("gravity", "Gravity", names(Mean_SD))  
#5. Making the tidy dataset and creating a text file for the project
tidyDataSet <- Mean_SD %>% group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(tidyDataSet, "tidydataset.txt", row.names = FALSE)





