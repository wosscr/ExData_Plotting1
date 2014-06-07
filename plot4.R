# Create a file with the necessary data only
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)", 
         readLines(rawfile), 
         value=TRUE), 
    sep="\n", 
    file="filtered.txt")
close(rawfile)

# Load and clean the data into R
data <- read.table("filtered.txt",
                   sep = ";",
                   header = TRUE,
                   colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

cleanData <- data.frame(date = c(paste(data$Date, data$Time)), 
                        sub_metering_1 = data$Sub_metering_1, 
                        sub_metering_2 = data$Sub_metering_2, 
                        sub_metering_3 = data$Sub_metering_3,
                        global_active_power = data$Global_active_power,
                        global_reactive_power = data$Global_reactive_power,
                        voltage = data$Voltage)
cleanData$date <- strptime(cleanData$date, format = "%d/%m/%Y %H:%M:%S")


# Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
# [1, 1]
plot(cleanData$date,
     cleanData$global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

# [1, 2]
plot(cleanData$date,
     cleanData$voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# [2, 1]
plot(cleanData$date, 
     cleanData$sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(cleanData$date, cleanData$sub_metering_2, col = "red")
lines(cleanData$date, cleanData$sub_metering_3, col = "blue")
legend("topright",
       bty = "n",
       lty = c(1,1), 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# [2, 2]
plot(cleanData$date,
     cleanData$global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")
dev.off()