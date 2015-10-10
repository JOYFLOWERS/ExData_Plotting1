
## Exploratory Data Analysis - Joy Flowers
## Plot 4 Consists of Four Plots - Fourth plot of Course Project 1
## October 10, 2015
## This code retrieves data from the website listed below, unzips the file, reads the file,
## converts data, and creates four plots (two-by-two). The first one is a repeat of plot 2 above with 
## a slight change to the header. The second looks at voltage over the specified date range. The third is
## a repeat of plot 3 above with some minor formatting changes, and the fourth looks at global reactive power
## data for the specified data time range - (all for date range 2-1-2007 to 2-2-2007) to match the assigned plots.
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
FEB2007$Global_reactive_power <- as.numeric(levels(FEB2007$Global_reactive_power))[FEB2007$Global_reactive_power]
FEB2007$Global_active_power <- as.numeric(levels(FEB2007$Global_active_power))[FEB2007$Global_active_power]
FEB2007$Voltage <- as.numeric(levels(FEB2007$Voltage))[FEB2007$Voltage]
FEB2007$Sub_metering_1 <- as.numeric(levels(FEB2007$Sub_metering_1))[FEB2007$Sub_metering_1]
FEB2007$Sub_metering_2 <- as.numeric(levels(FEB2007$Sub_metering_2))[FEB2007$Sub_metering_2]  
png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
plot(FEB2007$Dttm,FEB2007$Global_active_power,type="l",ylab="Global Active Power",xlab="",cex.axis=1,cex.lab=1)
plot(FEB2007$Dttm,FEB2007$Voltage,type="l",cex.axis=1,cex.lab=1,xlab="datetime",ylab="Voltage")
plot(FEB2007$Dttm,FEB2007$Sub_metering_1,type="l",ylab="Energy sub metering",cex.axis=1,cex.lab=1,xlab="")
lines(FEB2007$Dttm, FEB2007$Sub_metering_2,col="red",type="l")
lines(FEB2007$Dttm, FEB2007$Sub_metering_3,col="blue",type="l")
legend(x="topright",y=25,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),bty="n",cex=0.93)
plot(FEB2007$Dttm,FEB2007$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",cex.axis=1,cex.lab=1)
dev.off()


