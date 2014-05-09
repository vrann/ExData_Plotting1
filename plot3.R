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
studiedSet$Sub_metering_1 = as.double(studiedSet$Sub_metering_1)
studiedSet$Sub_metering_2 = as.double(studiedSet$Sub_metering_2)
studiedSet$Sub_metering_3 = as.double(studiedSet$Sub_metering_3)

# Use PNG graphic device
png("plot3.png", bg="transparent")

# define scale for y axes
ylim=range(c(studiedSet$Sub_metering_1, studiedSet$Sub_metering_2, studiedSet$Sub_metering_3))

# plot 3 diagrams one by one, par(new=T) makes it use same canvas
with(studiedSet, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", ylim=ylim))
par(new=T)
with(studiedSet, plot(DateTime, Sub_metering_2, type="l", ylab="Energy sub metering", xlab="", ylim=ylim, col="red"))
par(new=T)
with(studiedSet, plot(DateTime, Sub_metering_3, type="l", ylab="Energy sub metering", xlab="", ylim=ylim, col="blue"))

#add a legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"))

dev.off()