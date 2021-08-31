data("ToothGrowth")
View(ToothGrowth)

filtered_tg <- filter(ToothGrowth, dose==0.5)
View(filtered_tg)

arrange(filtered_tg, len)

# Now we will arrange with a nested function
arrange(filter(ToothGrowth, dose==0.5), len)

# Now we will use a Pipe (ctrl + shift + m is the shortcut for %>%)
filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  arrange(len)
filtered_toothgrowth

filtered_toothgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  group_by(supp) %>% 
  summarize(mean_len = mean(len,na.rm = T), .group="drop")
filtered_toothgrowth