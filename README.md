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

##References
Wickham, Hadley. Tidy Data. The Journal of Statistical Software



Of appropriate formats for this assignment and all the formats that Coursera will accept, a good intersection of the two is a txt file made with write.table.

Protip, if using write.table, set the option of not writing the line numbers as that can look a bit ugly when reading it back in

wide1 <- tidied <- dcast(narrow, cyl + gear ~ vs, max)

vs -> turned to columns

notverywide <- aggregate(mpg ~ gear + vs + cyl, data = narrow, min)
mpg is what's 'minned'

In the submission box, as well as the link, put some accompanying text on another line something like "tidy data as per the ReadMe that can be read into R with read.table"
In the readMe in explaining what the script does put "and then generates a tidy data text file that meets the principles of ...etc"
the truly cunning may want to put in a citation to this discussion and/or Hadley's paper
The codebook still has the specific description of the tidy data file contents (and you mention that it exists and it's role in the ReadMe)