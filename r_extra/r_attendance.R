#-------------------------------------------------------#
#  Purpose:     attendance cleaning                     #
#  Date:        2024SEP01                               #
#  Data Source: data/raw/                               #
#  Author:      Ben Fanson                              #
#  Company:     ARI                                     #
#-------------------------------------------------------#


#--- initializing global variables ---#
  library(tidyverse)

  ds <- readxl::read_excel('data/Attendance list.xlsx', skip=4)[,1:5] %>% 
           select(name=1, day1=2, day2=3, day3=4, day4=5) %>% 
           pivot_longer( cols=starts_with('day'), names_to='day', values_to='status'  ) %>% 
            filter( status == 'Accepted' ) %>% distinct()
  n_distinct(ds$name)
  group_by(ds, day) %>% summarise( n_people = n() )
  
# 18-26 across days
# 31 unique people
  