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

# plot2
Sys.setlocale("LC_TIME", "English") # Setting the weekdays() returning English

# get the positions of labels "Fri" and "Sat" on the x-axis
Fri_position <- min(grep('Fri', weekdays(data_use$Date, T)))
Sat_position <- nrow(data_use)

png('plot2.png', width = 480, height = 480)
plot(data_use$Global_active_power, type = 'l', xaxt = 'n', 
     xlab = NA, ylab = 'Global Active Power (kilowatts)')
axis(side = 1, at = c(1,Fri_position,Sat_position), 
     labels = c('Thu','Fri','Sat'))
dev.off()