

##read and modify file
household<-read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")
householdMutate<-mutate(household, date=dmy(household$Date))
householdSubset<-filter(householdMutate, date<=ymd("2007-02-02"), date>=ymd("2007-02-01"))


##set local parameters to have english names of the day in the plot (I live in Italy, default names with POSIX are in italian)
Sys.setlocale("LC_ALL", 'en_US.UTF-8')
householdSubset$date_time<-as.POSIXct(paste(householdSubset$Date, householdSubset$Time, sep = " "), format="%d/%m/%Y %H:%M:%S", tz = "GMT")
 
##open device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

##plot
y<-as.double(as.character(householdSubset$Global_active_power))
plot(householdSubset$date_time, y, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##close
dev.off() 
