
## Exploratory Data Analysis - Joy Flowers
## Plot 3 Submetering Plot - Third plot of Course Project 1
## October 10, 2015
## This code retrieves data from the website listed below, unzips the file, reads the file,
## converts data, and plots submetering 1,2,and 3 data for the specified data time range
## (for date range 2-1-2007 to 2-2-2007) to match the assigned plot. Three plots are overlayed.
library("dplyr")
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
elecconsump <- download.file(fileUrl,destfile="household_power_consumption.zip",method="curl")
dateDownloaded <- date()
unzip("household_power_consumption.zip")
allfile <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
allfile$Date <- as.Date(as.character(allfile$Date),"%d/%m/%Y")
FEB2007 <- subset(allfile,allfile$Date >= "2007-02-01" & allfile$Date <= "2007-02-02")
Dttm <- as.POSIXct(paste(FEB2007$Date, FEB2007$Time), format="%Y-%m-%d %H:%M:%S")
FEB2007 <- mutate(FEB2007,Dttm) 
FEB2007$Sub_metering_1 <- as.numeric(levels(FEB2007$Sub_metering_1))[FEB2007$Sub_metering_1]
FEB2007$Sub_metering_2 <- as.numeric(levels(FEB2007$Sub_metering_2))[FEB2007$Sub_metering_2]                                                     
png(filename="plot3.png",width=480,height=480,units="px")
par(mfrow=c(1,1))
par(mgp=c(2.5,0.75,0))
plot(FEB2007$Dttm,FEB2007$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(FEB2007$Dttm, FEB2007$Sub_metering_2,col="red",type="l")
lines(FEB2007$Dttm, FEB2007$Sub_metering_3,col="blue",type="l")
legend(x="topright",y=25,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),cex=0.9)
dev.off()

