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

## Plot 2
plot(data$Global_active_power~data$Datetime, 
     xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()