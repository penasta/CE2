if (!require("pacman")) install.packages("pacman")
p_load(tidyverse)

x <- -2:2
x
y <- ifelse(x>0,x^2,-x^2)
y

x <- -1:1
for(i in 1:length(x)){
  if (x[i]>0){
    print(x[i]^2)
  }else{
    print(-x[i]^2)
  }
}
rm(i)

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

median(df$a)
median(df$b)
median(df$c)
median(df$d)

# Loop For
output <- list()
#output <- vector("double",ncol(df))
for(i in 1:ncol(df)){
  output[[i]] <- median(df[[i]])
}
output <- unlist(output)
output

# Outra forma
output <- list()
#output <- vector("double",ncol(df))
for(i in 1:seq_along(df)){ # ta com algum erro no seq_along
  output[[i]] <- median(df[[i]])
}
output <- unlist(output)
output

rm(list = ls())
# Calculando a área de um círculo

#buffon.needle()

# Monte carlo:
n.pontos <- 1000000
raio <- 1
dentro <- 0 #Contador de pontos dentro do círculo

for (i in 1:n.pontos){
  x <- runif(1,-1,1)
  y <- runif(1,-1,1)
  if (x^2+y^2<raio^2){
    dentro <- dentro + 1
  } 
}


area_circ <- (2*raio)^2*dentro/n.pontos
area_circ

# rm(list = ls())

# Tentando melhorar
# 1ºs objetivos: Eliminar o loop ineficiente e desnecessário, plotar os pontos.
# também, a função deve retornar o valor da área, juntamente ao gráfico
p_load(ggforce)

circulo <- function(n.pontos=100,raio=1){
  x <- runif(n.pontos,-1,1)
  y <- runif(n.pontos,-1,1)
  dentro <- x^2+y^2<raio^2
  coordenadas <- as_tibble(t(rbind(x,y,dentro)))
  grafico <- ggplot(data=coordenadas,aes(x=x,y=y)) +
    geom_rect(xmin=-raio,xmax=raio, ymin=-raio,ymax=raio,alpha=0.1,fill='pink') +
    geom_circle(aes(x0=0,y0=0,r=raio),fill='lightblue',alpha=0.02) +
    geom_point()
  area <- (2*raio)^2*sum(coordenadas$dentro)/n.pontos
  return(list(area,grafico))
  }

circulo()
# Funciona, porém está bem lenta para n grande

# Melhorando a velocidade da plotagem com a função `geom_scattermore`. Por ser escrita em C, promete ser bem mais rápida.
# além disso, retornando o tibble com as coordenadas dos pontos.
p_load(scattermore)

circulo2 <- function(n.pontos=100,raio=1){
  x <- runif(n.pontos,-1,1)
  y <- runif(n.pontos,-1,1)
  dentro <- x^2+y^2<raio^2
  coordenadas <- as_tibble(t(rbind(x,y,dentro)))
  assign("coordenadas", coordenadas, envir = .GlobalEnv) 
  grafico <- ggplot(data=coordenadas,aes(x=x,y=y)) +
    geom_rect(xmin=-raio,xmax=raio, ymin=-raio,ymax=raio,alpha=0.1,fill='pink') +
    geom_circle(aes(x0=0,y0=0,r=raio),fill='lightblue',alpha=0.02) +
    geom_scattermore(pointsize=1) +
    coord_fixed()
  area <- (2*raio)^2*sum(coordenadas$dentro)/n.pontos
  return(list(area,grafico))
}

circulo2(500,1)

# Agora, pedi ao ChatGPT para otimizar a minha função. Este foi o resultado:

circuloGPT <- function(n.pontos=100,raio=1){
  theta <- runif(n.pontos,0,2*pi)
  r <- sqrt(runif(n.pontos))*raio
  x <- r * cos(theta)
  y <- r * sin(theta)
  
  coordenadas <- tibble(x=x,y=y)
  area <- pi*raio^2
  
  grafico <- plot(x, y, xlim = c(-raio, raio), ylim = c(-raio, raio), main = "Gráfico gerado pela função", xlab = "Eixo X", ylab = "Eixo Y")
  
  return(list(area,grafico))
}
circuloGPT(1000,1)
# --------------------------------------------------------------------------- #

# Testes

n.pontos<-10000
raio<-1
x <- runif(n.pontos,-1,1)
y <- runif(n.pontos,-1,1)
dentro <- x^2+y^2<raio^2
coordenadas <- as_tibble(t(rbind(x,y,dentro)))
grafico <- ggplot(data=coordenadas,aes(x=x,y=y)) +
#  geom_rect(xmin=-raio,xmax=raio, ymin=-raio,ymax=raio,alpha=0.1,fill='pink') +
#  geom_circle(aes(x0=0,y0=0,r=raio),fill='lightblue',alpha=0.02) +
  geom_scattermore(pointsize=1)
grafico
area <- (2*raio)^2*sum(coordenadas$dentro)/n.pontos

