README
========================================================
### 1. Download the dataset direcly from the internet and save in given folder.
```{r}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data.zip", method = "curl")
date.Downloaded <- date()
```
### 2. Unzip the folder and enter it.
```{r}
unzip("./data.zip")
setwd("./UCI HAR Dataset/")
```
### 3. Read-in everything belonging to the training dataset and bind columns
```{r}
trainingDataset <- read.table("train/X_train.txt")
trainingLabels <- read.table("train/y_train.txt")
trainingSubject <- read.table("train/subject_train.txt")
trainingData <- cbind(trainingLabels, trainingSubject, trainingDataset)
```
### 4. Read-in everything belonging to the test dataset and bind rolumns
```{r}
testDataset <- read.table("test/X_test.txt")
testLables <- read.table("test/y_test.txt")
testingSubject <- read.table("test/subject_test.txt")
testData <- cbind(testLables, testingSubject, testDataset)
```
### 5. Read in feature-file and coerce the column containig the features to a vector
```{r}
features <- read.table("features.txt")
features <- as.vector(features$V2)
```
### 6. Merge test- and training data and add column-names
```{r}
mergedData <- rbind(testData,trainingData)
colnames(mergedData) <- c("Activity", "Subject", features)
```
### 7. Pick out the columns with headers containing 'mean()' or 'std()', forming a new dataframe.
```{r}
meanStd<-mergedData[,c(1,2, grep("mean\\(\\)|std\\(\\)", names(mergedData)))]
```
### 8. Replace the placeholders 1 to 6 with the activity_labels
```{r}
activityNames <- read.table("activity_labels.txt")
meanStdAct <- meanStd
meanStdAct$Activity <- activityNames$V2[match(meanStd$Activity, activityNames$V1)]
```
### 9. Adapt column headers to R standards. Trying to maintain readability, dots were introduced and new words start with a capital letter, even though this was not recommended. A few feature names contained 'BodyBody' which was assumed to be an error rather than informative, and therefore transformed into 'Body'. Abbreviations were extended to facilitate intuitive understanding.
```{r}
names(meanStdAct) <- sub("\\(\\)","",names(meanStdAct),)
names(meanStdAct) <- sub("^t","time",names(meanStdAct),)
names(meanStdAct) <- sub("^f","frequ",names(meanStdAct),)
names(meanStdAct) <- sub("Acc","Accel", names(meanStdAct))
names(meanStdAct) <- sub("BodyBody","Body", names(meanStdAct),)
names(meanStdAct) <- make.names(names(meanStdAct))
names(meanStdAct) <- sub("mean","Mean", names(meanStdAct),)
names(meanStdAct) <- sub("std","Stdev", names(meanStdAct),)
```
### 10. The data frame is melted maintaining 'Activity' and 'Subject' as IDs.
```{r}
library("reshape")
tidyDataset2 <- melt(meanStdAct, id=c("Activity","Subject"), measure.vars=names(meanStdAct)[3:68])
```
### 11. Identifiers consisting of the activity and the subject were created which will serve as unique identifiers in the final dataset.
```{r}
activity.subject <- data.frame(paste(tolower(tidyDataset2$Activity),tidyDataset2$Subject, sep=""))
names(activity.subject) <- "activity.subject"
```
### 12. A new dataset is created by binding the new identifiers and the value columns
```{r}
tidyDataset2 <- cbind(activity.subject,tidyDataset2[3:4])
```
### 13. The new dataset is casted, calculating the mean of each feature for each new unique identifier.
```{r}
library("reshape2")
tidyDataset2 <- dcast(tidyDataset2, activity.subject ~ variable,mean)
```
### 14. Creation of a txt.file.
```{r}
write.table(tidyDataset2,"tidyDataset2.txt", sep = "\t", row.names = FALSE)
```