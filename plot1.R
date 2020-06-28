library(lubridate)
# Read the TXT file
data <- read.table('household_power_consumption.txt', header = T, sep = ';', na.strings = '?')
# data_bp <- data
# data <- data_bp
data$Date <- as.Date(data$Date, '%d/%m/%Y')
data$Time <- strptime(data$Time, '%H:%M:%S')
# Subsetting the data to get the useful data
data_use <- subset(data, year(Date) == 2007 & month(Date) == 02)
data_use <- subset(data_use, day(Date) == 01 | day(Date) == 02)

# plot1
png('plot1.png', width = 480, height = 480)
hist(as.numeric(data_use$Global_active_power), 
     xlab = 'Global Active Power (kilowatts)',main = 'Global Active Power', 
     col = 'red')
dev.off()