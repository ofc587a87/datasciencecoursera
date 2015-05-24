# there is a function for each step, and a main function that runs them all

library("dplyr")

# STEP 1: Merges the training and the test sets to create one data set
step1 <- function()
{  
  # Read training data
  trainingData <- read.table("UCI HAR Dataset//train//X_train.txt", header=FALSE);
  trainingData$Subject <- read.table("UCI HAR Dataset//train//subject_train.txt", header=FALSE)[,1];
  trainingData$Activity <-  read.table("UCI HAR Dataset//train//y_train.txt", header=FALSE)[,1];
  message("Readed training data...");
  
  # Read test data 
  testData <- read.table("UCI HAR Dataset//test//X_test.txt", header=FALSE);
  testData$Subject <- read.table("UCI HAR Dataset//test//subject_test.txt", header=FALSE)[,1];
  testData$Activity <- read.table("UCI HAR Dataset//test//y_test.txt", header=FALSE)[,1];
  message("Readed test data...");
  
  # join test and training data
  result <- rbind(trainingData, testData);
  message("data join completed!");
  
  result;
}

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# EXPLANATION: Filter out the variables that are not related to mean or std, dont calculate any data
step2 <- function(data)
{
  # Read features (colnames)
  vColNames <- read.table("UCI HAR Dataset//features.txt", header=FALSE, stringsAsFactors=FALSE)[,2];
  
  # get mean, meanFrec and std variables
  filteredData <- select(data, grep("mean\\(", vColNames, ignore.case=TRUE),
                         grep("std\\(", vColNames, ignore.case=TRUE),
                         grep("meanFreq\\(", vColNames, ignore.case=TRUE),
                         Subject, Activity);
  
  message("Filtered mean and std variables");
  
  filteredData;
}

# STEP 3: Uses descriptive activity names to name the activities in the data set
step3 <- function(data)
{
  # Read activity factors
  activityFactors <- read.table("UCI HAR Dataset//activity_labels.txt", header=FALSE);
  
  #transform into text factors
  result <- mutate(data, Activity = activityFactors[data[, "Activity"],2]);
  result$Activity <- as.factor(result$Activity);
  message("Transformed activities into text factors")
  
  result;
}

# Appropriately labels the data set with descriptive variable names. 
step4 <- function(data)
{  
  # Read features (colnames)
  vColNames <- read.table("UCI HAR Dataset//features.txt", header=FALSE, stringsAsFactors=FALSE)[,2];
  
  colnames(data) <- c(make.names(c(vColNames[grep("mean\\()", vColNames, ignore.case=TRUE)],
                                   vColNames[grep("std\\()", vColNames, ignore.case=TRUE)],
                                   vColNames[grep("meanFreq\\(", vColNames, ignore.case=TRUE)])),
                                 "Subject", "Activity")
  
  message("Columns renamed")
  
  data;
}

# From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
step5 <- function(data)
{
  # group and mean of each colum
  result <- (data %>% group_by(Activity, Subject) %>% summarise_each(funs(mean)));
  message("Tidy data created!")
  
  result;
}



main <- function(writeFile = FALSE)
{
  message("Preparing data, please wait...");
  data <- step1();
  data <- step2(data);
  data <-step3(data);
  data <-step4(data);
  result <- step5(data);
  
  if(writeFile)
  {
    message("Writing result to 'tidyDataResult.txt'");
    write.table(result, "tidyDataResult.txt", append = FALSE, quote = FALSE, col.names = FALSE, row.names = FALSE);
  }
  
  result;
}
