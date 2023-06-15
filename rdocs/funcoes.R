dobras <- function(k) {
  if(is.numeric(k)){
  if(floor(k) == k){
  if(k == 0){
    print("Altura: 0.0001 metros")
  }
  else if(k < 0){
    print("Insira um valor maior ou igual a zero")
  }
  else{
  numero_folhas <- 1  # Valor inicial
  altura_papel <- 0.0001  # Altura de uma folha em metros
  altura <- 0  # Altura total da pilha
  
  for (i in 1:k) {
    numero_folhas <- numero_folhas * 2
    altura <- numero_folhas * altura_papel
  }
  
  resultado <- paste("Altura:", altura, "metros")
  
  if (altura > 384400000) {
    resultado <- paste("O papel chegou a lua! ", resultado)
  } else if (altura > 40075000) {
    resultado <- paste("O papel é maior que a circunferência da terra! ", resultado)
  } else if (altura > 203000) {
    resultado <- paste("O papel é maior que a distância de Brasília à Goiânia", resultado)
  }
  
  return(resultado)
  } 
  }else {print("Insira um valor inteiro")}
  }else {print("Insira somente um número inteiro maior ou igual a zero")}
  }

dobras("texto")

dobras(1.5)

dobras(-1)

dobras(0)

dobras(1)

dobras(10)

dobras(20)

dobras(30)

dobras(31)

dobras(39)

dobras(42)

















media_tempo <- function(){
  media_chegadas <- 2
  max_carros <- 80
  minutos <- 0
  n_carros <- 0
while (n_carros < max_carros) {
  chegadas <- rpois(1, media_chegadas)
  n_carros <- n_carros + chegadas
  minutos <- minutos + 1
}
  return(cat("O estacionamento lotou em", minutos, "minutos."))}
media_tempo()






tempo_ate_queimar <- function() {
  tempo_medio_vida <- 1000
  tempo <- 0
  queimou <- FALSE
  
  while (!queimou) {
    tempo_passado <- rexp(1, rate = 1 / tempo_medio_vida)
    tempo <- tempo + tempo_passado
    
    if (tempo >= tempo_medio_vida) {
      queimou <- TRUE
    }
  }
  
  return(tempo)
}
tempo_ate_queimar()


rexp(1, rate = 1/1000)







lancamentos_ate_10_caras <- function() {
  num_caras_desejadas <- 10
  num_lancamentos <- 0
  num_caras_observadas <- 0
  
  while (num_caras_observadas < num_caras_desejadas) {
    lancamentos <- rbinom(1, 1, 0.5)
    num_lancamentos <- num_lancamentos + 1
    
    if (lancamentos == 1) {
      num_caras_observadas <- num_caras_observadas + 1
    }
  }
  
  return(num_lancamentos)
}

lancamentos_ate_10_caras()







duracao_botijao_gas <- function() {
  duracao <- 0
  botijao_vazio <- FALSE
  media <- 100
  
  while (!botijao_vazio) {
    tempo_passado <- rexp(1, rate = 1/media)
    duracao <- duracao + tempo_passado
    
    if (duracao >= media) {
      botijao_vazio <- TRUE
    }
  }
  
  return(duracao)
}

duracao_botijao_gas()