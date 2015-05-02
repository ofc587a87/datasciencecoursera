# Exercise 2
source("exercise1.R")

best <- function(state, outcome) {
    
    hospitalName <- NULL;
    ##read outcome data
    data <- readOutcome();

    # filter data with state
    filterData=data[data$State == state, ];
    
    ## check that stats and outcome are valid
    if(nrow(filterData) == 0) {
        stop ("invalid state");
    }

    # replace column names for expected (and simple) outcomes
    tmpNames <- names(filterData);
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "heart attack");
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "heart failure");
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", "pneumonia");
    names(filterData) <- tmpNames;


    if(!outcome %in% names(filterData)) {
        stop("invalid outcome");
    }
    
    # convert to numeric, supress warnings about NA for "Not Available"
    suppressWarnings(filterData[[outcome]] <- as.numeric(filterData[[outcome]]));
    
    
    # get min value (there are not NAs)
    minValue <- min(filterData[[outcome]], na.rm = TRUE);
    
    # get hospitals with min value
    hospitals <- filterData[filterData[[outcome]] == minValue, ]$Hospital.Name;
    hospitals <- hospitals[!is.na(hospitals)];
    
    # if there are only one result, it's a character, not a vector
    if(is.character(hospitals)) {
        hospitalName <- hospitals;
    } else {
        # if it's a vector, sort and return the first one as result
        hospitals <- sort(hospitals)
        hospitalName <- c(hospitals[0]);
    }
    
    ## return hospital name in that state with lowest 30-day death rate
    hospitalName;
}