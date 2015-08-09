getepc <- function() {
  # function to acquire electric power consumption data frame
  temp  <- tempfile()
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,temp,method="curl")
  data  <- read.csv2(unz(temp,"household_power_consumption.txt"))
  unlink(temp)
  data
}  


# get information
allinfo  <- getepc()

# convert date and time columns to date and time
require(lubridate)
allinfo$Date <- dmy(allinfo$Date)
allinfo$Time <- hms(allinfo$Time)
allinfo$timeMark <- allinfo$Date+allinfo$Time

# reduce the days of 2/1/2007 and 2/2/2007
begin<-ymd("2007-02-01")
end <-ymd("2007-02-02")
someinfo <- subset(allinfo,Date>=begin & Date<=end)

someinfo$Global_active_power <- 
  as.numeric(as.character(someinfo$Global_active_power))
someinfo$Sub_metering_1 <- 
  as.numeric(as.character(someinfo$Sub_metering_1))
someinfo$Sub_metering_2 <- 
  as.numeric(as.character(someinfo$Sub_metering_2))
someinfo$Sub_metering_3 <- 
  as.numeric(as.character(someinfo$Sub_metering_3))
someinfo$Voltage <- 
  as.numeric(as.character(someinfo$Voltage))
someinfo$Global_reactive_power <- 
  as.numeric(as.character(someinfo$Global_reactive_power))

# and prepare plot 3
png("plot3.png",width=480,height=480)
plot(someinfo$timeMark,someinfo$Sub_metering_1
     ,type="l"
     ,xlab=""
     ,ylab="Energy sub metering")
lines(someinfo$timeMark,someinfo$Sub_metering_2
      ,col="red")
lines(someinfo$timeMark,someinfo$Sub_metering_3
      ,col="blue")
legend("topright"
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue")
       ,lty="solid")
dev.off()
