#   Getting and Cleaning Data Course Project
#   UCLA, Courserat

#   Loading packages ----
library(tidyverse)
library(readxl)
library(readr)
library(data.table)
library(gsubfn)

#   Download and unzip the file ----
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "project_dataset.zip"
fileFolder <- "UCI_HAR_Dataset"
dataDest <- "inst/extdata/UCI_HAR_Dataset"

if(!file.exists(paste0("inst/extdata/", fileName))){
  download.file(url = fileUrl,
                destfile = paste0("inst/extdata/", fileName),
                method = "curl")
}

if(!file.exists(paste0("inst/extdata/",fileFolder))){
  unzip(paste0("inst/extdata/", fileName), exdir = dataDest)
}

#   Read all required data ----
path <- paste0(getwd(), "/", dataDest)

#   Train data
trainData <- read.table(
  file.path(path, "UCI HAR Dataset/train/X_train.txt"),
)

trainActivity <- read.table(
  file.path(path, "UCI HAR Dataset/train/y_train.txt"),
)
trainActivity <- trainActivity %>% rename(Activity = V1)


trainSubject <- read.table(
  file.path(path, "UCI HAR Dataset/train/subject_train.txt")
)
trainSubject <- trainSubject %>% rename(subjectID = V1)

#   Test data
testData <- read.table(
  file.path(path, "UCI HAR Dataset/test/X_test.txt")
  )

testActivity <- read.table(
  file.path(path, "UCI HAR Dataset/test/y_test.txt"),
)
testActivity <- testActivity %>% rename(Activity = V1)

testSubject <- read.table(
  file.path(path, "UCI HAR Dataset/test/subject_test.txt")
  )
testSubject <- testSubject %>% rename(subjectID = V1)

#   Activity labels
activityLabels <- read.table(
  file.path(path, "UCI HAR Dataset/activity_labels.txt"),
  col.names = c("classLabels", "activityNames")
  )

#   Features
features <- read.table(
  file.path(path, "/UCI HAR Dataset/features.txt"),
  col.names = c("index", "featureNames")
  )

#   Extract mean and std dev ----
# Extracting mean and standard deviation for each measure (from features)

featuresWant <- grep("(mean|std)\\(\\)", features$featureNames)
measures <- features$featureNames[featuresWant]

#   Descriptive labels ----
measures <- gsubfn(
  "(^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\))",
  list(
    "t" = "Time",
    "f" = "Frequency",
    "Acc" = "Accelerometer",
    "Gyro" = "Gyroscope",
    "Mag" = "Magnitude",
    "BodyBody" = "Body",
    "()" = ""
    ),
  measures
  )

#   Filter and adjust data ----
testData <- testData[, featuresWant]
colnames(testData) <- measures


trainData <- trainData[, featuresWant]
colnames(trainData) <- measures

#   Merge data ----
# Merge data sets together
test <- cbind(testActivity, testSubject, testData)
train <- cbind(trainActivity, trainSubject, trainData)
fullData <- rbind(test, train)


#   Factor data ----

# factor Activity column based on activity labels
# use factor() to set own levels and labels
fullData[["Activity"]] <- factor(
  fullData[, "Activity"],
  levels = activityLabels[["classLabels"]],
  labels = activityLabels[["activityNames"]]
)

# as.factor() to create turn subject numbers into factors
fullData[["subjectID"]] <- as.factor(fullData[, "subjectID"])

# transform fullData from list to a data.table type
fullData_dt <- as.data.table(fullData)

# melt then cast the data table
fullData_dt <- melt.data.table(fullData_dt, id.vars = c("subjectID", "Activity"))

# melt down to variable & value
# avg of subjectID & Activity
fullData_dt <- dcast(fullData_dt, subjectID + Activity ~ variable, mean)


#   Final result ----
write.table(fullData_dt, file = "tidyData.txt", row.name = FALSE)
