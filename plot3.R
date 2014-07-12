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

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)",xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})


## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()