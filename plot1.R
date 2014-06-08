## R-Script 
## Data Science Specialization
## Exploratory Data Analysis
## Assignment 1

# 1. Set working directory
#    Working directory contains the data and will save the data
setwd("~/Coursera/Exploratory Data Analysis/Assignment 1")

# 2. Load package lubridate
library(lubridate)

# 3. Loading in the Data
data <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
# Missing values are replaced by: na.strings = "?"
# Get an overview of the data
str(data)
summary(data)

# 4. Do some pre-processing
# a. Convert days & time: strptime() and as.Date()
#    Combine Time and Day and create a time stamp
data$Tstamp <- paste(data$Date, data$Time)
data$Tstamp <- as.POSIXct(data$Tstamp, format = "%d/%m/%Y %H:%M:%S")
#    Get an overview of the data, whether it is 

# b. Indexing dates: 2007-02-01 and 2007-02-02.
#    A 2-day period in February, 2007
data$Date <- dmy(data$Date) # dd/mm/yyyy
date1 <- ymd("2007-02-01")
date2 <- ymd("2007-02-02")
int <- new_interval(date1, date2)

# c. Create a subset of the data
subset <- data[data$Date %within% int, ]
#    Make sure the required days are in the data set
table(subset$Date) # Yes

# 5. Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(subset$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.off()

# b. Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(x = subset$Tstamp, y = subset$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()

# c. Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(x = subset$Tstamp, y = subset$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = subset$Tstamp, y = subset$Sub_metering_2, col = "red")
lines(x = subset$Tstamp, y = subset$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)
dev.off()

# d. Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
plot(x = subset$Tstamp, y = subset$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
plot(x = subset$Tstamp, y = subset$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")
plot(x = subset$Tstamp, y = subset$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = subset$Tstamp, y = subset$Sub_metering_2, col = "red")
lines(x = subset$Tstamp, y = subset$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)
plot(x = subset$Tstamp, y = subset$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
