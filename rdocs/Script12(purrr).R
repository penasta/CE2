
# ---------------------------------------------------------------------------- #

# Pacotes

if (!require("pacman")) install.packages("pacman")
p_load(tidyverse) #dplyr, purrr

# ---------------------------------------------------------------------------- #

 # Listas

a_list <- list(num=c(8,9),
               log=TRUE,
               cha=c("a","b","c"))

a_list["num"]
a_list[["num"]]

class(a_list["num"])
class(a_list[["num"]])

typeof(a_list["num"])
typeof(a_list[["num"]])

# ---------------------------------------------------------------------------- #

set.seed(150167636)
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

?apply

apply(df,2,mean)

#col_summary(df,mean)

df_list  <- as.list(df)
apply(df_list,median)
lapply(df_list,median)
lapply(df,mean,na.rm=T)
lapply(df_list,mean,na.rm=T)

lapply(df,median)
sapply(df,median)

# ---------------------------------------------------------------------------- #

# Família map
# pacote purrr

# map() makes a list.
# map_lgl() 
# map_dbl()
# ...

map(df,median)
map_dbl(df,median)
map_dbl(df,sd)
map_dbl(df,mean,na.rm=T)

# rm(list = ls())

# ---------------------------------------------------------------------------- #