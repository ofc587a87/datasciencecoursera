# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

library(ggplot2);

source("utils.R");


createPlot4 <- function() {
    
    #get coal related sources
    sccData <- SCC[[1]];
    coalSCC <- sccData$SCC[grepl("coal", sccData$Short.Name, ignore.case = TRUE)];

    #get data and filter by those using coal source
    data <- NEI[[1]];
    data <- data[data$SCC %in% coalSCC,];

    #create summarized data frame
    df = data.frame();
    for(y in unique(data$year)) {
        s=sum(data$Emissions[data$year == y]);
        if(s>0) {
            df <- rbind(df, data.frame(Year=y, Emissions=s));
        }
    }
    

    plot <- qplot(Year, Emissions, data=df, main="Total emissions from PM2.5 by Coal sources in United States") +
        scale_x_continuous(limits=calcLimits(df$Year), breaks=min(df$Year):max(df$Year)) +
        scale_y_continuous(limits=calcLimits(df$Emissions)) +
        geom_line() +
        geom_text(aes(label=round(Emissions, 2)), colour = "red", size=2.5, hjust=-0.1, vjust=0);
    
    ggsave(filename = "Plot4.png", plot = plot, width = 8, height = 5, dpi=100);
    
    message("Image Plot4.png generated!");
}

