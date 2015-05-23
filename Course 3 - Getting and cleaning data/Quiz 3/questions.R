library("jpeg")
library("reshape2")
library("dplyr")

question1 <- function()
{
    data <- read.csv("getdata-data-ss06hid.csv")
    
    # logical vector that identifies the households on greater than 10 acres who
    # sold more than $10,000 worth of agriculture products Variables:
    #   - ACR - Lot size -> 3 .House on ten or more acres
    #   - AGS - Sales of Agriculture Products -> 6 .$10000+
    agricultureLogical <- data[which(data$ACR == 3 & data$AGS == 6),]
    
    # We only neede the rows IDs, do just return the first 3 columns (avoid 
    # screen scroll)
    head(agricultureLogical[,1:3], 3)
}

question2 <- function()
{
    # Using the jpeg package read in the following picture of your instructor
    # into R. Use the parameter native=TRUE
    img <- readJPEG("getdata-jeff.jpg", native=TRUE);
    
    # What are the 30th and 80th quantiles of the resulting data?
    quantile(img, probs = c(0.3, 0.8));
}

question3 <- function()
{
    # Load the Gross Domestic Product data for the 190 ranked countries in this
    # data set
    gdp <- read.csv("getdata-data-GDP.csv", skip=5, header=FALSE, skipNul=TRUE, stringsAsFactors=FALSE);
    
    # filter out data without country code and transform
    gdp <- gdp[, c(1, 2, 4, 5)];
    names(gdp) <- c("CountryCode", "Ranking", "Name", "GDP");
    
    suppressWarnings(gdp <- (gdp %>% filter(filter = (CountryCode != "" & Ranking != "")) %>% mutate(GDP = as.numeric(gsub(",", "", GDP))) %>% mutate(Ranking = as.numeric(Ranking)))) ;
    
        
    # Load the educational data from this data set
    edu <- read.csv("getdata-data-EDSTATS_Country.csv");
    
    # Match the data based on the country shortcode. How many of the IDs match?
    # NOTE: I use internal=FALSE to exclude non-matching rows
    mergedData <- merge(gdp, edu, by = "CountryCode", all=FALSE);
    message(paste("Rows matching:", nrow(mergedData)));
    
    
    # Sort the data frame in descending order by GDP rank (so United States is
    # last). What is the 13th country in the resulting data frame?
    mergedData <- arrange(mergedData, desc(Ranking));
    
    
    message(paste("Country #13: ", mergedData[13, "Name"]));
    
    q3Data <<- mergedData;
}

question4 <- function()
{
    groups <- group_by(q3Data, Income.Group)
    
    #What is the average GDP ranking
    summarize(groups, average=mean(Ranking));
}

question5 <- function()
{
    # Cut the GDP ranking into 5 separate quantile groups. Make a table versus
    # Income.Group. How many countries are Lower middle income but among the 38
    # nations with highest GDP?
    sortedGDP <- arrange(q3Data, desc(GDP));
    limitQuantile <- sortedGDP[38, "GDP"]
    message(paste("limitQuantile:", limitQuantile));
    
    rankedData <- (q3Data %>% mutate (HighGDP = GDP >= limitQuantile));
    #rankedData <-rankedData[rankedData$HighGDP == TRUE, c("Income.Group", "Ranking", "GDP", "HighGDP")];
    
    print(sum(rankedData$HighGDP));
    
    groups <- group_by(rankedData, Income.Group);
    summarize(groups, total=sum(HighGDP));
}