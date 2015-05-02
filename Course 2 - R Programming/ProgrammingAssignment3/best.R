# Exercise 2

source("exercise1.R")

best <- function(state, outcome) {
    
    hospitalName <- NULL;
    
    ##read outcome data
    data <- readOutcome();
    
    ## check that stats and outcome are valid
    checkSanity(data, state, outcome);

    # filter data with state
    filterData=data[data$State == state, ];
    
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