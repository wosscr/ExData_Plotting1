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

cleanData <- data.frame(Date = c(paste(data$Date, data$Time)), 
                        sub_metering_1 = data$Sub_metering_1, 
                        sub_metering_2 = data$Sub_metering_2, 
                        sub_metering_3 = data$Sub_metering_3)
cleanData$Date <- strptime(cleanData$Date, format = "%d/%m/%Y %H:%M:%S")

# Plot 3 directly on the PNG file
png(file = "plot3.png", width = 480, height = 480)
plot(cleanData$Date, 
     cleanData$sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(cleanData$Date, cleanData$sub_metering_2, col = "red")
lines(cleanData$Date, cleanData$sub_metering_3, col = "blue")
legend("topright", 
       lty = c(1,1), 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()