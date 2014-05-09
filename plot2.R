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

# Use PNG graphic device
png("plot2.png", bg="transparent")
# Plot the lines plot of the Global Active Power measured by minutes during the day
with(studiedSet, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()