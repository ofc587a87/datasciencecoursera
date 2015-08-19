
# read files and extract data
readFiles <- function() {
    #read NEI data and transform factors
    NEI <- readRDS("summarySCC_PM25.rds");
    message("NEI file readed");
    
    #read SCC data
    SCC <- readRDS("Source_Classification_Code.rds");
    message("SCC file readed");
    
    list(NEI, SCC);
}

# calc limits for axis, with extra space for text labels
calcLimits <- function(vect) {
    limitsBias <- (max(vect) - min(vect)) / 20;
    limits <- c(min(vect) - limitsBias, max(vect) + limitsBias);
    limits;
}

# read data only at first execution
if(!exists("NEI", inherits = FALSE) || !exists("SCC", inherits = FALSE)){
    message("Reading data (only at first load)");
    data <- readFiles();
    NEI <- data[1];
    SCC <- data[2];
    rm("data");
    message("Done!");
}

# Specifies number of decimals to omit scientific format (axis labels)
options(scipen=5);