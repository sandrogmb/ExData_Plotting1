##file to draw first plot

##read file
household<-read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")

##elaborate file
householdMutate<-mutate(household, date=dmy(household$Date))
householdSubset<-filter(householdMutate, date<=ymd("2007-02-02"), date>=ymd("2007-02-01"))

##open plot device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

##draw hist
hist(x=as.double(as.character((householdSubset$Global_active_power))), breaks = 12, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")

##close dev
dev.off()
