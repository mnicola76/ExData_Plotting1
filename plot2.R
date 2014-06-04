createPlot2 <- function() 
{
    ## Open png and set parameters
    png(
        "plot2.png",
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
    
    ## Generate plot
    myPlot <- with(hhsubset, 
                   plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), 
                        Global_active_power, 
                        type="l", ## line plot
                        xlab="",  ## blank x-axis label
                        ylab="Global Active Power (kilowatts)"))
    
    ## Finally, write and close png file
    dev.off()      
}