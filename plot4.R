#DOWNLOAD DATA
if(!file.exists("./Data")){
  dir.create("./Data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./Data/HouseHold_Power_Consumption.zip")
  
  #UNZIP DATA
  unzip("./Data/HouseHold_Power_Consumption.zip", exdir = "./Data")
}

#READING DATA

powerConsumption <- read.table("./Data/household_power_consumption.txt", sep = ";", 
                               header = TRUE, colClasses = "character" )

#Subsetting Date
subpowerConsumption <- subset(powerConsumption, powerConsumption$Date == "1/2/2007" | powerConsumption$Date == "2/2/2007")

#Changing Type of Variables and Transforming Time Data 
subpowerConsumption$Date <- as.Date(subpowerConsumption$Date, format = "%d/%m/%Y")
subpowerConsumption$Time <- as.POSIXct(paste(subpowerConsumption$Date, 
                                             subpowerConsumption$Time), format = "%Y-%m-%d %H:%M:%S")
#Plot
png(filename = "plot4.png", width = 480, height = 480)

#Configuring Global Plot Parameters

par(mfrow = c(2, 2))

#Plot 1
with(subpowerConsumption, plot(Time, as.numeric(Global_active_power), type = "l",
                               xlab = "", ylab = "Global Active Power"))
#Plot 2
with(subpowerConsumption, plot(Time, as.numeric(Voltage), type = "l",
                               xlab = "datetime", ylab = "Voltage"))
#Plot 3
with(subpowerConsumption, {
  #Lines
  plot(Time, as.numeric(Sub_metering_1), type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Time, as.numeric(Sub_metering_2), col = "red")
  lines(Time, as.numeric(Sub_metering_3), col = "blue")
  #Legend
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.75)
})

#Plot 4
with(subpowerConsumption, plot(Time, as.numeric(Global_reactive_power), type = "l",
                               xlab = "datetime", ylab = "Global_reactive_power"))


dev.off()
