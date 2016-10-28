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
elec0      <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE, comment.char = "" ))
elec0$Date <- dmy(elec0$Date)
elec       <- filter(elec0, Date == "2007-02-01" | Date == "2007-02-02" ) #filtering for the rows that we want
remove("elec0") #remove the previous variable in order to free up memory



#plot2
elec$datetime <- paste(elec$Date, elec$Time)
elec$datetime <- as.POSIXct(elec$datetime)
png("plot2.png", width=480, height=480)
plot(elec$Global_active_power ~ elec$datetime, type="l", xlab = "", ylab = "Global Active Power (kilowatts")
dev.off()




