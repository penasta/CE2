
# -------------------------------------------------------------------------- #
# Minha versão:
library(tidyverse)
{
  {
    n_figurinha <- data.frame(1:633)
    colnames(n_figurinha) <- 'n_figurinha'
    figurinhas <- n_figurinha
    rm(n_figurinha)
    
    prob <-1/633
    figurinhas$prob <- NA
    for (i in 1:length(figurinhas$prob)) {
      figurinhas$prob[i] <- prob
    }
    rm(i,prob)
  }
  
  pacote <- sample_n(figurinhas, size=5,replace = TRUE)
  album <- pacote # O mínimo necessário são 127 pacotes para completar o album
  gasto <- 4
  
  for (i in 1:126){
    pacote <- sample_n(figurinhas, size=5,replace = TRUE)
    album <- rbind(album,pacote)
    i = i + 1
    gasto <- gasto + 4
  }
  
  rm(i)
  descarte <- 0
  descarte <- descarte + length(which(duplicated(album)))
  album <- unique(album)
  
  while(nrow(album) < 633){
    pacote <- sample_n(figurinhas, size=5,replace = TRUE)
    album <- rbind(album,pacote)
    descarte <- descarte + length(which(duplicated(album)))
    album <- unique(album)
    gasto <- gasto + 4
  }

}

#rm(list = ls())

# -------------------------------------------------------------------------- #
# Versão da professora:
{
  
  n.figurinhas <- 633
  n.pacote <- 5
  probabilidades <- rep(1/n.figurinhas, n.figurinhas)

  resultado <- matrix(0,nr = n.simulacoes, nc = n.figurinhas)
  gastos <- numeric(n.simulacoes)
  for(i in 1:n.simulacoes){
    faltantes <- n.figurinhas

   while(faltantes>0){
     pacote.aux <- sample(1:n.figurinhas,n.pacote,replace=T,prob=probabilidades)
      resultado[1, pacote.aux] <- resultado[1, pacote.aux] +1
      faltantes <- sum(resultado[1,]==0)
  }
  n.pacotes.comprados <- sum(resultado[i,]/n.pacote)

}}
#rm(list = ls())

# -------------------------------------------------------------------------- #

# Comparando funções com microbenchmark:
library(pacman)
p_load(microbenchmark)

mbm <- microbenchmark(
  {
    {
      n_figurinha <- data.frame(1:633)
      colnames(n_figurinha) <- 'n_figurinha'
      figurinhas <- n_figurinha
      rm(n_figurinha)
      
      prob <-1/633
      figurinhas$prob <- NA
      for (i in 1:length(figurinhas$prob)) {
        figurinhas$prob[i] <- prob
      }
      rm(i,prob)
    }
    
    #sum(figurinhas$prob)
    
    pacote <- sample_n(figurinhas, size=5,replace = TRUE)
    album <- pacote # O mínimo necessário são 127 pacotes para completar o album
    gasto <- 4
    
    for (i in 1:126){
      pacote <- sample_n(figurinhas, size=5,replace = TRUE)
      album <- rbind(album,pacote)
      i = i + 1
      gasto <- gasto + 4
    }
    rm(i)
    
    descarte <- 0
    descarte <- descarte + length(which(duplicated(album)))
    album <- unique(album)
    
    while(nrow(album) < 633)
    {
      pacote <- sample_n(figurinhas, size=5,replace = TRUE)
      album <- rbind(album,pacote)
      descarte <- descarte + length(which(duplicated(album)))
      album <- unique(album)
      gasto <- gasto + 4
    }
  },
  {
    
    n.figurinhas <- 633
    n.pacote <- 5
    probabilidades <- rep(1/n.figurinhas, n.figurinhas)
    
    resultado <- matrix(0,nr = 1, nc = n.figurinhas)
    faltantes <- n.figurinhas
    
    while(faltantes>0){
      pacote.aux <- sample(1:n.figurinhas,n.pacote,replace=T,prob=probabilidades)
      resultado[1, pacote.aux] <- resultado[1, pacote.aux] +1
      faltantes <- sum(resultado[1,]==0)
    }
    
  },
  times=5
)

autoplot(mbm)

# -------------------------------------------------------------------------- #