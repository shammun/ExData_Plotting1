setwd("C:/Ado")
## Getting full dataset
# Unless you specify check.names=FALSE, R will convert column names that are not 
# valid variable names (e.g. contain spaces or special characters or start with 
# numbers) into valid variable names, e.g. by replacing spaces with dots.
data_original <- read.csv("C:/Ado/household_power_consumption.txt", header=T, sep=';', quote='\"', 
                          na.strings="?", stringsAsFactors=F, check.names=F, comment.char="")

# comment.char="" lines to be skipped that begins with
# stringsAsFactors = FALSE tells R to keep character variables as they are rather 
# than convert to factors
# na.strings="?" as dataset have missing values coded as ?
data_original$Date <- as.Date(data_original$Date, format="%d/%m/%Y")

## Subset the data
data <- subset(data_original, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert dates to suitable format
datentime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datentime)

## Plot 4
par(mfrow=c(2,2), mar=c(3,3,2,1), oma=c(0,0,1,0))
with(data, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l",
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()