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

# Plot 2
# make new variable with weekdays

data3 <- data2 %>%
  mutate(Weekday=wday(Date_new, label=TRUE)) %>%
  mutate(Weeknr=wday(Date_new)) %>%
  relocate(Weekday, .before="Time") %>%
  relocate(Weeknr, .befor="Weekday")

plot(data3$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="",xaxt="n")
axis(1, c(0,1500,2880), labels=c("Thu","Fri", "Sat"))
dev.copy(png, file="Plot2.png", width=480, height=480)
dev.off()