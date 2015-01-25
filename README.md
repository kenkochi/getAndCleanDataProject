## Getting and Cleaning Data Project
<b>Ken Kochi</b>
<b>January 25, 2015</b>

This assignment uses an R script to read and process accelorometer and gyroscope data collected from smartphones. 

The data is from the UCI Human Activity Recognition Using Smartphones Dataset. This data is downloaded and unzipped to a folder 'UCI HAR Dataset' on the local computer.

The UCI HAR Dataset folder contains the following files:
* 'README.txt': General description of the dataset
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Table of activity numbers with the corresponding activity name.
* 'train/X_train.txt': Training set. Each row consists of a measurement for each feature.
* 'train/y_train.txt': Training labels. A number (1-6) specifying the activity for each row in X_train.txt.
* 'train/subject_train.txt': Training subject labels. A number specifying the subject for each row in X_train.txt.
* 'test/X_test.txt': Test set. Each row consists of a measurement for each feature.
* 'test/y_test.txt': Test labels. A number (1-6) specifying the activity for each row in X_test.txt.
* 'test/subject_test.txt': Test subject labels. A number specifying the subject for each row in X_test.txt.

## run_analysis.R script

This script assumes the following:
* The dplyr package is available 
* The working directory includes the unzipped text files from the UCI HAR Dataset and preserves the folder structure

The script performs the following:
* Loads the dplyr library
* Reads the activity_labels.txt file into data frame 'activity_labels'
* Reads the features.txt files into data frame 'features' consisting of an index number and the feature name
* features is converted to a character vector of the feature name
* The gsub function is used to remove special characters from the names in feature
* Reads the 'test/X_test.txt' file into data frame 'X_test'
* Reads the 'test/y_test.txt' file into data frame 'y_test'
* Reads the 'test/subject_test.txt' file into data frame 'subject_test'
* Reads the 'train/X_train.txt' file into data frame 'X_train'
* Reads the 'train/y_train.txt' file into data frame 'y_train'
* Reads the 'train/subject_train.txt' file into data frame 'subject_train'
* inner_join functions are used to add a column to y_test and y_train containing the text name of the activity matched to the corresponding to the activity number
* cbind functions are used to combine the X_*, y_* and subject_* data frames and stored in test_df and train_df respectively
* A rbind function combines the test_df and train_df data frames into a new data frame combined_df. The column of activity numbers is then removed from the combined_df data frame.
* The column names of combined_df are replaced with descriptive names
* For the purpose of this assignment, any feature with 'mean' or 'std' in the name will be extracted. This will result in 86 features. 
* A vector of column numbers consisting of the subject, activity name and any feature with 'mean' or 'std' (case insensitive) is created using grep. This vector is used to extract the desired columns and store the result back into combined_df.
* The group_by function is used to group the combined_df data frame by subject and activity
* The summarise_each function is used to calculate the mean of each feature for every subject/activity combination. This is stored in data frame tidy_data.
* As there are a total of 30 subjects who each performed 6 activities there are 180 rows in tidy_data. There are 88 columns in tidy_data corresponding to subject, activity and the 86 features.
* The column names of the 86 features in tidy_data are appended with '.Avg' to indicate that these values are the averages of the original measurments
* The write.table function is used to write the contents of tidy_data to a text file


