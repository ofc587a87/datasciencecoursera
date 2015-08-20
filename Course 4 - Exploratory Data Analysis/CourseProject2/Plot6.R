# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

library(ggplot2);

source("utils.R");

createPlot6 <- function() {
    
    message("Preparing data...");
    
    #get motor vehicles related sources (indicated in Short.Name)
    sccData <- SCC[[1]];
    motorSCC <- sccData$SCC[grepl("vehicle", sccData$Short.Name, ignore.case = TRUE)];
    
    #get data 
    data <- NEI[[1]];
    
    #subset data for Baltimore city and LosAngeles County and those using motor vehicle source
    data <- subset(data, fips %in% c("24510", "06037") & SCC %in% motorSCC);
    
    #location labels
    data$fips[data$fips == "24510"] <- "Baltimore City, Maryland";
    data$fips[data$fips == "06037"] <- "Los Angeles County, California";
    
    #create summarized data frame
    df = data.frame();
    for(y in unique(data$year)) {
        for(fips in data$fips) {
            s=sum(data$Emissions[data$year == y & data$fips == fips]);
            if(s>0) {
                df <- rbind(df, data.frame(Year=y, Emissions=s, Fips=fips));
            }
        }
    }
    
    message("Creating plot...");
    
    #create plot
    plot <- qplot(Year, Emissions, data=df, main="Total emissions from PM2.5 by motor vehicles comparison") +
        scale_x_continuous(limits=calcLimits(df$Year), breaks=min(df$Year):max(df$Year)) +
        geom_line()+
        geom_text(aes(label=round(Emissions, 2)), colour = "red", size=2.5, hjust=-0.1, vjust=0);
    
    #add reduction label aestethics for each location
    for(loc in unique(df$Fips)){
        plot <- plot + geom_text(data = NULL,
              x = min(df$Year[df$Fips == loc]),
              y = min(df$Emissions[df$Fips == loc]),
              hjust = 0, vjust = 0, colour="red",
              label = paste("Total reduction:",
                            round(100 - (min(df$Emissions[df$Fips == loc]) * 100 / max(df$Emissions[df$Fips == loc])),2),
                            "%"));
    }
    
    #add facets
    plot <- plot + facet_grid(facets = Fips~., scales = "free_y");
    
    ggsave(filename = "Plot6.png", plot = plot, width = 8, height = 6, dpi=100);
    
    message("Image Plot6.png generated!");
}
