---
  Author: David Luna Cervero
  Title: Course 3 - Getting and cleaning data - Course Project
---
# Data Science Specialization
## Course 3 - Getting and cleaning data
### Course Project

This course project belongs to the 3er course of the Data Science Specialization track from Coursera.

This projects ask to read some raw data from a provided data set, transform it, and return a tidy data set.

It follows these instructions:

* You should create one R script called run_analysis.R that does the following.
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Code description and Execution
The code is located in the file **run_analysis.R** as required.

**Important:** The library *dplyr* and its dependences are required. Once the file is sourced, it tries to load the library *dplyr*. It'll throw an error if it's not available.

The code contains several methods:

* **step1()**: Merges the training and the test data sets into one data set, with subject and activity data.
    + Does not require parameters
    + Returns the resulting dataset
* **step2(data)**: Filter out variables from the dataset that are not related to mean or standard deviation, excepting activity and subject variables. It obtains the variable names from the file *activity_labels.txt*, and analicyng if it contains the text 'mean(', 'meanFreq(' or 'std('.
    + Requires the data set obtained from step1
    + Returns the filtered data set
* **step3(data)**: Replace the the Activity variable, containing an activity ID, with its corresponding name, provided in the file *activity_labels.txt*. 
    + Requires the data set obtained from step2
    + Returns the dataset with the Activity column mutated.
* **step4(data)**: Assign variable names to each column. The name is extrated from the features names provided with the data package (*features.txt*), transformed into a valid variable name with the *make.name* function.
    + Requires the data set obtained from step3
    + Returns the dataset with the associated column names.
* **step5(data)**: creates the final tidy data set required, calculating the mean of each column, grouped by Activity and Subject.
    + Requires the data set obtained from step4
    + Returns the tidy dataset.
* **main(writeFile=FALSE)**: Quick test method, executes automatically the secuence of steps.
    + there is an optional parameter:
        + writeFile: Indicates if a file should be writen with the result. If TRUE, writes a file named *tidyDataResult.txt* in the work directory, using the function write.table (uploaded to coursera course evaluation). Defaults to FALSE.
    + Returns the tidy dataset.

As execution can take time, each method uses the message function to inform the user about the execution status.

### Code book

The results return a data frame with 180 observations and 81 variables:

* **Activity**: Activity the subject was realizingwhen the data was collected. It's a factor (String) of one of this values:     
    + LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS or WALKING_UPSTAIRS.
* **Subject**: Subject doing the activities, identified by ID (integer).
* **Other variables**: The other 79 variables contains the mean of the data collected for the subject in that activity, for the given original variable.
    + **Refer to the original data about the meaning and units of each variable.** IT's located at **[UCI HAR Dataset/README.txt](./UCI%20HAR%20Dataset/README.txt)**

