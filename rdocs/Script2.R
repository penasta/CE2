# --------------------------- Arrumando o banco Titanic --------------------- #

# Iniciando o projeto ----

# Carregando alguns pacotes para iniciar ----

if (!require("pacman")) install.packages("pacman")
p_load(nycflights13,tidyverse)

# Carregando o banco de dados ----

p_load(vroom)
titanic <- vroom("bancos/Dados/titanic2.csv")

titanic <- titanic %>%
  melt(id = c('class','age','fate')
       , variable.name='sex',na.rm=TRUE
  )

titanic <- titanic %>%
  dcast(class+age+sex+value~fate,
        value.var='value'
  )

titanic$rate <- round(titanic$survived/(titanic$survived + titanic$perished),2)

# Arrumar essas porcarias

# --------------------------------------------------------------------------- #

# Joins c/ banco bby names

# --------------------------------------------------------------------------- #

births <- vroom("bancos/Dados/births.csv")

bnames <- vroom("bancos/Dados/bnames.csv")

bebes <- left_join(births,bnames)

bebes <- bebes %>%
  mutate(quantidade = round(prop*births)) %>%
  drop_na()

# --------------------------------------------------------------------------- #
