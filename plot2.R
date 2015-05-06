##create a local directory
if(!file.exists("./data")){dir.create("./data")}
## download file from given url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/exdata-data-household_power_consumption.zip")
##unzip the downloaded file
unzip(zipfile="./data/exdata-data-household_power_consumption.zip",exdir="./data")
## read complete data from the unzipped file
completeData<-read.csv("./data/household_power_consumption.txt",
                       header = TRUE, stringsAsFactors = F,sep=';',
                       na.strings="?")
## to check the correctness of imported data take a look at head
head(completeData)
##change the format of date variable
completeData$Date <- as.Date(completeData$Date, format="%d/%m/%Y")
##create the subset of the completeData
data <- subset(completeData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
##remove complete data from memory as it is not required for further task
rm(completeData)
##combine date and time column
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)
## plot a scatterplot with type line
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
##store the plot to a png file
dev.copy(png, file = "plot2.png", height=480, width=480)
dev.off()
