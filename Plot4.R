require(sqldf)
library(sqldf)

#loads file path and filename
filename = paste("C:\\Users\\Patrick\\datasciencecoursera\\Course 4\\household",
    "_power_consumption.txt", sep = "")
fi = file(filename)

#loads file into dataframe.  Used SQL to limit rows loaded to necessary dates
df = sqldf("select * from fi where Date = '1/2/2007' or Date = '2/2/2007'", 
           file.format = list(header = TRUE, sep = ";"))

#Close SQL connection
close(fi)

#Combine Date & time into one field
df$DateTime = with(df, paste(Date, Time))
df = df[, -c(1:2)]

#convert DateTime from char
df$DateTime = strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

#Open PNG 
png("plot4.png", width = 480, height = 480, units = "px")

#Setup layout
par(mfcol = c(2,2))
with(df, {
    #create plot 1,1
    plot(DateTime, Global_active_power, type = "l", 
         ylab = "Global Active Power (kilowatts", xlab = "")
    #crease plot 2,1
    plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", 
         xlab = "")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lwd = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    #crease plot 1,2
    plot(DateTime, Voltage, type = "l", 
         ylab = "Voltage")
    #crease plot 2,2
    plot(DateTime, Global_reactive_power, type = "l")
})

#close PNG
dev.off()
