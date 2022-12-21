if (!require("pacman")) install.packages("pacman")

# ---------------------------- Funções - Aula 2 ----------------------------- #

x <- c(T,T)
y <- c(F,F)

x|y
x&y

x||y
x&&y

x <- T
y <- F

x|y
x&y

x||y
x&&y

# --------------------------------------------------------------------------- #

p_load(tidyverse)
rm(list = ls())

y <- 2
z <- sqrt(2)^2
typeof(y)
typeof(z)
y
z
y==z
near(y,z)
?near

# --------------------------------------------------------------------------- #
p_load(lubridate)
now()
?now()

meet <- function(x=now()){
  if (is.numeric(x)==F)
    x <- hour(x)
  if (x < 18L & x >= 12L)
    print("Boa tarde")
  else if (x >= 6L & x < 12L)
    print("Bom dia")
  else if (x >=18L & x <= 24L)
    print("Boa noite")
  else if (x >= 1L & x < 6L)
    print("Boa madrugada")
  else
    print("A entrada deve ser um único inteiro: Alguma hora do dia!")
  
}

meet()
meet(2)
meet(7)
meet(15)
meet(20)
meet(25)

# --------------------------------------------------------------------------- #