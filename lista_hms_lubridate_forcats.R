library(pacman)
p_load(tidyverse,lubridate,hms,forcats)

uber <- read_csv("C:/Users/toled/Desktop/archive (2)/rideshare_kaggle.csv")

uber$cab_type <- factor(uber$cab_type)
uber$name <- factor(uber$name)
uber$short_summary <- factor(uber$short_summary)

uber <- uber %>% select(6, 8, 9, 10, 12, 13, 14, 18, 20) %>%
  filter(cab_type == "Uber") %>%
  select(!cab_type)

uber$temperature <- round((uber$temperature - 32) * (5/9),1)

uber$destination <- factor(uber$destination)
uber$source <- factor(uber$source)

colnames(uber) <- c("Data e hora","Origem","Destino","Tipo","Preço","Distância",
                    "Temperatura","Clima")

write_rds(uber,"uber.rds")





# ---------------------------------------------------------------------------- #

# q1) 

# a) Obtenha o dia da semana de cada corrida .Se preferir, separe a coluna de data e hora em duas para facilitar a manipulação. DICA: utilize a função tidyr::separate()

uber <- separate(uber, col = `Data e hora`, into = c("data", "hora"), sep = " ")

uber$mes <- month(uber$data,label=T,abbr=F)
#uber$dia <- day(uber$data)
uber$dsemana <- wday(uber$data, label=T,abbr=F)

# b) Faça a contagem do número de viagens por dia da semana.

# Uma forma:
sort(table(uber$dsemana), decreasing = TRUE)

# Outra forma:
uber %>%
  select(dsemana) %>%
  group_by(dsemana) %>%
  tally()

# c) Obtenha o preço médio da corrida e a temperatura média para cada dia da semana

uber %>%
  select(dsemana, Temperatura, Preço) %>%
  group_by(dsemana) %>%
  na.omit() %>%
  summarise(temperatura_media = mean(Temperatura),
            preço_media = mean(Preço))


# q2)

# a) Utilizando as funções dos pacotes hms e lubridate, obtenha a contagem de corridas pela hora do dia.

uber$hora <- as_hms(uber$hora)
uber$h <- paste0(hour(uber$hora),"h")
uber$h <- factor(uber$h)

uber %>%
  select(h) %>%
  group_by(h) %>%
  tally() %>%
  print(n=24)

# b) Com os resultados obtidos da questão anterior e utilizando as funções do pacote forcats, plote um gráfico da contagem de viagens por hora do dia, ordenando da hora com maior contagem observada para a com menor contagem observada.

uber %>%
  mutate(h = fct_infreq(h)) %>%
  ggplot(aes(x = h)) + 
  geom_bar()



# 3)

# a) Considerando "Manhã" como os horários entre 1 e 11h, "tarde" como os horários entre 12 e 17h, e noite como 18 a 0, obtenha a contagem de corridas por cada periodo do dia.

uber <- uber %>%
  mutate(periodo = case_when(
    hour(as_hms(hora)) < 12 ~ "manhã",
    hour(as_hms(hora)) < 18 ~ "tarde",
    TRUE ~ "noite"
  )) 

uber %>%
  mutate(periodo = case_when(
    hour(as_hms(hora)) < 12 ~ "manhã",
    hour(as_hms(hora)) < 18 ~ "tarde",
    TRUE ~ "noite"
  )) %>%
  select(periodo) %>%
  group_by(periodo) %>%
  tally()

# b) Com os resultados obtidos da questão anterior e utilizando as funções do pacote forcats, plote um gráfico da contagem de viagens por periodo do dia, ordenando do período com maior contagem para o período com menor contagem. 
# Você esperava obter estes resultados após observar os resultados obtidos na questão 2.b ?

uber %>%
  mutate(periodo = fct_infreq(periodo)) %>%
  ggplot(aes(x = periodo)) + 
  geom_bar()


# c) Obtenha o preço e a distância média das viagens em cada turno do dia. Para estes dados, o turno do dia aparenta influenciar o preço médio e a distância média das viagens?

uber %>%
  select(Preço, Distância, periodo) %>%
  group_by(periodo) %>%
  na.omit() %>%
  summarise(pmedio = mean(Preço),dmedia = mean(Distância))
