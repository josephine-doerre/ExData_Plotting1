# load packages
library(dplyr)
library(lubridate)

# read data
data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

str(data)

# first select the date interval: 2007-02-01 & 2007-02-02
date <- as.data.frame(as.Date(data$Date, "%d/%m/%Y"))
names(date) <- "Date_new"
new <- cbind(date, data)

data2 <- subset(new, Date_new >= "2007-02-01" & Date_new <= "2007-02-02",select= -Date)
rm(data, date, new, sel)

# Plot 1
hist(data2$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="Plot1.png", width=480, height=480)
dev.off()
