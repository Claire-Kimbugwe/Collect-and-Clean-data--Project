#You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.

#Load required libraries
library(reshape2)
library(plyr)
library(dplyr)
library(data.table)
#Download dataset from the web
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(getwd(), "dataFiles.zip"))
#Unzip the file
unzip(zipfile = "dataFiles.zip")

#read in the features
features <- fread("UCI HAR Dataset/features.txt", col.names = c("Index","feature_name") )

#read in the activity labels
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("class_label","activity_name") )
#Look at the a few fields of both tables  
tail(features, 10)
head(activity_labels)
#Give the columns, human readable names
setNames(features, c("Index","feature_name"))
setNames(activity_labels,c("class_label","activity_name"))

# We are required to Extract only the measurements on the mean 
# and standard deviation for each measurement.
# the code below helps with that
required_features <- grep("(mean|std)\\(\\)", features[,feature_name])
#have a look at the required feature object to make sure.
required_features
#measurements
measurements <- features[required_features, feature_name]
length(measurements) #finds the number of characters
measurements # look at measurements
#LOAD TRAIN

#Extracts only the measurements on the mean and standard deviation for each measurement. 
train <- fread(file.path(getwd(), "UCI HAR Dataset/train/X_train.txt"))[,required_features, with = FALSE]
data.table::setnames(train, colnames(train), measurements) #names columns

train_Activities <- fread(file.path(getwd(), "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
train_Subjects <- fread(file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("Subject_Number"))

#Join all objects together using the cbind
train <- cbind(train_Subjects, train_Activities, train)
#look at a few obs of Train
head(train, 2)
#LOAD TEST
test <- fread(file.path(getwd(), "UCI HAR Dataset/test/X_test.txt"))[, required_features, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
test_activities <- fread(file.path(getwd(), "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
test_Subjects <- fread(file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("Subject_Number"))
test <- cbind(test_Subjects, test_activities, test)
#look at the test data
head(test, 2)
#Joiin the test and train data to produce one dataset
data <- rbind(train,test)
names(data)
# remove the symbol () from the names
gsub('[()]', "", names(data))
#look at the new names
names(data)
#write a csv file
data.table::fwrite(x= data, file = "Data.csv", quote = F)
#From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
#For this i will make Activity and subject factor variables 
data[["Activity"]] <- factor(data[, Activity]
                                 , levels = activity_labels[["class_label"]]
                                 , labels = activity_labels[["activity_name"]])
data[["Subject_Number"]] <- as.factor(data[, Subject_Number])

?melt
data <- reshape2::melt(data = data, id = c("Subject_Number", "Activity"))
?dcast
#cast the melted data into a data frame
data <- reshape2::dcast(data = data, Subject_Number + Activity ~ variable, fun.aggregate = mean)
#write the Tidy csv Dataset
data.table::fwrite(x= data,file = "Tidydata.csv", quote = F)
#Write a text file
write.table(x= data , file = "tidydata.txt", row.names = F)
