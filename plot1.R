# Create a file with the necessary data only
rawfile <- file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)", 
         readLines(rawfile), 
         value=TRUE), 
    sep="\n", 
    file="filtered.txt")
close(rawfile)

# Load the data into R
data <- read.table("filtered.txt",
                   sep = ";",
                   header = TRUE,
                   colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Plot 1
hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlim = c(0, 6),
     ylim = c(0, 1200),
     xlab = "Global Active Power (kilowatts)")
# Create png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()