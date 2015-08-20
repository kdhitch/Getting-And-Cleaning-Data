##The object of this script is to:
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each 
##    measurement. 
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names. 
## 5. From the data set in step 4, create a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

##Load dplyr
library(dplyr)

##Load column labels for test and training data.

labelNames <- read.table("./UCI Har Dataset/features.txt", 
                         colClasses = "character")
labelNames <- as.vector(labelNames$V2)

##Load test data. Use labelNames object to assign appropriate column labels.
##Note that default settings are used that replace invalid characters in column 
##labels [i.e. "()" and "-"] with the "." character.

testData <- read.table("./UCI Har Dataset/test/X_test.txt", header = FALSE, 
                       sep = "", fill = TRUE, col.names = labelNames)

testActivity <- read.table("./UCI Har Dataset/test/y_test.txt", 
                           col.names = "activityCode")

testSubject <- read.table("./UCI Har Dataset/test/subject_test.txt", 
                          colClasses = "factor", col.names = "subject")

##Create a single data frame for the test set, including measurement data, 
##activity code and subject ID.

testMerged <- cbind(testSubject, testActivity, testData)

##Load training data.

trainData <- read.table("./UCI Har Dataset/train/X_train.txt", header = FALSE, 
                        sep = "", fill = TRUE, col.names = labelNames)

trainActivity <- read.table("./UCI Har Dataset/train/y_train.txt", 
                            col.names = "activityCode")

trainSubject <- read.table("./UCI Har Dataset/train/subject_train.txt", 
                           colClasses = "factor", col.names = "subject")

##Create a single data frame for the training set, including measurement data, 
##activity code and subject ID.

trainMerged <- cbind(trainSubject, trainActivity, trainData)

##Combine test and train data into a single data frame.

combinedData <- rbind(testMerged, trainMerged)

##Create data frame with activity names for corresponding activity codes.

activityLabels <- read.table("./UCI Har Dataset/activity_labels.txt")
activityLabels <- rename(activityLabels, activityCode = V1, activityName = V2)

##Add column to combinedData that is populated with the appropriate activity
##name for the activity code in each row.

combinedData <- left_join(combinedData, activityLabels)

##Create a data frame with subject ID, activity, and data columns that represent
##only the mean and standard deviation values (represented by "-mean()" and
## "-std()" in the original data) for each of the measurements. Note that
##column names were edited when the data was imported above, replacing invalid
##column characters "(", ")" and "-" with ".".

finalData <- select(combinedData, subject, activityName, contains(".mean.."), 
                    contains(".std.."))

finalMeans <- finalData %>% group_by(subject, activityName) %>% 
        summarise_each(funs(mean))

write.table(finalMeans, file="activityAverages.txt", row.name=FALSE)

##The following code reads exported file back into R. 
##Source: https://class.coursera.org/getdata-031/forum/thread?thread_id=28
data <- read.table("./activityAverages.txt", header = TRUE) 
View(data)