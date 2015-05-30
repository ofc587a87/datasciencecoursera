

question1 <- function() 
{
    # Read data
    data <- read.csv("getdata-data-ss06hid.csv");
    
    vColNames <- colnames(data);
    message(paste("there are", length(vColNames), "columns."))
    message(paste0("The 123th column is named '", vColNames[123], "'"))
    
    modNames <- strsplit(vColNames, split = "wgtp")
    
    message(paste0("The 123th column is renamed '", modNames[123], "'"))
    
}