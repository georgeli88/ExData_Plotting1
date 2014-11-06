## Before run 
## Use setwd("C:\\Class_Training\\Data Science\\4. Exploratory Data Analysis") to set the currentl wokring directory 
## Run the following scrips in R Studio
##      source("plot4.R")
##      plot4()

plot4 <- function()
{

        ## Assume the data file "household_power_consumption.txt" is under the sub-folder 
        ## "/exdata_data_household_power_consumption" in the current wokring directory

        filename <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
        testdata <- read.table(filename, sep=";", header=TRUE)

        ## Get data with the dates 2007-02-01 and 2007-02-02. 
        data <- testdata[testdata$Date=="1/2/2007" | testdata$Date=="2/2/2007", ]
        
        ## Create a new column "DateTime" with Date/Time classes
        data["DateTime"] <- NA
        data$Date <- as.character(data$Date)
        data$Time <- as.character(data$Time)
        data$DateTime <- paste(data$Date, data$Time,sep=' ')
        data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S") 

        ## remove the level info and convert Global_active_power variable to numeric
        data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
        
        ## remove the level info and convert Global_reactive_power variable to numeric
        data$Global_reactive_power <- as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]
        
        ## remove the level info and convert Voltage variable to numeric
        data$Voltage <- as.numeric(levels(data$Voltage))[data$Voltage]
        
        ## remove the level info and convert energy sub-metering variables to numeric
        data$Sub_metering_1 <- as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
        data$Sub_metering_2 <- as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]

        ## define mfrow=2X2 
        par(mfrow=c(2,2))
        
        ## plot "Global Active Power"
        with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
        
        ## plot "Voltage"
        with(data, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

        ## plot "Energy sub meeting"
        with(data, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub meeting", type="n"))
        with(subset(data), points(DateTime,Sub_metering_1, type="l", col="black"))
        with(subset(data), points(DateTime,Sub_metering_2, type="l", col="red"))
        with(subset(data), points(DateTime,Sub_metering_3, type="l", col="blue"))
        legend("topright", lty=1, cex=0.6, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        ## plot "Global_reactive_power"
        with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

        ## write to PNG file and close PNG device
        dev.copy(png, file="plot4.png")
        dev.off()
}