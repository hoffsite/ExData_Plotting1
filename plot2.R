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

# and prepare the plot
png("plot2.png",width=480,height=480)
plot(someinfo$timeMark,someinfo$Global_active_power
     ,type="l"
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)")
dev.off()

