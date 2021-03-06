readData <- function(directory, id, rm.na = FALSE) {
    data <- NULL
    
    for(i in 1:length(id))
    {
        filename=paste("./", directory, "/", sprintf("%03d", id[i]), ".csv", sep="")
        # print(paste("Fichero:", filename))
        
        tmpDF <- read.csv(file=filename,)
        
        if(is.null(data)) {
            data <- tmpDF;
        } else {
            data <- rbind(data, tmpDF);
        }
    }
    
    if(rm.na) {
        data <- na.omit(data)
    }
    data
}