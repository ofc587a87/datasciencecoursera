
library("xlsx")
library("XML")
library("data.table")

question1 <- function() {
    # reads file
    data <- read.csv(file = "getdata-data-ss06hid.csv")
    
    # How many properties are worth $1,000,000 or more?
    message(paste("Num properties are worth $1,000,000 or more:", nrow(data[!is.na(data$VAL)& data$VAL == 24 ,])))
}

question3 <- function() {
    # reads file, rows 18-23 and columns 7-15
    data <- read.xlsx("getdata-data-DATA.gov_NGAP.xlsx", sheetIndex = 1, header=TRUE,
                      startRow = 18, endRow=23);
    
    dat <- data[, 7:15];
    
    message(paste("Result: ", sum(dat$Zip*dat$Ext,na.rm=T)))
}

question4 <- function()
{
    #reads data
    data <- xmlParse("getdata-data-restaurants.xml");
    
    root <- xmlRoot(data);
    
    #extract zipcodes
    zipCodes <- xpathSApply(root, "//zipcode", xmlValue);

    # How many restaurants have zipcode 21231?
    message(paste("Num restaurants with zipcode 21231:", sum(zipCodes == "21231")));
}