# in fulfillment of the class assignment for Getting and Cleaning Data
# 6/16/2014 by SDC
library(reshape2)
library(data.table)
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.

# Extracts only the measurements on the mean and standard deviation for each measurement. 

# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# the variables

# to do
# change paths: class requirements: runnable if the FOLDER is in your working dir.

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")

# the subject
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")

#the activity
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")

# features (for variable columns)
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
# clean up 'bad characters' in feature names
features$V2 <- gsub("[\\(\\)]","", features$V2)
features$V2 <- gsub("-","_", features$V2)
# comma means one number to the next one
features$V2 <- gsub("(\\d),", "\\1to", features$V2)
features$V2 <- gsub(",","_", features$V2)
features <- c(features$V2,'subject','activity') #,'data_type')

# change y vals to activity names
activity_labels <- read.table("~/Dropbox/R_Class/UCI HAR Dataset/activity_labels.txt", quote="\"")
merged_test_labels <- activity_labels[y_test$V1,]$V2
merged_train_labels <- activity_labels[y_train$V1,]$V2

#big merged set
bigtrain <- cbind(X_train, subject = subject_train, activity = merged_train_labels )#, data_type = train_type)
bigtest <- cbind(X_test, subject = subject_test, activity = merged_test_labels) #, data_type = test_type)
superframe <- rbind(bigtest,bigtrain)

names(superframe) <- features

#reduce to only mean and stdev types
redfeat <- c(features[grep('[mM]ean|std',features)],c('subject','activity')) #,'data_type'))

narrowframe <- superframe[,redfeat]
# 10299

melty <- melt(narrowframe,id=c("activity","subject"))
# 885714
nvw <- aggregate(value~subject+activity+variable,data=melty,mean)
#3440 rows

tidyWidy <- dcast(nvw,subject+activity ~ variable)

# now variables are columns as per tidy data principles.
nz <- names(tidyWidy)
nzmod <- gsub("tBody",'TimeBody', nz)
nzmod <- gsub("fBody",'FrequencyBody', nzmod)
nzmod <- gsub("tGravity",'TimeGravity', nzmod)
nzmod <- gsub("Acc",'Accelerometer', nzmod)
nzmod <- gsub("Gyro",'Gyroscope', nzmod)
nzmod <- gsub("Mag",'Magnitude', nzmod)
nzmod <- c(nzmod[1:2],paste('MeanOf', nzmod[3:length(nzmod)], sep =''))
names(tidyWidy) <- nzmod

# angle items, were not truly means or stds
noAngle <- grep('angle',nzmod, invert = TRUE)
twna <- tidyWidy[,noAngle]

# and we out
write.table(twna, "tidyfinal.txt", sep="\t")
