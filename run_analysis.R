
runAnalysis <- function() {

   # load required dplyr package if not loaded already
   require(dplyr)

   # read the required datasets
   features <- read.table("UCI HAR Dataset/features.txt", col.names=c("Index", "Features"))
   activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("ActivityId", "Activity"))

   ## test dataset
   testDataset <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features$Features, check.names=FALSE)
   testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject")
   testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="ActivityId")

   ## training dataset
   trainDataset <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features$Features, check.names=FALSE)
   trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject")
   trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="ActivityId")

   # create activity labels for subject activities
   testActivityLabels <- left_join(testActivities, activityLabels, by="ActivityId")
   trainActivityLabels <- left_join(trainActivities, activityLabels, by="ActivityId")

   # add subject and activity columns to the datasets
   testDataset <- cbind(testSubjects, testActivityLabels["Activity"], testDataset)
   trainDataset <- cbind(trainSubjects, trainActivityLabels["Activity"], trainDataset)
 
   # combine test and train datasets
   fullDataset <- rbind(testDataset, trainDataset)

   # from this dataset, select Subject, Activity and all other computed mean and standard deviation variables
   ## computed mean and standard deviation variables contain .mean() or .std() in their names
   fullDataset <- fullDataset[, grepl("Subject|Activity|mean\\(\\)|std\\(\\)", colnames(fullDataset))]

   # group dataset by Subject, Activity and average (mean) of all other variables
   tidyData <- fullDataset %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

   # return tidy data as a data frame
   as.data.frame(tidyData)
}