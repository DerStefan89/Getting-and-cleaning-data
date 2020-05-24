library(plyr)
library(dplyr)

# read train data 
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y.train <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
sub.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# read test data
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y.test <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
sub.test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# read data description
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

# Create a dataset out of train and test data
x.total <- rbind(x.train, x.test)
y.total <- rbind(y.train, y.test)
sub.total <- rbind(sub.train, sub.test)

# add names to variables
names(sub.total)<-c("subject")
names(y.total)<- c("activity")
names(x.total) <- features$V2

# 1. Merge training and the test sets to create one data set.
merge.data <- cbind(sub.total,x.total,y.total)

#2 Extract measurements on the mean and standard deviation
sfn <-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

## subset to selected names
select.names <-c(as.character(sfn), "subject", "activity" )
merge.data <- subset(merge.data, select=select.names)

# read in activity text
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Factorize Variale activity in the data frame Data using descriptive activity names
merge.data$activity <- factor(merge.data$activity,labels=activity[,2])


# ALppropriately labels the data set with descriptive variable names
names(merge.data)<-gsub("^t", "time", names(merge.data))
names(merge.data)<-gsub("^f", "frequency", names(merge.data))
names(merge.data)<-gsub("Acc", "Accelerometer", names(merge.data))
names(merge.data)<-gsub("Gyro", "Gyroscope", names(merge.data))
names(merge.data)<-gsub("Mag", "Magnitude", names(merge.data))
names(merge.data)<-gsub("BodyBody", "Body", names(merge.data))

# create final data frame
final<-aggregate(. ~subject + activity, merge.data, mean)
final<-final[order(final$subject,final$activity),]
write.table(final, file = "tidydata.txt",row.name=FALSE,quote = FALSE, sep = '\t')
