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

data3 <- data2 %>%
  mutate(Weekday=wday(Date_new, label=TRUE)) %>%
  mutate(Weeknr=wday(Date_new)) %>%
  relocate(Weekday, .before="Time") %>%
  relocate(Weeknr, .befor="Weekday")

# Plot 4
par(mfrow = c(2, 2))

plot(data3$Global_active_power, type="l", ylab="Global Active Power", xlab="",xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
plot(data3$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
plot(data3$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="",xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
lines(data3$Sub_metering_2, col="red")
lines(data3$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1" , 
                              "Sub_metering_2", 
                              "Sub_metering_3"),
       col= c("black", "red", "blue"),bty = "n",
       lwd=1)
plot(data3$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
png("plot4.png", width=480, height=480)
dev.off()