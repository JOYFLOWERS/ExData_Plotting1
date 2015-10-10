## Exploratory Data Analysis - Joy Flowers
## Plot 1 Global Active Power Histogram - First plot of Course Project 1
## October 10, 2015
## This code retrieves data from the website listed below, unzips the file, reads the file,
## converts data, and plots it into a histogram looking at global active power
## for date range 2-1-2007 to 2-2-2007 to match the assigned plot.
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
elecconsump <- download.file(fileUrl,destfile="household_power_consumption.zip",method="curl")
dateDownloaded <- date()
unzip("household_power_consumption.zip")
allfile <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
allfile$Date <- as.Date(as.character(allfile$Date),"%d/%m/%Y")
FEB2007 <- subset(allfile,allfile$Date >= "2007-02-01" & allfile$Date <= "2007-02-02")
##attach(FEB2007)
FEB2007$Global_active_power <- as.numeric(levels(FEB2007$Global_active_power))[FEB2007$Global_active_power]
png(filename="plot1.png",width=480,height=480,units="px")
hist(FEB2007$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
