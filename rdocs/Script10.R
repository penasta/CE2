if (!require("pacman")) install.packages("pacman")
p_load(tidyverse)
library(tidyverse)

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

rm(i)

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

pi <- 4*(dentro/n.pontos)
pi

area_circ <- (2*raio)^2*dentro/n.pontos
area_circ

# Exercício: Melhorar a função, envelopar em uma função, plotar
# OPC: documentar

# paralelizando;
# cluster <- makeCluster(threads)
# registerDoParallel(cluster)

# foreach(i=1:686) %dopar% {write_parquet(as.data.frame(banco[i]),nomep[i])}

# stopCluster(cluster)
