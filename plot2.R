## Before run 
##      source("plot2.R")
##      plot2()
## Use setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis") to set the currentl wokring directory 

plot2 <- function()
{
        ## Assume the data file "household_power_consumption.txt" is under the sub-folder 
        ## "/exdata_data_household_power_consumption" in the current wokring directory
        
        filename <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
        testdata <- read.table(filename, sep=";", header=TRUE)
        
        ## Get data with the dates 2007-02-01 and 2007-02-02. 
        data <- testdata[testdata$Date=="1/2/2007" | testdata$Date=="2/2/2007", ]
        
        ## remove the level info and convert Global_active_power variable to numeric
        data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
        
        ## Create a new column "DateTime" with Date/Time classes
        data["DateTime"] <- NA
        data$Date <- as.character(data$Date)
        data$Time <- as.character(data$Time)
        data$DateTime <- paste(data$Date, data$Time,sep=' ')
        data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S") 
        
        ## draw the diagram with plot()
        with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
        
        ## write to PNG file and close PNG device
        dev.copy(png, file="plot2.png")
        dev.off()
        
}