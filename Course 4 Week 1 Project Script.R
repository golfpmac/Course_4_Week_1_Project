require(sqldf)
library(sqldf)
require(naniar)
library(naniar)

filename = "C:\\Users\\Patrick\\datasciencecoursera\\Course 4\\household_power_consumption.txt"
fi = file(filename)

df = sqldf("select * from fi where Date = '1/2/2007' or Date = '2/2/2007'", 
           file.format = list(header = TRUE, sep = ";"))

close(fi)

# df %>% replace_with_na_all(condition = ~.x == "?")

df$Date = as.Date(df$Date, "%d/%m/%y")

df$DateTime = with(df, paste(Date, Time))
df = df[, -c(1:2)]

df$DateTime = strptime(df$DateTime, "%Y-%m-%d %H:%M:%S")

