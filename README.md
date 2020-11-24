# Getting and cleaning data course project

This repository contains the following files:

  1.) README.md - the readme file.

  2.) CodeBook.md - the code book.

  3.) run_analysis.R - the R script.

  4.) tidy_data.txt - tidy data set.

# Creating tidy_data.txt 

The R script run_analysis.R is used to create the data set. The following are the steps involved in the R script.

  1.) Load data.table package. 
  
  2.) Read raw data (train / test / features / activity).
  
  3.) Modify the features data to correct for any issues before using them as column names.
  
  4.) Change the names of variables in train and test data.
  
  5.) Combine train and test data.
  
  6.) Keep only subject, activity and the variables which are related to the measurements on the mean and standard deviation for each measurement.
  
  7.) Create tidy data with the average of each variable for each activity and each subject.

  8.) Write the data set to the tidy_data.txt file.
