if (!require("pacman")) install.packages("pacman")
#p_load(tidyverse)

# ---------------------------------------------------------------------------- #

# descubra quantas tentativas em média leva pra sacar três caras em seq.;
flip <- function() sample(c("T","H"),1,prob=c(.8,.2))

flips <- 0 #Contador do n. de rep. do exp.
nheads <- 0 #Contador do n. de caras em seq.

while (nheads <3){
  if (flip() == "H"){
    nheads <- nheads + 1
  } else {
    nheads <- 0
  }
  flips <- flips + 1
}
flips

# Simulação
nvezes <- 1000 # Nº de pessoas que vão realizar o exp.
flips2 <- numeric(nvezes)
for(j in 1:nvezes){ #nº de rep. do exp. com sucesso
  flips <- 0 # contador do n. de vezes(jogar moeda p cima)
  nheads <- 0 # contador no n. de caras em seq.
  while(nheads < 3){
    if (flip() == "H"){
      nheads <- nheads + 1
    }else{
      nheads <- 0
    }
    flips <- flips + 1
  }
  flips2[j] <- flips
  print(j)
}
flips2
median(flips2)
mean(flips2)
var(flips2)
sd(flips2)

# Queremos estimar o nº médio de tentativas p/ ocorrer 3 caras em sequência
# Estimar média (parâmetro conhecido mu)
# melhor estimador: [pontual]:    x barra
#                   [intervalar]: x barra +- z[alpha/2] * sigma (S p/ amostra) / sqrt(n)
#                                 = t(alpha/2) * S/sqrt(n); t student c/ n-1 g.l.
#                                 -> n > 30, t ~ N
#                                 (n crescendo -> x barra +- ~0 = x barra)

# ---------------------------------------------------------------------------- #

#rm(list = ls())

# ---------------------------------------------------------------------------- #

