
## Code Book Overview
This Code book contains information about the original data and modifications done to the data. It describes all the variables and summaries calculated, along with units, and any other relevant information

## Original data
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset have been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset included the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

# Transformations
## 1. creating a test and Train data table
I used the six text files 'features.txt',activity_labels.txt','train/X_train.txt', 'train/y_train.txt', 'test/X_test.txt' and 'test/y_test.txt': Test labels. to cread two data frames, test and train

## 2. merging the two tables
I used the rbind function in R to put the two tables together into one big table

## 3. Renaming Columns and changing data types
I used the SetNames function to give the variables, human readable names to make sure that any reader can understand what the data is about, I also used dthe gsub function to remove the symbols from the measuerements that were not necesary.
I also changedd the activity and subject_Number variables into factor ariables so that i could better use them to group the data

## 4. Grouping the data
I used the melt funtion to melt the data basing on the ids of activity and Subject_number and then used the dcast function to cast the melted data into a data frame

## 5. Tidy Data
the data was transformed into a tidy csv as seen [here](https://github.com/Claire-Kimbugwe/Collect-and-Clean-data--Project/blob/master/Tidydata.csv) and text file as seen [here](https://github.com/Claire-Kimbugwe/Collect-and-Clean-data--Project/blob/master/tidydata.txt)
