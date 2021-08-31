 # Google Course R Programming Section #

install.packages("palmerpenguins")
library(palmerpenguins)

# two data sets one: penguins, and two: penguins_raw

View(penguins)

install.packages("tidyverse")
library(tidyverse)
library(lubridate)


ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(aes(color=species, shape=species))

## Cleaning Data ##
skim_without_charts(penguins) # is an easy way to look at a summary
glimpse(penguins) # even shorter look at data
head(penguins) # preview of column names and first few rows

penguins %>% 
  select(species)

penguins %>%  # rename will change the name of a column header
  rename(island_new = island)

rename_with(penguins,tolower) # makes change to all column names to lower case or toupper to upper case

clean_names(penguins) # to make sure there are no bad characters

## Organizing Data ##
penguins %>% 
  arrange(bill_length_mm) # arrange will sort (use - before column name for desc)

penguins2 <- penguins %>% 
  arrange(-bill_length_mm)

View(penguins2)

penguins %>% 
  group_by(island) %>% # group by a column specification
  drop_na() %>% # to drop rows with NA *use caution*
  summarize(mean_bill_length_mm = mean(bill_length_mm))# to get a summary

penguins %>% 
  group_by(species,island) %>%
  drop_na() %>% 
  summarize(mean_bl = mean(bill_length_mm), max_bl = max(bill_length_mm))

penguins %>% 
  filter(species == "Adelie")

## Transforming Data ##
id <- c(1:10)
name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")
job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")
employee <- data.frame(id, name, job_title)

print(employee)

separate(employee, name, into=c('first_name','last_nama'), sep='')

## pivot_longer and pivot_wider to change from Wide data to Long data





























