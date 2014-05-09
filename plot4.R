## Dataset of Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years is used
## Plot the frequencies of the Global Active Power for the dates 2007-02-01 and 2007-02-03

# Check if file with the data exists in the local directory 
if (!file.exists("household_power_consumption.txt")) {
    message("Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip and unzip to a working directory");
}

# Read the data from the file
householdPowerConsumption = read.table("household_power_consumption.txt", sep=";", header=T, as.is=T)

# Get subset of the data for the dates 2007-02-01 and 2007-02-03
studiedSet = subset(householdPowerConsumption, as.Date(Date, "%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(Date, "%d/%m/%Y") < as.Date("2007-02-03"));
studiedSet$DateTime = strptime(paste(studiedSet$Date, studiedSet$Time, " "), format("%d/%m/%Y %H:%M:%S "))

# Convert values to doubles
studiedSet$Global_active_power = as.double(studiedSet$Global_active_power)
studiedSet$Sub_metering_1 = as.double(studiedSet$Sub_metering_1)
studiedSet$Sub_metering_2 = as.double(studiedSet$Sub_metering_2)
studiedSet$Sub_metering_3 = as.double(studiedSet$Sub_metering_3)
studiedSet$Voltage = as.double(studiedSet$Voltage)
studiedSet$Global_reactive_power = as.double(studiedSet$Global_reactive_power)

# Use PNG graphic device
png("plot4.png", bg="transparent")

par(mfcol=c(2, 2))
# Plot the lines plot of the Global Active Power measured by minutes during the day
with(studiedSet, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# Plot submetering
ylim=range(c(studiedSet$Sub_metering_1, studiedSet$Sub_metering_2, studiedSet$Sub_metering_3))
with(studiedSet, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", ylim=ylim))
par(new=T)
with(studiedSet, plot(DateTime, Sub_metering_2, type="l", ylab="", xlab="", ylim=ylim, col="red", axes=F))
par(new=T)
with(studiedSet, plot(DateTime, Sub_metering_3, type="l", ylab="", xlab="", ylim=ylim, col="blue", axes=F))
legend("topright", bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"))

# Plot voltage
with(studiedSet, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime", yaxt='n', frame.plot = TRUE))
axis(side=2, at=seq(234, 246, by=4))

# Plot Global Reactive power
with(studiedSet, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

dev.off()