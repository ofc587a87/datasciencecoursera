
# prepare data required for exercise 1
readOutcome <- function() {
    # read data of CSV forcing every variable as character
    # use <<- to store it as a global variable, outside the function environment
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character");

    # debug message
    # message(paste("Readed", nrow(outcome), " obs. with", ncol(outcome), "variables"));
    
    # replace column names for expected (and simple) outcomes
    tmpNames <- names(data);
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "heart attack");
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "heart failure");
    tmpNames <- replace(tmpNames, tmpNames=="Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", "pneumonia");
    names(data) <- tmpNames;
    
    data;
}

checkSanity <- function(origData, state=NULL, outcome)
{
    filterData <- origData;
    if(!is.null(state)) {
        filterData=origData[origData$State == state, ];
    }
    
    ## check that stats and outcome are valid
    if(nrow(filterData) == 0) {
        stop ("invalid state");
    }
    
    
    if(!outcome %in% names(filterData)) {
        stop("invalid outcome");
    } 
}

# plot histogram of las 30 days death rates from heart attach
# column 11 of the outcome dataset
plotHistogram <- function(dataOutcome)
{
    #conver column to numeric in order to be plotted
    dataOutcome[, 11] <- as.numeric(dataOutcome[, 11]);
    message ("ignore NA warnings");
    
    # plot histogram
    hist(dataOutcome[, 11]);
}


# Nothing to submit at this point, just reading and showing sample data