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

# Plot 3
plot(data3$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="",xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
lines(data3$Sub_metering_2, col="red")
lines(data3$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1" , 
                              "Sub_metering_2", 
                              "Sub_metering_3"),
       col= c("black", "red", "blue"),
       lwd=1, cex = 0.8)
dev.copy(png, file="Plot3.png", width=480, height=480)
dev.off()