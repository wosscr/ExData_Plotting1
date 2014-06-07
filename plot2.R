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

cleanData <- data.frame(Date = c(paste(data$Date, data$Time)), Global_active_power = data$Global_active_power)
cleanData$Date <- strptime(cleanData$Date, format = "%d/%m/%Y %H:%M:%S")

# Plot 2
plot(cleanData, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Create png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()