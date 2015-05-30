

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
    
    message("Reading GDP data... ", appendLF=FALSE);
    
    # Read data
    data <- read.csv("getdata-data-GDP.csv", skip=5, header = FALSE, stringsAsFactors = FALSE);
    
    # filter columns
    data <- data[,c(1,2,4,5)]
    
    #stablish column names
    names(data) <- list("countryCode", "ranking", "countryName", "GDP")
    
    #sanitize
    data <- data[   !grepl("(^$)", data$countryCode)
          & !grepl("(^$)", data$ranking)
          & !grepl("(\\.)+|(^$)", data$GDP)
        , ];
    
    message(paste("Sanitized to", nrow(data), "rows, Done!"));
    
    data;
}

readEDSData <- function() {
    
    message("Reading EDS data... ", appendLF=FALSE);
    
    # Read data
    data <- read.csv("getdata-data-EDSTATS_Country.csv", stringsAsFactors = FALSE);
    
    # filter columns
    data <- data[,c(1, 2, 10)]
    
    #stablish column names
    names(data) <- gsub("\\.", "", names(data));
    
    #sanitize
    data <- data[   !grepl("(^$)", data$CountryCode)
                    & !grepl("(^$)", data$LongName)
                    , ];
    
    message(paste("Sanitized to", nrow(data), "rows, Done!"));
    
    data;
}

question2 <- function() {
    
    data <- readGDPData();
    
    # extract column and replace comas
    gdp <- as.numeric(gsub(",", "", data$GDP))
    
    message(paste("Mean of",length(gdp), "GDP readings is", mean(gdp)));
}

question3 <- function() {
    
    data <- readGDPData();
    
    # filter with nregexp
    countryNames <- data$countryName[grepl("^United", data$countryName)];
    
    message(paste("Filtered from", nrow(data), "to", length(countryNames), "starting with word 'United'"))
    message("Result:", appendLF=FALSE)
    message(paste(countryNames, collapse=", "))
}

question4 <- function() {
    
    #read GDP data
    gdpData <- readGDPData();
    
    #read EDS data
    edsData <- readEDSData();
    
    # merge data
    mergedData <- merge(gdpData, edsData, by.x="countryCode", by.y="CountryCode", all = FALSE);
    
    message(paste("Merged data to", nrow(mergedData), "rows"));
    
    fiscalData <- mergedData$SpecialNotes[grepl("^Fiscal year end: June", mergedData$SpecialNotes)];
    
    message(paste("Fiscal year end in June:", length(fiscalData), "countries"));
}
