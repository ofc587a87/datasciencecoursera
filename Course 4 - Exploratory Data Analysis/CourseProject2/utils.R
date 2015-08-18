
readFiles <- function() {
    
    NEI <- readRDS("summarySCC_PM25.rds");
    message("NEI file readed");
    SCC <- readRDS("Source_Classification_Code.rds");
    message("SCC file readed");
    
    list(NEI, SCC);
}

if(!exists("NEI", inherits = FALSE) || !exists("SCC", inherits = FALSE)){
    message("Reading data (only at first load)");
    data <- readFiles();
    NEI <- data[1];
    SCC <- data[2];
    rm("data");
    message("Done!");
}

# Specfifies number of decimals to use scientifis format for decimals
options(scipen=5);