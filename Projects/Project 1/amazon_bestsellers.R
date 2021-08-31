library(tidyverse)

setwd("~/Amazon Bestseller")

books <- read.csv("bestsellers with categories.csv")

glimpse(books)
# Check if there is any missing data
sum(is.na(books))
# We are looking for occurances of duplicates
n_occur <- data.frame(table(books$Name))
n_occur[n_occur$Freq > 1,]
# Adding a unique identifier
books2 <- tibble::rowid_to_column(books, "ID")
# Removing Year as it is not necessary for all analysis
books2 <- subset(books2, select = -Year)
# Removing trailing white space which causes inaccuracy
str_squish(books2$Author)
books2$Author <- str_trim(books2$Author)
books2$Name <- str_trim(books2$Name)

write_csv(books2, "amazon_bestsellers.csv")
