## NOTES ON COLUMN NAMES ##

# usg_apt = U.S gate airport
# fg_apt = Foreign gate airport
# usg_wac = US gateway world area code rep as a geo territory

library(tidyverse)
library(corrplot)

setwd("~/Air Traffic")

departure <- read.csv("International_Report_Departures.csv")
passengers <- read.csv("International_Report_Passengers.csv")
# Quick look at data types
glimpse(departure)
glimpse(passenger)
# Transform data on dates into Date format from character format
departure <- transform(departure, data_dte = as.Date(data_dte,format = "%Y/%m/%d"))
passengers <- transform(passengers, data_dte = as.Date(data_dte,format = "%m/%d/%Y"))
# Checking to see if there is any missing data
departure %>% 
  count(is.na(departure))
sum(is.na(departure))
passengers %>% 
  count(is.na(passengers))
sum(is.na(passengers))
# There is no NA data
# Change Months from numeric representation to names
departure$Month[which(departure$Month==1)] <- "January"
departure$Month[which(departure$Month==2)] <- "February"
departure$Month[which(departure$Month==3)] <- "March"
departure$Month[which(departure$Month==4)] <- "April"
departure$Month[which(departure$Month==5)] <- "May"
departure$Month[which(departure$Month==6)] <- "June"
departure$Month[which(departure$Month==7)] <- "July"
departure$Month[which(departure$Month==8)] <- "August"
departure$Month[which(departure$Month==9)] <- "September"
departure$Month[which(departure$Month==10)] <- "October"
departure$Month[which(departure$Month==11)] <- "November"
departure$Month[which(departure$Month==12)] <- "December"

passengers$Month[which(passengers$Month==1)] <- "January"
passengers$Month[which(passengers$Month==2)] <- "February"
passengers$Month[which(passengers$Month==3)] <- "March"
passengers$Month[which(passengers$Month==4)] <- "April"
passengers$Month[which(passengers$Month==5)] <- "May"
passengers$Month[which(passengers$Month==6)] <- "June"
passengers$Month[which(passengers$Month==7)] <- "July"
passengers$Month[which(passengers$Month==8)] <- "August"
passengers$Month[which(passengers$Month==9)] <- "September"
passengers$Month[which(passengers$Month==10)] <- "October"
passengers$Month[which(passengers$Month==11)] <- "November"
passengers$Month[which(passengers$Month==12)] <- "December"

write.csv(departure, "departure.csv")
write.csv(passengers, "passengers.csv")
# Drop Columns with char data for a correlation matrix (must ignore date format)
departure[ ,c('data_dte','usg_apt','fg_apt','carrier','type')] <- list(NULL)
passengers[ ,c('data_dte','usg_apt','fg_apt','carrier','type')] <- list(NULL)

cor(departure$Month, departure$Total, method = "pearson")
# Creates a quick corr matrix in global envir
departure.cor = cor(departure, method = c("spearman"))
corrplot(departure.cor, method = "color")

passengers.cor = cor(passengers, method = c("spearman"))
corrplot(passengers.cor, method = "circle", order = "AOE")



































