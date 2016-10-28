#setting working directory in which you want to work
setwd(choose.dir())
#setting up libraries
library(dplyr)
library(lubridate)

#getting the data
ifelse(
        file.exists("household_power_consumption.txt"), 
        print("you are ready to roll"),
ifelse(
        file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip"),
        unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip"),
        {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./exdata%2Fdata%2Fhousehold_power_consumption.zip")
        ;
        unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
                }
               
       )
)

#tidying the dataset 
#the first 4 lines might take time to run
lec0      <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE, comment.char = "" ))
elec0$Date <- dmy(elec0$Date)
elec       <- filter(elec0, Date == "2007-02-01" | Date == "2007-02-02" ) #filtering for the rows that we want
remove("elec0") #remove the previous variable in order to free up memory


#plot4
elec$datetime <- paste(elec$Date, elec$Time)
elec$datetime <- as.POSIXct(elec$datetime)
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(elec$Global_active_power ~ elec$datetime, type="l", xlab = "", ylab = "Global Active Power")
plot(elec$Voltage ~ elec$datetime, type="l", xlab = "datetime", ylab = "Voltage")
plot( elec$Sub_metering_1 ~ elec$datetime, type=  "l", xlab = "", ylab = "Energy sub metering")
lines(elec$Sub_metering_2 ~ elec$datetime, type = "l", col = "red")
lines(elec$Sub_metering_3 ~ elec$datetime, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Submetering_1", "Submetering_2", "Submetering_3"))
plot(elec$Global_reactive_power ~ elec$datetime, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()