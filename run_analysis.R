##Getting and Cleaning Data Project
##Ken Kochi
##January, 25, 2014

##This script assumes the following:
##The dplyr package is available 
##The working directory includes the unzipped text files from
##the UCI HAR Dataset and preserves the folder structure

##Load dplyr library
library(dplyr)

##Read activity_labels.txt
activity_labels <- read.table("activity_labels.txt")

##Read the features.txt file and stores the text names into a character vector
##gsub is used to remove special characters from the text names
features <- read.table("features.txt")
features <- as.character(features$V2)
features <- gsub("\\(|\\)|\\,|-|_","",features)

##Read the X_test.txt, y_test.txt and subject_test.txt files
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

##Read teh X_train.txt, y_train.txt and subject_test.txt files
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

##Adds a column containing the activity name corresponding to the activity 
##number using the inner_join function
y_test <- inner_join(y_test,activity_labels,by="V1")
y_train <- inner_join(y_train,activity_labels,by="V1")

##Column binds the subject_test, y_test and X_test data frames
test_df <- cbind(subject_test,y_test,X_test)

##Column binds the subject_train, y_train and X_train data frames
train_df <- cbind(subject_train,y_train,X_train)

##Creates one combined data frame using rbind
combined_df <- rbind(test_df,train_df)

##Remove the second column which consists of the numeric activity values 
##as it is no longer needed
combined_df[,2] <- NULL

##create a character vector of column names for the combined data frame
combined_df_colnames <- c("subject","activity",features)

##Rename the column names of the combined data frame using the characer 
##vector created above
colnames(combined_df) <- combined_df_colnames

##Creates a numeric vector corresponding to columns of subject, activity 
##and any column containing 'mean' or 'std' in its name
feature_vector <- c(1,2,grep("mean|std",combined_df_colnames,ignore.case=TRUE))

##Uses the above vector to specify which columns to keep of the combined data frame
combined_df <- combined_df[,feature_vector]

##Group the data frame by subject and activity
combined_df <- group_by(combined_df,subject,activity)

##Use summarise_each to calculate the average of each feature
##by subject and activity. Store the values into tidy_data
tidy_data <- summarise_each(combined_df,funs(mean))

##Append '.Avg' to the feature column names in tidy_data for clarity
colnames(tidy_data)[3:88] <- paste(colnames(tidy_data)[3:88],".Avg",sep="")

##Write tidy_data to a text file
write.table(tidy_data,file="tidy_data.txt",row.names=FALSE)
