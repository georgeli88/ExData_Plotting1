## Before run 
##      source("plot1.R")
##      plot1()
## Use setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis") to set the currentl wokring directory 


plot1 <- function()
{
        ## Assume the data file "household_power_consumption.txt" is under the sub-folder 
        ## "/exdata_data_household_power_consumption" in the current wokring directory
        
        filename <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
        testdata <- read.table(filename, sep=";", header=TRUE)
        
        ## Get data with the dates 2007-02-01 and 2007-02-02. 
        data <- testdata[testdata$Date=="1/2/2007" | testdata$Date=="2/2/2007", ]
        
        ## remove the levle info and convert Global_active_power variable to numeric
        data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
        
        ## draw the diagram
        hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
        
        ## write to PNG file and close PNG device
        dev.copy(png, file="plot1.png")
        dev.off()
    
}