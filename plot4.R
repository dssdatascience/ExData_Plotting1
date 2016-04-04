# Read in the dataset as efficiently as possible
inputData <- read.csv(file="household_power_consumption.txt", header=TRUE, sep=';',
                      quote="\"", dec=".", fill=TRUE, na.strings="?",
                      stringsAsFactors=FALSE, nrows=2075259, comment.char="")

# Format the date
inputData$Date <- as.Date(inputData$Date, format="%d/%m/%Y")

# Subset the data: dates 2007-02-01 and 2007-02-02
workingData <- subset(inputData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Clean up
rm(inputData)

# Convert dates/times
workingData$Datetime <- as.POSIXct(paste(as.Date(workingData$Date), workingData$Time))

# Generate plot4 and save as 480x480 PNG
png("plot4.png", width=480, height=480)

# Create a multi-paneled plotting window with 2 rows and 2 cols
# Adjust margins and total margin space that is outside  
# of the standard plotting region
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(workingData, {
    plot(Global_active_power~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    plot(Voltage~Datetime, type="l", xlab="", ylab="Voltage (volt)")
    plot(Sub_metering_1~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    lines(Sub_metering_2~Datetime, col="red")
    lines(Sub_metering_3~Datetime, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, bty="n", col=c("black", "red", "blue"))
    plot(Global_reactive_power~Datetime, type="l", xlab="", ylab="Global Rective Power (kilowatts)")
})

# Close the PNG device
dev.off()
