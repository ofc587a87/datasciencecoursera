# Exercise 4: rankall

source("exercise1.R");

findHospital <- function (stateList, rankIndex) {
    state=names(stateList)[1];
    sublist=stateList[[state]];
    numRows <- nrow(sublist);
    sublist$rank <- 1:numRows;
    
    subIndex <- rankIndex;
    if(subIndex == -1) { subIndex <- numRows; }
    
    #find hospital name
    hospitalName <- NA;
    if(!is.na(subIndex) && subIndex <= numRows) {
        hospitalName <- as.character(sublist[sublist$rank == subIndex, ]$hospital);
    }
    
    # creates result
    result <- cbind(hospital=hospitalName, state=state);
    result;
}

rankall <- function(outcome, num="best")
{
    ## read outcome data
    result <- NULL;
    
    ##read outcome data
    data <- readOutcome();
    
    ## check outcome is valid
    checkSanity(data, outcome=outcome);
    
    # check num param
    rankIndex <- NA;
    if(num == "best") { rankIndex <- 1; }
    else if(num =="worst") { rankIndex <- -1; } else {
        #supress warnings. If it fails, it will be NA, that will be checked later
        suppressWarnings(rankIndex <- as.integer(num));
    }
    
    # filter data with state and "Not Available" outcome
    filterData <- data[data[[outcome]] != "Not Available", ];
    
    # convert to numeric, there are not NA as "Not Available" are filtered out
    filterData[[outcome]] <- as.numeric(filterData[[outcome]]);
    
    # global ordering
    filterData <- filterData[order(filterData[[outcome]], filterData$Hospital.Name),];
    
    #create list split by state
    rankedData <- split(data.frame(hospital=filterData$Hospital.Name, outcome=filterData[[outcome]]), filterData$State);
        
    #add rank by state and filter, creating dataframe. pas rankIndex ad additional parameter
    resultList <- sapply(split(rankedData, names(rankedData)), findHospital, rankIndex);
    
    result <- data.frame(hospital=resultList[1,], state=resultList[2,]);
    
    ##return data fram with the hospital name and the abreviated state name
    result
}