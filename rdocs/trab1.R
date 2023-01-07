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
# Trabalho 1
# Bruno Gondim Toledo
# Brasília, janeiro de 2023
# Github do projeto: https://github.com/penasta/CE2
# E-mail do autor: bruno.gondim@aluno.unb.br

# ---------------------------------------------------------------------------- #

# 0.2 - Do software ----
#
# linguagem de programação utilizada: R (versão 4.2.2).
# IDE utilizada: RStudio Desktop 022.12.0+353
# Pacotes R utilizados (em ordem de utilização no código): 
# pacman,doParallel,vroom,tidyverse,stringi,hms,lubridate,nycflights13,babynames.
#
if (!require("pacman")) install.packages("pacman")
# p_load(installr)
# updateR()
# Irei utilizar o pacote pacman para instalar e carregar os pacotes no
# decorrer do código.
# Optarei por fazer o carregamento dos pacotes no decorrer do código, conforme
# a necessidade. Com isso, viso deixar mais claro a partir de qual etapa é
# necessário cada um dos pacotes utilizados.

# ---------------------------------------------------------------------------- #

# 0.3: Do hardware ----
#
# Meu default nos comandos que explicitarei o número de thread à serem 
# utilizadas, caso existam, será 80% das threads disponíveis, arredondado. 
# Caso queira utilizar um número diferente de threads, basta alterar o comando
# abaixo conforme conveniência.
#
p_load(doParallel)
threads=round(as.numeric(detectCores()*0.8))
#
# Especificações da máquina utilizada para fazer e rodar o código:
#
# Lenovo Ideapad 3
# Windows 11
# CPU AMD Ryzen 7 5700u (16 threads)
# RAM 20(16 + 4)GB DDR4 3200 Mhz
# GPU AMD Radeon Vega 8 (Integrada)
# 256 GB SSD M.2 2242 PCIe NVMe

# ---------------------------------------------------------------------------- #

# 0.4: O projeto ----
#
#Instruções
#1)Escreva seu código com esmero, evitando operações redundantes, comentando os resultados e usando asmelhores práticas em programação. Utilize os pacotes estudados em sala. Caso algum tópico não tenha sidoabordado, pesquise sobre o assunto para responder a questão.
#2)O aluno deve enviar 1 arquivo pdf contendoambos: o código utilizado para realizar cada questão eo resultado obtido (ou as primeiras linhas do resultado obtido, caso o resultado seja muito extenso), depreferência, utilizem o Rmarkdown.
#3)Além disso, o aluno deve enviar outro arquivo com o código desenvolvido (arquivo .R).
#4)Os arquivos devem ser enviados pelo Teams até 23h59, 08/01/2023 (domingo).
#5)O trabalho é individual! Respostas semelhantes serão penalizadas severamente.
#Exercícios
#A base de dados apresentada no link a seguir contém avaliações de consumidores a produtosadquiridos no site Americanas.com entre Janeiro e Maio de 2018. Importe o banco de dadospara o R e responda as seguintes perguntas:
#  https://raw.githubusercontent.com/americanas-tech/b2w-reviews01/main/B2W-Reviews01.csv
#
#1)Para os 10 produtos mais comprados nesse período, retorne uma tabela contendo: nome do produto,número de compradores para cada sexo e nota média do produto por sexo. (1 ponto)
#2)Escreva uma função para fazer uma limpeza no texto de 1 review: transformação do texto em minúsculae retirada de todos os sinais de pontuação, caracteres especiais e acentos. Teste para vários reviews ofuncionamento da função criada. (2 pontos)
#3)Utilizando apenas a informação contida na variávelproduct_name, retorne uma tabela com todas astelevisões compradas no período (1 compra por linha) e o número de polegadas correspondente da TV. Emseguida, retorne outra tabela contendo o total de TVs compradas de cada polegada. (1.5 pontos)
#4)Transforme a variávelreviewer_stateem categórica e faça um gráfico do número de compras por Estado daFederação. Em seguida, faça um gráfico do número de compras por Regiões do Brasil (Norte, Sul, Nordeste,Centro-Oeste e Sudeste). (1.5 pontos)
#5)Considere apenas a informação da hora do dia em que a compra foi realizada. Faça um gráfico do númerode compras em cada hora. (1 ponto)
#6)Acrescente 1 coluna no banco de dados com a informação da data da compra no seguinte formato, exemplo:11 de Janeiro, 2018. (1 ponto)
#
#A questão a seguir não se refere a base de dados das compras no site Americanas.com.
#7)Crie uma função para reordenar as linhas de um dataframe de modo que as linhas que contenhamobservações indisponíveis (NAs) sejam colocadas no final. Dê ao usuário a opção de eliminar as linhas comobservações faltantes. Use a função para retornar uma lista com o dataframe reordenado (ou reduzido) e osíndices das linhas com NAs. Por fim, teste sua função com alguns exemplos interessantes. (2 pontos)


# ---------------------------------------------------------------------------- #

# 0.5) Baixando e carregando o banco de dados ----

pasta <- "dados"

if (file.exists(pasta)) {
  
  print("A pasta já existe")
  rm(pasta)
  
} else {
  
  dir.create(pasta)
  rm(pasta)
  
}

link <- c("https://raw.githubusercontent.com/americanas-tech/b2w-reviews01/main/B2W-Reviews01.csv")
nome_destino <- c("./dados/df.csv")
download.file(link, nome_destino)

rm(link,nome_destino,pasta)

p_load(vroom)

df <- vroom("./dados/df.csv", 
               locale = locale("br", encoding = "UTF-8"),
               num_threads = threads)

# ---------------------------------------------------------------------------- #

# 1) Para os 10 produtos mais comprados nesse período, retorne uma tabela contendo: nome do produto,número de compradores para cada sexo e nota média do produto por sexo. ----
p_load(tidyverse)

dados <- df %>%
  select(product_id,product_name,overall_rating,reviewer_gender) %>%
  mutate(product_id = factor(product_id)) %>%
  mutate(product_name = factor(product_name)) %>%
  mutate(reviewer_gender = factor(reviewer_gender))

filtro <- dados %>%
  count(product_id,sort=T) %>%
  head(n=10L) %>%
  select(product_id)

dados <- semi_join(dados, filtro)

tabela1 <- dados %>%
  select(product_name,overall_rating,reviewer_gender) %>%
  group_by(product_name,reviewer_gender) %>%
  summarise(nota_media = mean(overall_rating)) %>%
  drop_na(reviewer_gender)

tabela2 <- dados %>%
  select(product_name,reviewer_gender) %>%
  group_by(product_name,reviewer_gender) %>%
  count(reviewer_gender) %>%
  drop_na(reviewer_gender)

tabela_questao1 <- full_join(tabela1,tabela2)

rm(filtro,tabela1,tabela2,dados)

colnames(tabela_questao1) <- c("nome do produto","sexo do comprador","nota média do produto","número de compradores")

# ---------------------------------------------------------------------------- #

# 2) Escreva uma função para fazer uma limpeza no texto de 1 review: transformação do texto em minúsculae retirada de todos os sinais de pontuação, caracteres especiais e acentos. Teste para vários reviews ofuncionamento da função criada. ----
p_load(stringi)

emburrecer <- function(x=1){
df %>%
  select(review_text) %>%
  sample_n(size=x) %>%
  str_to_lower() %>%
  stri_trans_general("Latin-ASCII") %>%
  str_replace_all(pattern="[ç]", replacement="c") %>%
  str_replace_all(pattern="[!@#$%¨&*()?;:.\'\",\\|\\-/]", replacement=" ")
}

emburrecer()

# ---------------------------------------------------------------------------- #

# 3) Utilizando apenas a informação contida na variávelproduct_name, retorne uma tabela com todas astelevisões compradas no período (1 compra por linha) e o número de polegadas correspondente da TV. Emseguida, retorne outra tabela contendo o total de TVs compradas de cada polegada. ----

#dados <- df %>%
#  select(product_name) %>%
#  filter(product_name == str_subset(product_name,pattern="TV"))

#dados <- dados %>%
#  filter(product_name == str_subset(product_name,pattern="Smartphone",negate=F))

# percebi que estavam vindo smartphones também 
# por algum motivo o pipe está engolindo diversas informações. Farei linha a linha, portanto.
  
dados <- as_tibble(str_subset(df$product_name,pattern="Smart TV",negate=F))
# Removendo outros produtos com o padrão no nome
dados <- as_tibble(str_subset(dados$value,pattern="Acessório",negate=T))
dados <- as_tibble(str_subset(dados$value,pattern="Suporte",negate=T))

dados$polegadas <- as_tibble(str_extract(dados$value, "[0-9]+"))

colnames(dados) <- c("Televisão","Polegadas")
tabela1_questao3 <- dados
rm(dados)

tabela1_questao3$Polegadas <- as.numeric(unlist(tabela1_questao3$Polegadas))

tabela2_questao3 <- tabela1_questao3 %>%
  select(Polegadas) %>%
  group_by(Polegadas) %>%
  drop_na() %>%
  filter(Polegadas > 5) %>%
  tally()

colnames(tabela2_questao3) <- c("Polegadas","Quantidade vendida")

# ---------------------------------------------------------------------------- #

# 4) Transforme a variável reviewer_state em categórica e faça um gráfico do número de compras por Estado da Federação. Em seguida, faça um gráfico do número de compras por Regiões do Brasil (Norte, Sul, Nordeste,Centro-Oeste e Sudeste). ----

dados <- df %>%
  select(reviewer_state) %>%
  drop_na()

dados$reviewer_state <- factor(dados$reviewer_state)  

comprasregiao <- dados
rm(dados)

ggplot(comprasregiao) +
  aes(x=reviewer_state) +
  geom_bar(colour="#A11D21",fill="#A11D21") +
  labs(x="Unidade Federativa", y="Quantidade de compras")

# levels(comprasregiao$reviewer_state)

comprasregiao <- comprasregiao %>%
  mutate(regiao = case_when(
    
    reviewer_state == "AC" | reviewer_state == "AM" | reviewer_state == "AP" |
    reviewer_state == "PA" | reviewer_state == "RO" | reviewer_state == "RR" |
    reviewer_state == "TO" ~ "Norte",
    
    reviewer_state == "AL" | reviewer_state == "BA" | reviewer_state == "CE" |
    reviewer_state == "MA" | reviewer_state == "PI" | reviewer_state == "PE" |
    reviewer_state == "PB" | reviewer_state == "RN" | 
    reviewer_state == "SE" ~ "Nordeste",
    
    reviewer_state == "GO" | reviewer_state == "MT" | reviewer_state == "MS" | 
    reviewer_state == "DF" ~ "Centro-Oeste",
    
    reviewer_state == "ES" | reviewer_state == "MG" | reviewer_state == "RJ" |
    reviewer_state == "SP" ~ "Sudeste",
    
    reviewer_state == "PR" | reviewer_state == "RS" | 
    reviewer_state == "SC" ~ "Sul"
    
    ))

ggplot(comprasregiao) +
  aes(x=regiao) +
  geom_bar(colour="#A11D21",fill="#A11D21") +
  labs(x="Região", y="Quantidade de compras")

# ---------------------------------------------------------------------------- #

# 5) Considere apenas a informação da hora do dia em que a compra foi realizada. Faça um gráfico do número de compras em cada hora. ----
p_load(hms)

dados <- df %>%
  select(submission_date) %>%
  mutate(hora = as_hms(submission_date))

comprahora <- dados %>%
  select(hora)
rm(dados)  

comprahora$hora <- substr(comprahora$hora, start = 1, stop = 2)
comprahora$hora <- factor(comprahora$hora)

ggplot(comprahora) +
  aes(x=hora) +
  geom_bar(colour="#A11D21",fill="#A11D21") +
  labs(x="Hora do dia", y="Quantidade de compras")

# ---------------------------------------------------------------------------- #

# 6) Acrescente 1 coluna no banco de dados com a informação da data da compra no seguinte formato, exemplo:11 de Janeiro, 2018. ----
p_load(lubridate)

dados <- df %>%
  select(submission_date)

dados$submission_date[1] # 10 primeiros caracteres
dados$submission_date <- substr(dados$submission_date, start = 1, stop = 10)
dados$submission_date <- ymd(dados$submission_date)

data <- dados %>%
  mutate(mes = format(submission_date, "%B")) %>%
  mutate(dia = day(submission_date)) %>%
  mutate(ano = year(submission_date))

rm(dados)

data <- data %>%
  mutate(data = str_glue('{dia} de {mes},{ano}')) %>%
  select(data)

df <- cbind(df,data)

# ---------------------------------------------------------------------------- #

# 7) Crie uma função para reordenar as linhas de um dataframe de modo que as linhas que contenham observações indisponíveis (NAs) sejam colocadas no final. Dê ao usuário a opção de eliminar as linhas com observações faltantes. Use a função para retornar uma lista com o dataframe reordenado (ou reduzido) e os índices das linhas com NAs. Por fim, teste sua função com alguns exemplos interessantes. ----

ordenar <- function(df, rna = F) {
  df$soma <- rowSums(is.na(df))
  
  df <- df %>%
    arrange(soma)
  df$soma <- NULL
  
  if (rna) {
    df <- df %>%
      filter(rowSums(is.na(df)) == 0)
  }
  
  return(list(df = df, linhas_na = which(rowSums(is.na(df)) > 0)))
  
}

# Testando no DF utilizado nos exercícios; após, testando em alguns dos DF de treino mais comumente utilizados por usuários de R...

# data()

ordenar(df=as_tibble(df))
ordenar(df=as_tibble(df), rna=T)

ordenar(df=as.data.frame(Titanic))
ordenar(df=as.data.frame(Titanic), rna=T)

ordenar(df=lakers)
ordenar(df=lakers, rna=T)

ordenar(df=mtcars)
ordenar(df=mtcars, rna=T)

ordenar(df=iris)
ordenar(df=iris, rna=T)

p_load(nycflights13)

ordenar(df=flights)
ordenar(df=flights, rna=T)

p_load(babynames)

ordenar(df=babynames)
ordenar(df=babynames, rna=T)

ordenar(df=mpg)
ordenar(df=mpg, rna=T)

ordenar(df=diamonds)
ordenar(df=diamonds, rna=T)

# A maioria não tem valores NA, mas funcionou com os que tinha...

# ---------------------------------------------------------------------------- #


