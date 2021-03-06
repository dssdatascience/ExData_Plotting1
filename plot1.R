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

# Generate plot1 and save as 480x480 PNG
png("plot1.png", width=480, height=480)
hist(workingData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Close the PNG device
dev.off()
