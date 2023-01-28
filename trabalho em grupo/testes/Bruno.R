
# ---------------------------------------------------------------------------- #

# CE2
# Grupo 2
# Webscrapping
# membros:

# ---------------------------------------------------------------------------- #

if (!require("pacman")) install.packages("pacman")
pacman::p_load(xml2,rvest,tidyverse)

# ---------------------------------------------------------------------------- #

# Exemplo simples:

link_site <- "https://everynoise.com"
page <- read_html(link_site)

estilos <- page %>% 
  html_nodes(".scanme") %>%
  html_text()

estilos

# ---------------------------------------------------------------------------- #

# Exemplo problemático:

link_site <- "https://www.amazon.com.br/s?k=televisao&__mk_pt_BR=ÅMÅŽÕÑ&crid=2HKSX4UZ7J7QF&sprefix=televisao%2Caps%2C282&ref=nb_sb_noss_1"
page <- read_html(link_site)

# E agora?

url = "https://www.amazon.com.br/s?k=televisao&__mk_pt_BR=ÅMÅŽÕÑ&crid=2HKSX4UZ7J7QF&sprefix=televisao%2Caps%2C282&ref=nb_sb_noss_1"
download.file(url,
              destfile = "scrapedpage.html",
              quiet=TRUE)
content <- read_html("scrapedpage.html")


# E aí?

p_load(curl)
read_html(curl('https://www.amazon.com.br/s?k=televisao&__mk_pt_BR=ÅMÅŽÕÑ&crid=2HKSX4UZ7J7QF&sprefix=televisao%2Caps%2C282&ref=nb_sb_noss_1',
               handle = curl::new_handle("useragent" = "Mozilla/5.0")))

# F

# ---------------------------------------------------------------------------- #

# Exemplo prático:

link_site <- "https://www.escavador.com/sobre/3499832/thais-carvalho-valadares-rodrigues"
page <- read_html(link_site)

nome <- page %>% 
  html_nodes(".name") %>%
  html_text()

nome

descricao <- page %>% 
  html_nodes("#usuario .-flushHorizontal p") %>%
  html_text()

titulos <- page %>% 
  html_nodes(".inline-edit-item-formacao") %>%
  html_text()

descricao_titulos <- page %>% 
  html_nodes(".inline-edit-item-ano-fim+ p") %>%
  html_text()

# Arrumando o texto utilizando o pacote stringr (expressões regulares)
descricao_titulos <- str_replace_all(descricao_titulos, "[\\n]"," ")
descricao_titulos <- str_remove(descricao_titulos, "  ")

data_titulos <- page %>% 
  html_nodes(".inline-edit-item-formacao+ .inline-edit-item") %>%
  html_text()

# Criando um data frame com a formacao
formacao <- data.frame(titulos,data_titulos,descricao_titulos)


idiomas <- page %>% 
  html_nodes("#idiomas .-likeH5") %>%
  html_text()
idiomas <- str_remove(idiomas, " ")

proeficiencia <- page %>% 
  html_nodes("#idiomas .-likeH5+ p") %>%
  html_text()
proeficiencia <- str_replace_all(proeficiencia, "[\\n]","")

# Criando um data frame com os idiomas

linguas <- data.frame(idiomas,proeficiencia)

# Criando uma lista com todas as informações coletadas

lista <- list(descricao,formacao,linguas)
assign(nome,lista)

# Com isso, criamos uma lista com o nome do professor,
# que contém 3 objetos: o primeiro, uma string com a descrição;
# o segundo, um data frame com a formação
# e o terceiro, um data frame com os idiomas.

# rm(list = ls())

# ---------------------------------------------------------------------------- #