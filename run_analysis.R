# run_analysis.R

library(dplyr)

#1. Merges the training and the test sets to create one data set.

#features.txt: List of all features.
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("no","functions"))

#'test/X_test.txt': Test set.
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

# 'train/X_train.txt': Training set.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

# 'activity_labels.txt': Links the class labels with their activity name.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activity"))

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
table(subject_test)

# subjects are the 30 volunteers for the studies
#'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

# test/y_test.txt': Test labels. For the six activities
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "label")

# 'train/y_train.txt': Training labels. For the six activities
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "label")

#combining all the data
Xbind <- rbind(x_train, x_test)
Ybind <- rbind(y_train, y_test)
subjects <- rbind(subject_train, subject_test)
merged_df <- cbind(subjects, Ybind, Xbind)
dim(merged_df)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

tidydf <- merged_df %>% 
select(Subject, label, contains("mean"), contains("std"))

#str(tidydf)

# 3. Uses descriptive activity names to name the activities in the data set
tidydf$label <- activities[tidydf$label, 2]


# 4. Appropriately labels the data set with descriptive variable names. 
# Use gsub() to replace an old string with the new string

#change label to activity
names(tidydf)[2] = "Activity"
#Change column name starts with t to  Time
names(tidydf)<-gsub("^t", "Time", names(tidydf))
#change column name starts with f to Frequency
names(tidydf)<-gsub("^f", "Frequency", names(tidydf))
names(tidydf)<-gsub("Acc", "Accelerometer", names(tidydf))
names(tidydf)<-gsub("Gyro", "Gyroscope", names(tidydf))
names(tidydf)<-gsub("BodyBody", "Body", names(tidydf))
names(tidydf)<-gsub("Mag", "Magnitude", names(tidydf))
names(tidydf)<-gsub("tBody", "TimeBody", names(tidydf))
names(tidydf)<-gsub("-mean()", "Mean", names(tidydf), ignore.case = TRUE)
names(tidydf)<-gsub("-std()", "STD", names(tidydf), ignore.case = TRUE)
names(tidydf)<-gsub("-freq()", "Frequency", names(tidydf), ignore.case = TRUE)
names(tidydf)<-gsub("angle", "Angle", names(tidydf))
names(tidydf)<-gsub("\\.mean", "Mean", names(tidydf))
names(tidydf)<-gsub("\\.std", "STD", names(tidydf))
# Remove . in the column names
names(tidydf)<-gsub("\\.\\.\\.", "-", names(tidydf))
names(tidydf)<-gsub("\\.", "", names(tidydf))


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final_data <- tidydf%>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

dim(final_data)

write.table(final_data, "final_data.txt", row.name=FALSE)
