library(tidyverse)
library(readxl)
library(readr)

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

#   Read data ----
trainDataFile <- "inst/extdata/UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt"
testDataFile <- "inst/extdata/UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt"
train_data <- read.table(trainDataFile)
test_data <- read.table(testDataFile)

View(test_data)

