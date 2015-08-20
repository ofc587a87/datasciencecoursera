# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

library(ggplot2);

source("utils.R");


createPlot5 <- function() {
    
    #get motor vehicles related sources (indicated in Short.Name)
    sccData <- SCC[[1]];
    motorSCC <- sccData$SCC[grepl("vehicle", sccData$Short.Name, ignore.case = TRUE)];
    
    #get data 
    data <- NEI[[1]];
    
    #subset data for Baltimore city and those using motor vehicle source
    data <- subset(data, fips == "24510" & SCC %in% motorSCC);
    
    #create summarized data frame
    df = data.frame();
    for(y in unique(data$year)) {
        s=sum(data$Emissions[data$year == y]);
        if(s>0) {
            df <- rbind(df, data.frame(Year=y, Emissions=s));
        }
    }
    
    
    plot <- qplot(Year, Emissions, data=df, main="Total emissions from PM2.5 by motor vehicles in Baltimore City, Maryland") +
        scale_x_continuous(limits=calcLimits(df$Year), breaks=min(df$Year):max(df$Year)) +
        scale_y_continuous(limits=calcLimits(df$Emissions)) +
        geom_line() +
        geom_text(aes(label=round(Emissions, 2)), colour = "red", size=2.5, hjust=-0.1, vjust=0);
    
    ggsave(filename = "Plot5.png", plot = plot, width = 8, height = 6, dpi=100);
    
    message("Image Plot5.png generated!");
}
