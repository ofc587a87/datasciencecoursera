# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

library(ggplot2);

source("utils.R");

createPlot3 <- function() {
    data <- NEI[[1]];
    
    #subset data for Baltimore
    baltimoreData <- subset(data, fips == "24510");
    
    message("Calculating data by type...")
    # convert source type to factors
    baltimoreData$type <- as.factor(baltimoreData$type);
    
    # creates a dataframe with the totals per year, for each source type
    totalsPerYear <- data.frame();
    
    types <- unique(baltimoreData$type);
    
    for(y in unique(baltimoreData$year)) {
        for(type in types){
            s <- sum(baltimoreData$Emissions[baltimoreData$year == y & baltimoreData$type == type]);
            if(s > 0 ) {
                totalsPerYear <- rbind(totalsPerYear, data.frame(Years=y, Emissions=s, SourceType=type));
            }
        }
    }
    
    message("Creating plot...");
    
    plot <- qplot(Years, Emissions, data=totalsPerYear, main = "Total emissions from PM2.5 by Source Type in Baltimore City, Maryland") +
        scale_x_continuous(limits=calcLimits(totalsPerYear$Years), breaks=min(totalsPerYear$Years):max(totalsPerYear$Years)) +
        geom_line() +
        geom_text(aes(label=round(Emissions, 2)), colour = "red", size=2.5, hjust=-0.1, vjust=0)+
        facet_grid(facets = SourceType~., scales = "free_y");
    
    ggsave(filename = "Plot3.png", plot = plot, width = 9, height = 6.5, dpi=100);
    
    message("Image Plot3.png generated!");
}