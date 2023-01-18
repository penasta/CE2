library(pacman)
p_load(xml2)
p_load(rvest)
p_load(tidyverse)


#


link_site <- "https://doink.com.br/1080-cateters"
page <- read_html(link_site)

nome <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

nome

#

"https://doink.com.br/1080-cateters"
"https://doink.com.br/1049-tintas?q=Marca-Easy+Glow"
"https://doink.com.br/1049-tintas?q=Marca-Easy+Glow&page=2"

link_site <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow"
page <- read_html(link_site)

nome_tinta <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

marca_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(1)") %>%
  html_text() 

tamanho_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(2)") %>%
  html_text() 

cor_tinta <- page %>%
  html_nodes(".list-style-disk li~ li+ li") %>%
  html_text()

valor_tinta <- page %>%
  html_nodes("#our_price_display") %>%
  html_text2()

link_tinta <- page %>%
  html_nodes(".product-title a") %>%
  html_attr("href")

get_ref <- function(link_tinta){
  
  pagina_tinta <- read_html(link_tinta)
  ref <- pagina_tinta %>%
    html_nodes(".col-auto") %>%
    html_text2()
  
}

referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)

tintas <- data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia)

# Agora, aplicando para todas as páginas

tintas_todas <- data.frame()

proximo_link <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow"

for (pagina in 1:5){
  
  page <- read_html(proximo_link)
  
  nome_tinta <- page %>% 
    html_nodes(".product-title") %>%
    html_text()
  
  marca_tinta <- page %>%
    html_nodes(".list-style-disk li:nth-child(1)") %>%
    html_text() 
  
  tamanho_tinta <- page %>%
    html_nodes(".list-style-disk li:nth-child(2)") %>%
    html_text() 
  
  cor_tinta <- page %>%
    html_nodes(".list-style-disk li~ li+ li") %>%
    html_text()
  
  valor_tinta <- page %>%
    html_nodes("#our_price_display") %>%
    html_text2()
  
  link_tinta <- page %>%
    html_nodes(".product-title a") %>%
    html_attr("href")
  
  referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)
  
  proximo_link <- page %>%
    html_nodes(".next") %>%
    html_attr("href")
  
  tintas_todas <- rbind(tintas_todas,data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia))
  
}

#### Dando problema

# indo uma por uma:

# pagina 2
link2 <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow&page=2"

page <- read_html(link2)

nome_tinta <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

marca_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(1)") %>%
  html_text() 

tamanho_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(2)") %>%
  html_text() 

cor_tinta <- page %>%
  html_nodes(".list-style-disk li~ li+ li") %>%
  html_text()

valor_tinta <- page %>%
  html_nodes("#our_price_display") %>%
  html_text2()

link_tinta <- page %>%
  html_nodes(".product-title a") %>%
  html_attr("href")

referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)

tintas2 <- data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia)

# pagina 3 ** daqui para baixo precisou de ajustes manuais **

link3 <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow&page=3"

page <- read_html(link3)

nome_tinta <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

marca_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(1)") %>%
  html_text() 

tamanho_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(2)") %>%
  html_text() 

cor_tinta <- page %>%
  html_nodes(".list-style-disk li~ li+ li") %>%
  html_text()

valor_tinta <- page %>%
  html_nodes("#our_price_display , .not-available") %>%
  html_text2()

link_tinta <- page %>%
  html_nodes(".product-title a") %>%
  html_attr("href")

referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)

tintas3 <- data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia)

# pagina 4

link4 <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow&page=4"

page <- read_html(link4)

nome_tinta <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

marca_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(1)") %>%
  html_text() 

tamanho_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(2)") %>%
  html_text() 

cor_tinta <- page %>%
  html_nodes(".list-style-disk li~ li+ li") %>%
  html_text()

valor_tinta <- page %>%
  html_nodes("#our_price_display , .not-available") %>%
  html_text2()

link_tinta <- page %>%
  html_nodes(".product-title a") %>%
  html_attr("href")

referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)

tintas4 <- data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia)

# pagina 5 

link5 <- "https://doink.com.br/1049-tintas?q=Marca-Easy+Glow&page=5"

page <- read_html(link5)

nome_tinta <- page %>% 
  html_nodes(".product-title") %>%
  html_text()

marca_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(1)") %>%
  html_text() 

tamanho_tinta <- page %>%
  html_nodes(".list-style-disk li:nth-child(2)") %>%
  html_text() 

cor_tinta <- page %>%
  html_nodes(".list-style-disk li~ li+ li") %>%
  html_text()

valor_tinta <- page %>%
  html_nodes(".not-available") %>%
  html_text2()

link_tinta <- page %>%
  html_nodes(".product-title a") %>%
  html_attr("href")

referencia <- sapply(link_tinta,FUN = get_ref,USE.NAMES=FALSE)

tintas5 <- data.frame(nome_tinta,marca_tinta,tamanho_tinta,cor_tinta,valor_tinta,referencia)

rm(tintas_todas)

tintas_todas <- rbind(tintas,tintas2,tintas3,tintas4,tintas5)

p_load(xlsx)

colnames(tintas_todas) <- c("Nome da tinta","Marca","Tamanho","Cor","Valor","Código de referência")

write.xlsx(tintas_todas, "tintas.xlsx")
