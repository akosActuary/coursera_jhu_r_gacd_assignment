Code Book
====
***Coursera | Data Science: Foundations using R Specialization | Getting and Cleaning Data Course Project"***
---

# Summary
This Code Book contains the description of the applied data for the project. Check README.md for high level description of the files for the project.
After the data description, the applied steps for the analysis are explained.
The result of the project is a tidy data set that meets with the requirements of tidy data [defintion](https://stat2labs.sites.grinnell.edu/Handouts/rtutorials/IntroTidyData.html#:~:text=Definition%20of%20a%20tidy%20data%20set&text=Each%20value%20of%20a%20variable,table%20titles%2C%20etc.).

---

# Data
*(from the aforementioned website)*

## Data set information
Data for the project: [Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones).

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset. 

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: http://www.youtube.com/watch?v=XOEN9W05_4A

An updated version of this dataset can be found at http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions. It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows. 

## Additional Variable Information
For each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 

## Files and their descriptions
The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

**Additional notes**:

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

---

# Data transformation and analysis
**The code is applying the following steps**:

1. Loading packages
2. Download and unzip the file
3. Read all required data
4. Extract mean and std dev
5. Descriptive labels
6. Filter and adjust data
7. Merge data
8. Factor data
9. Final result

**Detailed description and explanation**

After loading necessary packages, the data is downloaded to int/extdata folder (`download.file`) in zip version and than it is unzipped. This step is executed only if the data is not found in the destination folder and if it is not unzipped yet.

All the used data is being read (`read.table`), saved into variables, and preliminary modifications are done (mainly column renaming, e.g. with `rename` function).
The required variables are extracted from the data sets (means and standard deviations). In this part `grep` function is used. 

- `"(mean|std)\\(\\)"`: This is the pattern being searched for. Let's break it down:
  - `(mean|std)`: This part specifies a pattern to match either "mean" or "std".
  - `\\(` and `\\)`: These are escape sequences for matching literal parentheses. Since parentheses are special characters in regular expressions, they need to be escaped with backslashes to be treated as literal characters.
  
This code is using the `gsubfn` function in R. `gsubfn` is a part of the `gsubfn` package in R, and it extends the functionality of the `gsub` function by allowing replacement with the result of a function evaluation.
The most complicated part is: `"(^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\))"`. This is a regular expression pattern that specifies what patterns to search for in the measures vector. Let's break it down:

- `^t|^f`: This part matches strings that start with "t" or "f".
- `Acc`, `Gyro`, `Mag`, `BodyBody`: These are specific substrings that are being searched for in `measures`.
- `\\(\\)`: This part matches literal parentheses "()". Since parentheses are special characters in regular expressions, they need to be escaped with backslashes to be treated as literal characters.

After standard filtering, the extracted and adjsuted data sets are being merged (`cbind` and `rbind`).

Finally, the data is factored along the acitivites and subject variables. Eventually the data is "melted" to the final format.

- `melt.data.table()`: 
  - This function is used to reshape the data from wide to long format. It transforms the data table `fullData_dt` so that the values in multiple columns (other than the specified id.vars) are "melted" down into two columns: one for the variable names and one for their corresponding values.
  - In this case, the id.vars parameter specifies the columns that should remain as identifiers, meaning they won't be melted down. In this code, subjectID and Activity columns are specified as the id variables.
  - After this operation, fullData_dt will have additional columns for the variable names and their corresponding values.

- `dcast()`:
  - This function is used to cast the melted data table back into a different shape, typically from long to wide format. It reshapes the data based on the formula provided.
  - The formula provided to `dcast()` specifies how the data should be reshaped. In this case, it's `subjectID + Activity ~ variable`, meaning that `subjectID` and `Activity` will be used as the rows (each combination forming a unique row), and `variable` will be spread out as columns. The `~` separates the rows from the columns.
  - The third argument `mean` specifies the aggregation function to use when there are multiple values for a combination of the variables specified in the formula. In this case, mean will calculate the `mean` value for each combination of `subjectID`, `Activity`, and `variable.`
  - This code chunk will produce a new data table `fullData_dt` where the variables that were previously melted down will now be spread out as columns, with the mean values calculated for each combination of `subjectID`, `Activity`, and `variable`.
  
The final results are produced with `write.table` function and creates the tidy result in file `tidyData.txt`.
