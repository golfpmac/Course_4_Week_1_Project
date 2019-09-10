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

#create plot & save to png file
png("plot2.png", width = 480, height = 480, units = "px")
plot(df$DateTime, df$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts", xlab = "")
dev.off()
