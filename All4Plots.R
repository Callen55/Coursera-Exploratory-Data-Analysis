##Read in the dataset, name columns:
power <- read.table("household_power_consumption.txt",
                    skip=1, sep=";", 
                    col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                  "Voltage", "Global_intensity", "Sub_Metering_1", "Sub_Metering_2"
                                  ,"Sub_Metering_3")
                    )
## Extract desired dates:
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

## Clean up column Classes
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
subpower$Global_reactive_power <- as.numeric(as.character(subpower$Global_reactive_power))
subpower$Voltage <- as.numeric(as.character(subpower$Voltage))
subpower$Sub_Metering_1<-as.numeric(as.character(subpower$Sub_Metering_1))
subpower$Sub_Metering_2<-as.numeric(as.character(subpower$Sub_Metering_2))
subpower$Sub_Metering_3<-as.numeric(as.character(subpower$Sub_Metering_3))
##Apply date to "Time" observation. 
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


## Create First Plot
hist(subpower$Global_active_power,col="red", main="Global Active Power",
     xlab="Global Active Power(kilowatts)")

## Create Second Plot
plot(subpower$Time,subpower$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)") 

##Create Third Plot

plot(subpower$Time,subpower$Sub_Metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpower,lines(Time,Sub_Metering_1))
with(subpower,lines(Time,Sub_Metering_2,col="red"))
with(subpower,lines(Time,Sub_Metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))
title(main="Energy sub-metering")



## Creating the fourth plot:
## Setup Graph rows and Columns:
par(mfrow=c(2,2))

## Calling the Plot function to create the required graphics
with(subpower,{
      plot(subpower$Time,subpower$Global_active_power,type="l",  xlab="",ylab="Global Active Power")  
      plot(subpower$Time,subpower$Voltage, type="l",xlab="datetime",ylab="Voltage")
      plot(subpower$Time,subpower$Sub_Metering_1,type="n",xlab="",ylab="Energy sub metering")
      with(subpower,lines(Time,Sub_Metering_1))
      with(subpower,lines(Time,Sub_Metering_2,col="red"))
      with(subpower,lines(Time,Sub_Metering_3,col="blue"))
      legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), cex = 0.6)
      plot(subpower$Time,subpower$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})
