# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

source("utils.R");

createPlot2 <- function(){
    
    data <- NEI[[1]];
    
    #subset data for Baltimore
    baltimoreData <- subset(data, fips == "24510");
    
    ###### SAME CODE AS createPlot1, but using baltimoreData #######
    
    # creates a matrix  with the totals per year
    totalsPerYear <- matrix(dimnames = list(NULL, c("Years", "Emissions")), ncol = 2, nrow = 0);
    
    for(y in min(baltimoreData$year):max(baltimoreData$year)) {
        s <- sum(baltimoreData$Emissions[baltimoreData$year == y]);
        if(s > 0 ) {
            totalsPerYear <- rbind(totalsPerYear, c(y, s));
        }
    }
        
    # Creates device
    png(filename = "Plot2.png", width = 600, height = 480);
    
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
    title(main="Total emissions from PM2.5 in Baltimore City, Maryland");
    
    # closes png device
    dev.off();
    
    message("Image Plot2.png generated!");
}