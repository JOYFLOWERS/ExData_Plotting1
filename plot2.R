
## Exploratory Data Analysis - Joy Flowers
## Plot 2 DataTime compared with Global Active Power - Second plot of Course Project 1
## October 10, 2015
## This code retrieves data from the website listed below, unzips the file, reads the file,
## converts data, and plots it comparing data time information to global active power
## for date range 2-1-2007 to 2-2-2007 to match the assigned plot.
library("dplyr")
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
elecconsump <- download.file(fileUrl,destfile="household_power_consumption.zip",method="curl")
dateDownloaded <- date()
unzip("household_power_consumption.zip")
allfile <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
allfile$Date <- as.Date(as.character(allfile$Date),"%d/%m/%Y")
FEB2007 <- subset(allfile,allfile$Date >= "2007-02-01" & allfile$Date <= "2007-02-02")
#attach(FEB2007)
FEB2007$Global_active_power <- as.numeric(levels(FEB2007$Global_active_power))[FEB2007$Global_active_power]
Dttm <- as.POSIXct(paste(FEB2007$Date, FEB2007$Time), format="%Y-%m-%d %H:%M:%S")
FEB2007 <- mutate(FEB2007,Dttm) 
png(filename="plot2.png",width=480,height=480,units="px")
plot(FEB2007$Dttm,FEB2007$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
