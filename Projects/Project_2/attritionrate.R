# Call up packages
library(tidyverse)
library(lubridate)
library(e1071)
library(ggplot2)
library(cowplot)
library(caTools)
library(lubridate)
library(ROCR)
library(ROSE)
library(Hmisc)
# Set the working directory
setwd("~/HR Retention Analysis")
# read the csv's
emp_survey <- read.csv("employee_survey_data.csv")
general <- read.csv("general_data.csv")
intime <- read.csv("in_time.csv")
manager_survey <- read.csv("manager_survey_data.csv")
outtime <- read.csv("out_time.csv")
# Quick look at general data
glimpse(general)
# Add the EmployeeID to in-times and out-times
colnames(intime)[1] <- "EmployeeID"
colnames(outtime)[1] <- "EmployeeID"
# setdiff indicates which elements of a vector or data frame X
# are not existent in a vector or data frame Y
setdiff(general$EmployeeID,emp_survey$EmployeeID)  
setdiff(general$EmployeeID,manager_survey$EmployeeID)
setdiff(general$EmployeeID,intime$EmployeeID)   
setdiff(general$EmployeeID,outtime$EmployeeID)   

emp_id<-intime[1]
intime <- as.data.frame(lapply(intime[, -1], as.POSIXlt))
outtime <- as.data.frame(lapply(outtime[, -1], as.POSIXlt))


setdiff(colnames(intime), colnames(outtime))

log_hours <- outtime-intime
log_hours <- as.data.frame(lapply(log_hours, round, digits=2))

log_hours <- log_hours[,colSums(is.na(log_hours))<nrow(log_hours)]
log_hours <- cbind(emp_id,log_hours)

log_hours<- as.data.frame(sapply(log_hours, as.numeric))
# Change num data to char
general$Education[which(general$Education==1)] <- 'Below College'
general$Education[which(general$Education==2)] <- 'College'
general$Education[which(general$Education==3)] <- 'Bachelor'
general$Education[which(general$Education==4)] <- 'Master'
general$Education[which(general$Education==5)] <- 'Doctor'
emp_survey$JobSatisfaction[which(emp_survey$JobSatisfaction==1)] <- 'Low'
emp_survey$JobSatisfaction[which(emp_survey$JobSatisfaction==2)] <- 'Medium'
emp_survey$JobSatisfaction[which(emp_survey$JobSatisfaction==3)] <- 'High'
emp_survey$JobSatisfaction[which(emp_survey$JobSatisfaction==4)] <- 'Very High'
manager_survey$JobInvolvement[which(manager_survey$JobInvolvement==1)] <- 'Low'
manager_survey$JobInvolvement[which(manager_survey$JobInvolvement==2)] <- 'Medium'
manager_survey$JobInvolvement[which(manager_survey$JobInvolvement==3)] <- 'High'
manager_survey$JobInvolvement[which(manager_survey$JobInvolvement==4)] <- 'Very High'
manager_survey$PerformanceRating[which(manager_survey$PerformanceRating==1)] <- 'Low'
manager_survey$PerformanceRating[which(manager_survey$PerformanceRating==2)] <- 'Good'
manager_survey$PerformanceRating[which(manager_survey$PerformanceRating==3)] <- 'Excellent'
manager_survey$PerformanceRating[which(manager_survey$PerformanceRating==4)] <- 'Outstanding'
# Inner Join two data sets to make easy use of Viz
ijoin <- general %>% 
  inner_join(manager_survey, by = "EmployeeID")
#We see there is a huge imbalance which could be due to under-sampling
ijoin %>% 
  count(Attrition)
#Ovun.sample creates possibly balances samples by random under-sampling examples
#ijoin <- ovun.sample(Attrition ~ ., data = ijoin, method = "under", N = 1500, seed = 1)$data
#ijoin %>% 
 # count(Attrition)

ggplot(general) +
  geom_bar(mapping = aes(x = Age)) +
  facet_wrap(~YearsAtCompany) +
  labs(title = "Age Distribution for each Year at Company", 
       subtitle = "Each year is counted independently",
       caption = "40 is the longest held employee")

ggplot(general) +
 geom_bar(mapping = aes(x = Age, fill = Gender)) +
  facet_wrap(Education~Gender) +
  labs(title = "Age Distribution by Gender and Level of Education",
       subtitle = "18 to 60 years old")

general %>% 
  count(Gender) %>% 
  mutate(Gender = n/sum(n))

ggplot(general) +
  geom_bar(mapping = aes(x = Gender, fill = Gender)) +
  labs(title = "Ratio of Male to Female Workers") +
  annotate("text", x = "Female", y = 1000, label = "1764(40%)")+
  annotate("text", x = "Male", y = 1000, label = "2546(60%)")
 
ggplot(ijoin, aes(x = JobInvolvment, y = Frequency, fill = Attrition, label = Frequency)) +
  geom_bar(stat = "identity") +
  geom_text(size = 3, position = postion_stack(vjust = 0.5))
         

ggplot(ijoin) +
  geom_bar(mapping = aes(x = PerformanceRating, fill = Attrition))
  
ggplot(ijoin) +
  geom_bar(mapping = aes(x = JobRole, fill = Attrition))  
  
ggplot(ijoin) +
  geom_bar(mapping = aes(x = Department, fill = Attrition))

write.csv(ijoin, "hrdata.csv")
write.csv(log_hours, "log_hours.csv")
write.csv(emp_survey, "emp_survey_1.csv")

































































