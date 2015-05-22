
loadData <- function()
{
    data <- read.csv("getdata-data-ss06hid.csv");
    data;
}

question1 <- function()
{
    data <- loadData();
    
    # logical vector that identifies the households on greater than 10 acres who
    # sold more than $10,000 worth of agriculture products
    # Variables:
    #   - ACR - Lot size -> 3 .House on ten or more acres
    #   - AGS - Sales of Agriculture Products -> 6 .$10000+
    agricultureLogical <- data[which(data$ACR == 3 & data$AGS == 6),]
    
    # WQe only neede the rows IDs, do just return the first 3 columns (avoid screen scroll)
    head(agricultureLogical[,1:3], 3)
}