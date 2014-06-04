createPlot3 <- function() 
{
    ## Open png and set parameters
    png(
        "plot3.png",
        width     = 480,
        height    = 480,
        units     = "px",
        type      = "cairo-png"
    )
    
    ## Set column types of incoming file
    cols <- c('factor',  ##Date
              'factor',  ##Time
              'numeric', ##Global_active_power
              'numeric', ##Global_reactive_power
              'numeric', ##Voltage
              'numeric', ##Global_intensite
              'numeric', ##Sub_metering_1
              'numeric', ##Sub_metering_2
              'numeric') ##Sub_metering_3
    
    ## Load file (no need to read the whole lot)
    household <- read.table('household_power_consumption.txt', 
                          header=TRUE, 
                          sep=";", 
                          colClasses=cols, 
                          na.strings="?",
                          nrows = 1000000)
    
    ## Subset just the 2 Feb days we're interested in
    hhsubset <- subset(household, Date %in% c('1/2/2007', '2/2/2007'))
    
    ## Create line plot - setup most of the format but don't plot anything yet
    with(hhsubset, plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), 
                        Sub_metering_1,
                        type="n", ## don't plot any data yet
                        xlab="",
                        ylab="Energy sub metering"))

    ## Add to line plot for Sub_metering_1
    with(hhsubset, lines(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
                         Sub_metering_1,  
                         col = "black",
                         type = "l"))
    
    ## Add to line plot for Sub_metering_2
    with(hhsubset, lines(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
                         Sub_metering_2,  
                         col = "red",
                         type = "l"))

    ## Add to line plot for Sub_metering_3
    with(hhsubset, lines(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
                         Sub_metering_3,
                         col = "blue",
                         type = "l"))    

    ## Add legend
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"),
           lwd = 1, 
           pch = c(NA, NA, NA)) 
    
    #Finally, write and close png file
    dev.off()      
}