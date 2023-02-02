# ---------------------------------------------------------------------------- #

if (!require("pacman")) install.packages("pacman")
p_load(tidyverse)

# ---------------------------------------------------------------------------- #

# Dados:
p_load(repurrrsive)
lista <- sw_people

# ---------------------------------------------------------------------------- #
# Minha tentativa:
names <- sapply(sw_people, `[[`, "name")
height <- sapply(sw_people, `[[`, "height")

df <- data.frame(names,height) |>
  filter(names %in% c("Anakin Skywalker","Darth Vader"))

# ---------------------------------------------------------------------------- #
# Gabarito:
which(sw_people %>% map_chr(pluck,'name') %in% c("Darth Vader","Anakin Skywalker"))
(sw_people %>% map_chr(pluck,'height'))[c(4,11)]

# ---------------------------------------------------------------------------- #
# Banco de dados p/ próximos exercícios
set.seed(1000)
exams <- list(
  student1 = round(runif(10, 50, 100)),
  student2 = round(runif(10, 50, 100)),
  student3 = round(runif(10, 50, 100)),
  student4 = round(runif(10, 50, 100)),
  student5 = round(runif(10, 50, 100))
)

# ---------------------------------------------------------------------------- #
# Exemplos:
exams |>
  mean()

exams |>
  map(mean)

exams |>
  map_dbl(mean)

fun1 <- function(x) length(x)==10

exams |> map(fun1)
map_lgl(exams,fun1)
fun1(exams[[1]])
fun1(exams[[2]])
fun1(exams[[3]])

map_lgl(exams, function(y) length(y)==10)
# Equivalente a:
map_lgl(exams,~length(.)==10)
# mais simples, porém menos legível também !!!!!

# Outro exemplo:
fun2 <- function(x) (sum(x)-min(x))/9
exams |> map_dbl(fun2)
exams |> map_dbl(~(sum(.)-min(.))/9)
exams|>map_dbl(~(sum(.)-min(.))/9)

# outro exemplo:
exams |> map_dbl(~mean(.[.!=min(.)]))
# simpels de digitar, praticamente impossível de ler.

add_1<-function(x) x+1
add_1(1)

# Outro exemplo

exams |>
  map(summary) |>
  map_dbl(~.['Median'])
exams |> map_dbl(quantile,prob=.5)

# map2 [funções com 2 argumentos]

# pmap [funções com p listas de entrada]

# purrr

# ---------------------------------------------------------------------------- #

# Lista de exercícios

# ---------------------------------------------------------------------------- #

#rm(list = ls())