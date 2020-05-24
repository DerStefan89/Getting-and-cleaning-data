## Original Data

# Original Data was transformed by

   1. Merging the training and the test sets to create one data set.
   2. Extracting only the measurements on the mean and standard deviation for each measurement.
   3. Using descriptive activity names to name the activities in the data set
   4. Appropriately labeling the data set with descriptive activity names.
   5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

# Informations about the variables

  x.train, x.test, sub.train, x.test, y.test, sub.test, features, activity : Contains Data from the downloaded files
    
  x.total, y.total, sub.total : downloaded testing and training data joined together
  
  merge.data : merged the x.total, y.total and sub.total in one data frame
  
  sfn : selected features with mean and std
  
  select.names : character vector of sfn with the selected names "subject", "activity"
  
 final : final data frame wiith selected values (mean /std) of the variable merge.data
