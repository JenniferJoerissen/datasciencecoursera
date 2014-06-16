#-------------------------------------------------------------------------------
#  PART 1: Merges the training and the test sets to create one data set. 
#-------------------------------------------------------------------------------

#Download and unzip folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data.zip", method = "curl")
date.Downloaded <- date()
unzip("./data.zip")
#Enter folder
setwd("./UCI HAR Dataset/")

#Read-in everything belonging to the training dataset and bind columns
trainingDataset <- read.table("train/X_train.txt")
trainingLabels <- read.table("train/y_train.txt")
trainingSubject <- read.table("train/subject_train.txt")
trainingData <- cbind(trainingLabels, trainingSubject, trainingDataset)

#Read-in everything belonging to the test dataset and bind rolumns
testDataset <- read.table("test/X_test.txt")
testLables <- read.table("test/y_test.txt")
testingSubject <- read.table("test/subject_test.txt")
testData <- cbind(testLables, testingSubject, testDataset)

#Read in feature-file and coerce to vector
features <- read.table("features.txt")
features <- as.vector(features$V2)

#Merge test- and training data and add column-names
mergedData <- rbind(testData,trainingData)
colnames(mergedData) <- c("Activity", "Subject", features)


#-------------------------------------------------------------------------------
#  PART 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#-------------------------------------------------------------------------------

meanStd<-mergedData[,c(1,2, grep("mean\\(\\)|std\\(\\)", names(mergedData)))]

#-------------------------------------------------------------------------------
#  PART 3: Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------------------------------------

#Replace the values 1 to 6 with the activity_labels
activityNames <- read.table("activity_labels.txt")
meanStdAct <- meanStd
meanStdAct$Activity <- activityNames$V2[match(meanStd$Activity, activityNames$V1)]

#-------------------------------------------------------------------------------
#  PART 4: Appropriately labels the data set with descriptive variable names. 
#-------------------------------------------------------------------------------

names(meanStdAct) <- sub("\\(\\)","",names(meanStdAct),)
names(meanStdAct) <- sub("^t","time",names(meanStdAct),)
names(meanStdAct) <- sub("^f","frequ",names(meanStdAct),)
names(meanStdAct) <- sub("Acc","Accel", names(meanStdAct))
names(meanStdAct) <- sub("BodyBody","Body", names(meanStdAct),)
names(meanStdAct) <- make.names(names(meanStdAct))
names(meanStdAct) <- sub("mean","Mean", names(meanStdAct),)
names(meanStdAct) <- sub("std","Stdev", names(meanStdAct),)

write.table(meanStdAct,"tidyDataset1.txt", sep = "\t", row.names = FALSE)
#-------------------------------------------------------------------------------
#  PART 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------

library("reshape")
tidyDataset2 <- melt(meanStdAct, id=c("Activity","Subject"), measure.vars=names(meanStdAct)[3:68])

activity.subject <- data.frame(paste(tolower(tidyDataset2$Activity),tidyDataset2$Subject, sep=""))
names(activity.subject) <- "activity.subject"
tidyDataset2 <- cbind(activity.subject,tidyDataset2[3:4])

library("reshape2")
tidyDataset2 <- dcast(tidyDataset2, activity.subject ~ variable,mean)

write.table(tidyDataset2,"tidyDataset2.txt", sep = "\t", row.names = FALSE)
