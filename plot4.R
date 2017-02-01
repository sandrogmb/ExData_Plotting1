##read and modify file
household<-read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")
householdMutate<-mutate(household, date=dmy(household$Date))
householdSubset<-filter(householdMutate, date<=ymd("2007-02-02"), date>=ymd("2007-02-01"))


##set local parameters to have english names of the day in the plot (I live in Italy, default names with POSIX are in italian)
Sys.setlocale("LC_ALL", 'en_US.UTF-8')
householdSubset$date_time<-as.POSIXct(paste(householdSubset$Date, householdSubset$Time, sep = " "), format="%d/%m/%Y %H:%M:%S", tz = "GMT")
 
##open device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

##set par
par("mfcol"=c(2,2))

##set locale
Sys.setlocale("LC_ALL", 'en_US.UTF-8')

##plot1
plot(householdSubset$date_time, y, type = "l", xlab = "", ylab = "Global Active Power")

##plot2
with(householdSubset, plot(date_time, as.double(as.character(householdSubset$Sub_metering_1)), type = "l", col="black", xlab = "", ylab = "Energy sub metering"))
par(new=T)
with(householdSubset, plot(date_time, as.double(as.character(householdSubset$Sub_metering_2)), type = "l", axes=F, ylim = yrange, col="red", xlab = "", ylab = ""))
par(new=T)
with(householdSubset, plot(date_time, as.double(as.character(householdSubset$Sub_metering_3)), type = "l", axes=F, ylim = yrange, col="blue", xlab = "", ylab = ""))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

##plot3
with(householdSubset, plot(date_time, as.double(as.character(householdSubset$Voltage)), type = "l", col="black", xlab = "datetime", ylab = "Voltage"))

##plot4
with(householdSubset, plot(date_time, as.double(as.character(householdSubset$Global_reactive_power)), type = "l", col="black", xlab = "datetime", ylab = "Global_reactive_power"))

##close dev
dev.off()
