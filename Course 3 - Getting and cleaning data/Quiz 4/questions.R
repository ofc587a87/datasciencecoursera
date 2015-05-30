

question1 <- function() 
{
    # Read data
    data <- read.csv("getdata-data-ss06hid.csv");
    
    #read original names
    vColNames <- colnames(data);
    message(paste("there are", length(vColNames), "columns."))
    message(paste0("The 123th column is named '", vColNames[123], "'"))
    
    #reaplce and print solution
    modNames <- strsplit(vColNames, split = "wgtp")

    message(paste0("The 123th column is renamed '", modNames[123], "'")) 
}

readGDPData <- function() {
    # Read data
    data <- read.csv("getdata-data-GDP.csv", skip=5, header = FALSE, stringsAsFactors = FALSE);
    
    # filter columns
    data <- data[,c(1,2,4,5)]
    
    #stablish column names
    names(data) <- c("countryCode", "ranking", "countryName", "GDP")
    
    
    message(paste("Colums:", as.character(paste(names(data), collapse=", "))));
    message(paste("Rows:", nrow(data)));
    message(paste("cols:", ncol(data)));
    
    #sanitize
    data <- data[   !grepl("(^$)", data[,"countryCode"])
          & !grepl("(^$)", data[,"ranking"])
          & !grepl("(\\.)+|(^$)", data[,"GDP"])
        , ];
    
    message(paste("Sanitized to ", nrow(data), "rows"));
    
    data;
}

question2 <- function() {
    
    data <- readGDPData();
    
    # extract column and replace comas
    gdp <- as.numeric(gsub(",", "", data[, "GDP"]))
    
    message(paste("Mean of",length(gdp), "GDP readings is", mean(gdp)));
}

question3 <- function() {
    
    data <- readGDPData();
    
    # filter with nregexp
    countryNames <- data[grepl("^United", data[,"countryName"]),"countryName"];
    
    message(paste("Filtered from", nrow(data), "to", length(countryNames)))
    message("Result:")
    message(paste(countryNames, collapse=", "))
}