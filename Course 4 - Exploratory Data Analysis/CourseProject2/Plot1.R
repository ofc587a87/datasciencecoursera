# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source("utils.R");

createPlot1 <- function(){
    
    data <- NEI[[1]];
    
    # creates a new dataset with the totals per year
    totalsPerYear <- matrix(dimnames = list(NULL, c("Years", "Emissions")), ncol = 2, nrow = 0);
    
    for(y in min(data$year):max(data$year)) {
        s <- sum(data$Emissions[data$year == y]);
        if(s > 0 ) {
            totalsPerYear <- rbind(totalsPerYear, c(y, s));
        }
    }
    
    # Creates device
    png(filename = "Plot1.png", width = 600, height = 480);
    
    #calculate limits fr axis, leaving space for text labels
    xLimits <- calcLimits(totalsPerYear[,1]);
    yLimits <- calcLimits(totalsPerYear[,2]);
    
    # plot the data without lower axis
    plot(totalsPerYear, type="o", xlim=xLimits, ylim=yLimits, xaxt="n");
    
    # add lower axis with all years
    axis(side=1, round(xLimits[1]):round(xLimits[2]));
    
    # add text data to each point
    text(totalsPerYear, as.character(round(totalsPerYear[,2], 2)), cex=0.8, pos=3, offset = 0.3, col = "red");
    
    # decorate plot
    title(main="Total emissions from PM2.5 in the United States");
    
    # closes png device
    dev.off();
    
    message("Image Plot1.png generated!");
}
