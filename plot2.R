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

# 5. Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(x = subset$Tstamp, y = subset$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()