question1 <- function() {
    
    # reads file
    data <- read.csv(file = "getdata-data-ss06hid.csv")
    
    # How many properties are worth $1,000,000 or more?
    message(paste("Num properties are worth $1,000,000 or more:", nrow(data[!is.na(data$VAL)& data$VAL == 24 ,])))
}