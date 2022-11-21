# --------------------------------------------------------------------------- #

# Iniciando o projeto ----

# --------------------------------------------------------------------------- #

# Carregando alguns pacotes para iniciar ----

if (!require("pacman")) install.packages("pacman")
p_load(tidyverse,nycflights13)

# --------------------------------------------------------------------------- #

# PRIMEIRA PARTE: Brincando com o banco do nycflights13 ----

# --------------------------------------------------------------------------- #

# Carregando o banco de dados ----

# p_load(vroom)
# df <- vroom("bancos/pew.csv")

flights <- flights

# --------------------------------------------------------------------------- #

# Brincando com o banco ----
# Estudando proporção de voos atrasados. ----

flights %>%
  mutate(delayed = arr_delay > 0) %>%
  select(arr_delay,delayed)

TRUE + 0

# Uma forma:

atrasados <- flights %>%
  mutate(delayed = arr_delay > 0) %>%
  select(arr_delay,delayed) %>%
  drop_na() %>%
  tally(delayed == TRUE)

atrasados/nrow(drop_na(flights))

# Outra forma:

flights %>%
  mutate(delayed = arr_delay > 0) %>%
  select(arr_delay,delayed) %>%
  filter(arr_delay != c(TRUE,FALSE)) %>%
#  tally(delayed == TRUE)
  summarise(mean(delayed))

# --------------------------------------------------------------------------- #

# SEGUNDA PARTE: Alguns exercícios aleatórios antes... ---- 

# --------------------------------------------------------------------------- #

string1  <- "tris is a string"
string1

"teste"

backslash <- "\\"
writeLines(backslash)

# quiz: write http:\\

teste <- "http:\\\\"
writeLines(teste)

teste2 <- "\"http:\\\\\""
writeLines(teste2)

pessoas <- c(" Rafael", " Andre", " Mateus")
n <- length(pessoas)
birthday <- c(T,F,F)
for (i in 1:n){
  
  print(str_c("Good Morning", pessoas[i],
              if(birthday[i]) " and happy birthday", "!"))
  
}


# --------------------------------------------------------------------------- #

# TERCEIRA PARTE: Brincando com o banco babynames ----

# --------------------------------------------------------------------------- #

# Proporção de crianças cujo nome termina com vogais + y, nos sexos masculino e feminino, por ano ----

p_load(babynames)

babynames %>%
  mutate(last = str_sub(name, -1),
         vowel = last %in% c('a','e','i','o','u','y')) %>%
  group_by(year, sex) %>%
  summarise(p_vowel = weighted.mean(vowel,n)) %>%
  ggplot(aes(year,p_vowel,color=sex)) +
  geom_line()

# rm(list = ls())
# dev.off()