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

#Changing Type of Variables and Transforming Time Data (Concatenate Date with Time) 
subpowerConsumption$Date <- as.Date(subpowerConsumption$Date, format = "%d/%m/%Y")
subpowerConsumption$Time <- as.POSIXct(paste(subpowerConsumption$Date, 
                                             subpowerConsumption$Time), format = "%Y-%m-%d %H:%M:%S")

#Plot
png(filename = "plot2.png", width = 480, height = 480)

with(subpowerConsumption, plot(Time, as.numeric(Global_active_power), type = "l",
                               xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

