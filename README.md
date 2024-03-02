Getting and Cleaning Data Course Project
==============
***Coursera | Data Science: Foundations using R Specialization***

**Author:** *Akos Arendas*

# Summary
The file is supposed to be a short summary of my work done for the course. This project is the last assessment of Getting and Cleaning Data Course. This file contains the explanation of my analysis and function as a reference point for all the files in the repository.

---


# Files in the repository
The following table lists the files in my repository and give a high level description about them.

| File | Description |
| ----------- | ----------- |
| inst/extdata | Standard external data folder (based on CRAN suggestion) contains the downloaded data. |
| .gitignore | Specifies intentionally untracked files to ignore |
| 006_coursera_jhu_r_gacd_assignment.Rproj | R project file |
| README.md | the current file |
| README.html | README.md rendered to html |
| run_analysis.R | Script of the analysis |
| tidyData.txt | The final tidy data set |
| CodeBook.Rmd | CodeBook of the data |
---

# Project description 
*(based on the project description from Coursera)*
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The submission requires: 
1. a tidy data set as described below, 
2. a link to a Github repository with your script for performing the analysis, 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md, and
4. a README.md in the repo with the scripts. 
This repo explains how all of the scripts work and how they are connected.
---

# Data 
*(copied from Coursera)*

One of the most exciting areas in all of data science right now is wearable computing - see for example: [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [data description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Here are the data for the project:  [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

---

# Task
R script should be created, called run_analysis.R that does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. - Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
