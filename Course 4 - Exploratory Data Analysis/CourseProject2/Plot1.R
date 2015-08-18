# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source("utils.R");

createPlot1 <- function(){
    
    data <- NEI[[1]];
    
    # creates a new dataset with the totals per year
    totalsPerYear <- matrix(dimnames = list(NULL, c("Years", "Emissions")), ncol = 2, nrow = 0);
    
    for(y in 1998:2008) {
        s <- sum(data$Emissions[data$year == y]);
        if(s > 0 ) {
            totalsPerYear <- rbind(totalsPerYear, c(y, s));
        }
    }
    
    plot(totalsPerYear, type="o", xlim=c(1998.5, 2008.5), ylim=c(3200000, 7500000));
    text(totalsPerYear, as.character(round(totalsPerYear[,2], 2)), cex=0.8, pos=3, offset = 0.3, col = "red");
    title(main="Total emissions from PM2.5 in the United States");
}
