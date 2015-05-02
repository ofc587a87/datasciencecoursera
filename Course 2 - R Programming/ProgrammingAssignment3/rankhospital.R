# Exercise 3: "rankhospital"

source("exercise1.R");

rankhospital <- function(state, outcome, num = "best") {
    
    hospitalName <- NULL;
    
    ##read outcome data
    data <- readOutcome();
    
    ## check that stats and outcome are valid
    checkSanity(data, state, outcome);
    
    # check num param
    rankIndex <- NA;
    if(num == "best") { rankIndex <- 1; }
    else if(num =="worst") { rankIndex <- -1; } else {
        #supress warnings. If it fails, it will be NA, that will be checked later
        suppressWarnings(rankIndex <- as.integer(num));
    }
    
    # if it's invalid, return NA;
    if(is.na(rankIndex)) {
        return(NA);
    }
    
    # filter data with state and "Not Available" outcome
    filterData <- data[data$State == state, ];
    filterData <- filterData[filterData[[outcome]] != "Not Available", ];
    
    # convert to numeric, there are not NA as "Not Available" are filtered out
    filterData[[outcome]] <- as.numeric(filterData[[outcome]]);
    
    #create data frame with data (without rank)
    unrankedData=data.frame(Hospital.Name = filterData$Hospital.Name, Rate = filterData[[outcome]]);
    
    #create ranked data sorting
    rankedData = cbind(unrankedData[order(unrankedData$Rate, unrankedData$Hospital.Name),], Rank=1:nrow(unrankedData));
    
    #adjust worst index
    if(rankIndex == -1) { rankIndex <- nrow(rankedData); }
        
    # returns a character vector with Hospital name in that state with the given rank
    # if there is no Hospital at given rank, return NA
    if(nrow(rankedData) < rankIndex) {
        return(NA);
    } else {
        c(as.character(rankedData[rankedData$Rank == rankIndex, ]$Hospital.Name));
    }
}