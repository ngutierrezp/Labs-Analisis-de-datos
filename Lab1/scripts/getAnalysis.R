
#Función que agrega una fila de Na's igual 0 en caso de ser necesario
#Esto debido a que summary no siempre entrega esta fila. 
my_summary <- function(v){
  if(!any(is.na(v))){
    res <- c(summary(v),"NA's"=0)
  } else{
    res <- summary(v)
  }
  return(res)
}

getAnalysis <- function(numerical.df){
  
  #Se obtienen la varianza de los datos
  var.age <- var(numerical.df$age,na.rm = TRUE)
  var.trestbps <- var(numerical.df$trestbps, na.rm = TRUE)
  var.chol <- var(numerical.df$chol,na.rm = TRUE)
  var.thalach <- var(numerical.df$thalach, na.rm = TRUE)
  var.oldpeak <- var(numerical.df$oldpeak, na.rm = TRUE)
  var.ca <- var(numerical.df$ca, na.rm = TRUE)
  
  #Se obtiene la desviación estandar de cada dato
  sd.age <- sd(numerical.df$age,na.rm = TRUE)
  sd.trestbps <- sd(numerical.df$trestbps, na.rm = TRUE)
  sd.chol <- sd(numerical.df$chol,na.rm = TRUE)
  sd.thalach <- sd(numerical.df$thalach, na.rm = TRUE)
  sd.oldpeak <- sd(numerical.df$oldpeak, na.rm = TRUE)
  sd.ca <- sd(numerical.df$ca, na.rm = TRUE)
  
  #Se crea una lista con los datos para cada atributo
  data.age <- c(my_summary(numerical.df$age),"var"=var.age,"sd"=sd.age)
  data.trestbps <- c(my_summary(numerical.df$trestbps),"var"=var.trestbps,"sd"=sd.trestbps)
  data.chol <- c(my_summary(numerical.df$chol),"var"=var.chol,"sd"=sd.chol)
  data.thalach <- c(my_summary(numerical.df$thalach),"var"=var.thalach,"sd"=sd.thalach)
  data.oldpeak <- c(my_summary(numerical.df$oldpeak),"var"=var.oldpeak,"sd"=sd.oldpeak)
  data.ca <- c(my_summary(numerical.df$ca),"var"=var.ca,"sd"=sd.ca)
  
  #Se crea el dataframe para todos los datos
  df <- data.frame(age = data.age,
                   trestbos = data.trestbps,
                   chol = data.chol,
                   thalach = data.thalach,
                   oldpeak = data.oldpeak,
                   ca = data.ca
                   )

  
  return(df)
}



