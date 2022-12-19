if (!require("pacman")) install.packages("pacman")

# -------------------------------- Funções ---------------------------------- #

# Exemplo:
funcao <- function(x) {
  y = x * 2
  print(y)
}

funcao(2)
funcao(1:5)
funcao(c(1,3,5))

rescale01 <- function(x){
  rng <- range(x,na.rm=T)
  (x-rng[1]/(rng[2]-rng[1]))
}

rescale01(c(1,2,3,NA,5))

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
  )

rescale01(df$a)
funcao(df$a)

# Criar uma função que calcula a variância
# Teste tosco: Deu errado kkkk
x <- df$a
for (i in 1:x){
var = sum((x[i]-mean(x))^2)/length(x)
print(var)
}

# --------------------------------------------------------------------------- #

