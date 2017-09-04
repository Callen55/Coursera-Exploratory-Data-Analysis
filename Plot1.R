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