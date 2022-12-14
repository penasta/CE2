if (!require("pacman")) install.packages("pacman")
p_load(tidyverse,lubridate,nycflights13,hms)
# updater()

# ---------------------------------- HMS ------------------------------------ #

flights %>%
  ggplot(mapping=aes(x=sched_dep_time,y=arr_delay)) +
#  geom_point(alpha=.2) +
  geom_smooth()

hms(56,34,12)

# C/ erro na função hms()
flights %>%
  ggplot(mapping=aes(x=hms(sched_dep_time),y=hms(arr_delay))) +
  #  geom_point(alpha=.2) +
  geom_smooth()

# ------------------------------- Lubridate --------------------------------- #

wday(dmy("11/10/2023"),label=T) 

flights %>%
  mutate(weekday = wday(time_hour,label=T,abbr=F)) %>%
  group_by(weekday) %>%
  drop_na(arr_delay) %>%
  summarise(avg_delay = mean(arr_delay)) %>%
  ggplot() +
  geom_col(mapping = aes(x=weekday,y=avg_delay))

# --------------------------------------------------------------------------- #
