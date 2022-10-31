# Iniciando o projeto ----

# Carregando alguns pacotes para iniciar ----

if (!require("pacman")) install.packages("pacman")
p_load(nycflights13,tidyverse)

# Carregando o banco de dados ----

p_load(vroom)
df <- vroom("bancos/pew.csv")
df$religion <- factor(df$religion)

# Transformando o banco de dados para o formato tidy ----

# Usando a função melt do pacote reshape2 ----

p_load(reshape2)
tidy <- melt(df,id='religion')

# Outra forma... (pivot_longer, do pacote tidyr) ----

dftidy <- df %>%
  pivot_longer(!religion)

# Carregando o segundo banco de dados ----

df2 <- vroom("bancos/weather.txt", na='.')
df2$year <- factor(df2$year)
df2$month <- factor(df2$month)
df2$element <- factor(df2$element)

# Arrumando o segundo banco de dados ----

tidy2 <- df2 %>%
  melt(id = c('year','month','element')
       , variable.name='day',na.rm=TRUE
       )

# Arrumando a coluna element com a função dcast ----

tidy2 <- tidy2 %>%
  dcast(year+month+day~element,
        value.var='value'
        )

# Outra forma.. (usando a função pivot_wider) ----
# (...)

# ---------------------------------------------------------------------------- #



# ---------------------------------------------------------------------------- #
# rm(list = ls())