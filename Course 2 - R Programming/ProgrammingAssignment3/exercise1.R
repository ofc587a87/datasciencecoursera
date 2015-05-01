
# prepare data required for exercise 1
readOutcome <- function() {
    # read data of CSV forcing every variable as character
    # use <<- to store it as a global variable, outside the function environment
    outcome <<- read.csv("outcome-of-care-measures.csv", colClasses = "character");

    # debug message
    message(paste("Readed", nrow(outcome), "rows of", ncol(outcome), "variables"));
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