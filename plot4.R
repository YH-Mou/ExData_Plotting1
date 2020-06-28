library(lubridate)
# Read the TXT file
data <- read.table('household_power_consumption.txt', header = T, sep = ';')
# data_bp <- data
# data <- data_bp
data$Date <- as.Date(data$Date, '%d/%m/%Y')
data$Time <- strptime(data$Time, '%H:%M:%S')
# Subsetting the data to get the useful data
data_use <- subset(data, year(Date) == 2007 & month(Date) == 02)
data_use <- subset(data_use, day(Date) == 01 | day(Date) == 02)

# regard ? as NA
data_use[,-c(1,2)][data_use[,-c(1,2)] == '?'] <- NA

# plot4
Sys.setlocale("LC_TIME", "English") # Setting the weekdays() returning English

# get the positions of labels "Fri" and "Sat" on the x-axis
Fri_position <- min(grep('Fri', weekdays(data_use$Date, T)))
Sat_position <- nrow(data_use)

png('plot4.png', width = 480, height = 480)
par(mfcol = c(2,2))

# plot 1-1
plot(data_use$Global_active_power, type = 'l', xaxt = 'n', 
     xlab = NA, ylab = 'Global Active Power (kilowatts)')
axis(side = 1, at = c(1,Fri_position,Sat_position), 
     labels = c('Thu','Fri','Sat'))

#plot 2-1
with(data_use,{
  plot(Sub_metering_1, col = 'black', 
       type = 'l', xaxt = 'n', xlab = NA, ylab = 'Energy sub metering')
  lines(Sub_metering_2, col = 'red')
  lines(Sub_metering_3, col = 'blue')
})

axis(side = 1, at = c(1,Fri_position,Sat_position), 
     labels = c('Thu','Fri','Sat'))
legend('topright', lty = 1, col = c('black','red','blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'))

# plot 1-2
plot(data_use$Voltage, type = 'l', xaxt = 'n', 
     xlab = 'datetime', ylab = 'Voltage')
axis(side = 1, at = c(1,Fri_position,Sat_position), 
     labels = c('Thu','Fri','Sat'))

# plot 2-2
plot(data_use$Global_reactive_power, type = 'l', xaxt = 'n', 
     xlab = 'datetime', ylab = 'Global_reactive_power')
axis(side = 1, at = c(1,Fri_position,Sat_position), 
     labels = c('Thu','Fri','Sat'))

dev.off()