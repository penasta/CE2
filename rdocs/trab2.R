# ---------------------------------------------------------------------------- #

#       _    _       ____  
#     | |  | |     |  _ \ 
#    | |  | |_ __ | |_) |
#   | |  | | '_ \|  _ < 
#  | |__| | | | | |_) |
#  \____/|_| |_|____/ 
#  
#

# ---------------------------------------------------------------------------- #

# 0.1 - Do Autor ----
#
# Universidade de Brasília - UnB
# Departamento de Estatística
# Computação em Estatística 2
# Profª. Drª. Thais Rodrigues
# Trabalho 2
# Bruno Gondim Toledo
# Brasília, fevereiro de 2023
# Github do projeto: https://github.com/penasta/CE2
# E-mail do autor: bruno.gondim@aluno.unb.br

# ---------------------------------------------------------------------------- #

if (!require("pacman")) install.packages("pacman")
p_load(tidyverse)

# ---------------------------------------------------------------------------- #

# Questão 1) Com base no banco de dados nycflights13::flights, execute os comandos a seguir, a fim de transformar o banco de dados em uma lista por companhia aerea (carrier), e responda os itens abaixo utilizando a lista banco e as funcionalidades do pacote purr. banco <- nycflights13::flights %>% split(.$carrier) ----

banco <- nycflights13::flights %>% split(.$carrier)


# a) A partir da lista banco, selecione as colunas que contém a palavra ‘delay’ para cada companhia aerea (carrier). Retorne o resultado como uma lista. ----

lista <- banco %>%
  map(~select(.x, contains("delay")))

# ---------------------------------------------------------------------------- #

# b) A partir da lista obtida na letra A, calcule a média dos atrasos de chegada e de saída para cada companhia aerea (carrier). Retorne o resultado como um dataframe. ----

dataframe <- lista %>%
  map_dfr(~ data.frame(
    mean_dep_delay  = mean(.x$dep_delay,na.rm = T),
    mean_arr_delay = mean(.x$arr_delay,na.rm = T))
    )

# ---------------------------------------------------------------------------- #

# c) Crie uma função para repetir a tarefa da letra B, mas permita ao usuário escolher a operação que será efetuada nas colunas (média, mínimo, summary, etc . . . ). Permita ao usuário escolher se na.rm = T/F. Retorne o resultado como uma lista. ----

funcao <- function(operacao=mean,na=T){
  lista2 <- lista %>%
  map(~list(mean_dep_delay  = operacao(.x$dep_delay,na.rm = na),
        mean_arr_delay = operacao(.x$arr_delay,na.rm = na)))
  return(lista2)
}

funcao()

funcao(operacao=mean,na=T)
funcao(operacao=min,na=T)
funcao(operacao=summary,na=T)

funcao(operacao=mean,na=F)
funcao(operacao=min,na=F)
funcao(operacao=summary,na=F)

# ---------------------------------------------------------------------------- #

# d) A partir da lista inicial banco, faça um boxplot da coluna ‘arr_delay’ para cada companhia aérea (utilize as funções map e boxplot). ----

lista3 <- banco %>%
  map(~select(.x, contains("arr_delay"))) %>%
  map(~boxplot(.))

# ---------------------------------------------------------------------------- #

# e) Note que, além do gráfico, a função boxplot retorna uma série de informações relevantes. Com base nisso, retorne quantos outliers na variável ‘arr_delay’ cada companhia aérea registrou. Retorne o resultado como um vetor ----


outliers <- lista3 %>%
  map(~.$out) %>%
  map(as.data.frame)

quantidade_outliers <- outliers %>%
  map_int(nrow) %>%
  unlist()

# apesar de não ser ~exatamente~ um vetor ("vetor nomeado"), a função
# abaixo confirma que supostamente ao menos é um vetor :)
is.vector(quantidade_outliers)

# ---------------------------------------------------------------------------- #

# Questão 2) Construa uma função para calcular as raízes de um polinômio de grau 3. Caso hajam duas raízes iguais, lançar uma mensagem de aviso para notificar o usuário. Permita ao usuário a opção de que o grafico da função seja construído e as raízes identificadas. Use o elemento ... para dar ao usuário controle dos parâmetros do gráfico. Por fim, teste sua função com alguns exemplos interessantes. ----
p_load(pracma)
p_load(signal)

pol3 <- function(a,b,c,d,grafico=T,resultado=T, ...){
  raizes <- roots(c(a,b,c,d))
  if (grafico==T & resultado==T){
    x <- seq(-10,10,length=200)
    plot(x,polyval(poly(raizes),x), ...)
    return(raizes)
  }
  else if (grafico==T & resultado==F){
    x <- seq(-10,10,length=200)
    plot(x,polyval(poly(raizes),x), ...)
  }
  else if(grafico==F & resultado==T){
    return(raizes)
  }
  else {
    return("Girafas são criaturas sem coração")
  }
}

pol3(1,1,1,1)

pol3(1,1,1,1,grafico =T ,resultado =T )
pol3(1,1,1,1,grafico =T ,resultado =F )
pol3(1,1,1,1,grafico =F ,resultado =T )
pol3(1,1,1,1,grafico =F ,resultado =F )

pol3(1,1,1,1, type='l')

pol3(1,16,1,1)

pol3(1,5,1,1,grafico=F)

pol3(11,16,14,12, type='l',lwd='2')

# ---------------------------------------------------------------------------- #

# Questão 3) Com relação ao tópico do trabalho final do seu grupo, escreva sobre a utilidade do tema e explique 1 função interessante do pacote utilizado. ----

# Essa parte vou colocar direto e somente no markdown, por ser basicamente descritiva.

# ---------------------------------------------------------------------------- #
