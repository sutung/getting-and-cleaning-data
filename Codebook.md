# Codebook

## Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Source

The original data was obtained from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here is the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

Load the dataset into the project folder name it to 'UCI HAR Dataset'

## Transformation Work

The initial dataset was processed using run_analysis.R which will write to the output file
final_data.txt

The following are the transformations from the original dataset:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Below is detailed description of the project steps:

### 1 Load and merge into one data set.
- Load the library dplyr
- Load the raw data into dataframes:
i. Read the feature lists into column no and functions.
ii Read the x_test test set using the features as column name
iii. Read the x_train training set using features as column name
iv. Read the activities set (six activities) using label and activity as column name.
v. Read the subject_test which is the subject (volunteers) participated in the test set
Vi. Read the subject_train which is the subject(volunteers) in the train set
vii Read the y_test, which is the test labels for the six activities.
viii. Read the y_train, which is the train labels for the six activies
ix. Combining x_train and x_test into Xbind
x. Combining y_train and y_test into Ybind
xi. Combining subject_train and subject_test into subjects
xii. Merge all data into merged_df (10299 rows, 563 columns)

* Assigned the variable names to the columns
* Read the "Activities" data from the Test and Training datasets and combined 
     them
* Read the "Subject" data from the Test and Training datasets and combined them
* Added the "Activities" and "Subject" column to the main dataset and named 
	the columns with descriptive names (“Activities” and “Subject” respectively)

### 2 Extracts only the measurements on the mean and standard deviation for each measurement
- Select the variables that contain measures of mean and standard deviation for each measurement into tidydf.
    
### 3 convert to descriptive activity names to name the activities 
- convert the activities in the data set to the activity labels 

### 4 Appropriately labels the data set with descriptive variable names. 

- Assign descriptive variables names in the tidydf data set:
i. Change column 2 to Activity
ii. Change the column starts with t to Time
iii. Change column name starts with f to Frequency
iv. Change the the Acc in column names to Accelerometer
v. Change the Gyro in column names to Gyroscope
vi. Change the BodyBody in column names to Body
vii. Change the Mag in column names to Magnitude
viii. Change the tBody in column names to TimeBody
ix. Change the '-mean()' in column names to 'Mean'
x. Change the '-std()' in column names to 'STD' 
xi. Change the '-freq()' in column names to 'Frequency'
xii. Change the 'angle' in column names to 'Angle'
xiii. Change the '.mean' in column names to 'Mean'
xiv. Change the '.std' in column names to 'STD' 
xv. Change the '...' in toe column names to '-'
xvi. Remove the remaing '.' in the column names

###  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- Group the data by Subject and Activity
- created a final_data set with the average of each variable for each activity and each subject.
- Write output file (final_data.txt) that has 180 rows and 88 columns
