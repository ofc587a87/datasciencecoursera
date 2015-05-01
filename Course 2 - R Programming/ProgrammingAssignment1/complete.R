# Part 2:
# 
# Write a function that reads a directory full of files and reports the number
# of completely observed cases in each data file.

# The function should return a data frame where the first column is the name of
# the file and the second column is the number of complete cases.

source("commons.R")


complete <- function(directory, id = 1:332)
{
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1 117
    ## 2 1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    #Step 1: Create empty result
    result <- NULL
    
    
    #Step 2: iterate and count complete data
    for(i in 1:length(id))
    {
        rowData <- readData(directory, id[i], TRUE)
        if(is.null(result))
        {
            result <- data.frame(id=id[i], nobs=nrow(rowData))
        } else {
            result <- rbind(result, data.frame(id=id[i], nobs=nrow(rowData)))
        }
    }
    
    result
}