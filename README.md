#Class Project For Getting and Cleaning Data Coursera Course
##by Stephen Charlesworth

The script 'run_analysis.R' imports the datasets from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) which was conveniently packaged in a zip file obtainable [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The script transforms the data to fulfill the requirements of this project:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##Notes on the script and process

The dataset was limited to 'mean' and 'standard deviation' variables using some pattern matching. Specifically we sought matches on mean, Mean, or std. Variables with 'angle' in the name were dropped because they were angles OF means rather than means.

Variable names were cleaned up to remove parentheses and '-' characters. Also names were changed to be more descriptive, for example: 'f' and 't' at the beginning of feature names were expanded to 'Frequency' and 'Time', similarly Gyro became Gyroscope, Acc became Accelerometer, and so on. Going this verbose may have been going a bit overboard, but at the very least adding clarity about the disctinction between time domain and frequency domain helped.

##The Tidy Dataset

The script 'run_analysis.R ultimately drops a text file named 'tidyfinal.txt' in the working directory. According to (Wickham), Tidy Data has these properties:

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table

When developing the script, at first a 'long' dataset was generated. In this set, one of the columns was a variable. The seemed to defy the 'each variable forms a column' property. Laying out the data so that each row specified an activity, a subject, and values for every variable made sense as a way to present the data in a 'tidy' manner. 

To further support this, say you were trying to build a predictive model from this data. Functions like lm rely on variables being in columns as opposed to rows, so a dataset like this is more useful than the 'long' format.

##The Code Book
See the file 'CodeBook.md' for detailed information about the variables and their values.

##References
Wickham, Hadley. Tidy Data. The Journal of Statistical Software


