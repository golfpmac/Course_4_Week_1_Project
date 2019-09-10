require(sqldf)
library(sqldf)

#loads file path and filename
filename = "C:\\Users\\Patrick\\datasciencecoursera\\Course 4\\household_power_consumption.txt"
fi = file(filename)

#loads file into dataframe.  Used SQL to limit rows loaded to necessary dates
df = sqldf("select * from fi where Date = '1/2/2007' or Date = '2/2/2007'", 
           file.format = list(header = TRUE, sep = ";"))

#Close SQL connection
close(fi)

#df$Date = as.Date(df$Date, "%d/%m/%y")

#Combine Date & time into one field
df$DateTime = with(df, paste(Date, Time))
df = df[, -c(1:2)]

#convert DateTime from char
df$DateTime = strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")

#create histogram plot
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts", ylab = "Frequency")