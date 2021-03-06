
normalThalach <- function(df,output){
  
  age <- df[1]
  sex <- df[2]
  thalach <- df[8]
  
  normal <- 220 - age
  if (sex == 0 ) {
    normal <- normal + 6
  }
  
  if (is.na(thalach)) {
    return(NA)
  }
  else if ( thalach > normal ){
    return("anormal")
  }else{
    return("normal")
  }
}





discretize.Data <- function(df) {
  
  # AGE
  # Debido a que la edad se comporta de forma normal.
  # se puede hacer la divisi�n en dos proporciones similares.
  # A partir de los 54 a�os, que es la mediana 
  # OA = Old Adult = [54, Max Age]
  # OA = Old Adult = [Min Age, 53]
  
  age <- ifelse(df$age >= 54, "OA","YA")
  
  
  
  # SEX ya esta en forma binaria
  sex <- df$sex
  
  
  # CP tiene valores discretos [1,2,3,4]
  cp <- df$cp
  
  
  # TRESTBPS
  # indica la presion arterial en reposo.
  # este valor es normal si esta dentro de [120-129]
  # un valor mayor a 129 pasaria a una Hipertensi�n
  # por lo tanto esta variable nos puede indicar si una persona
  # es HIPERTENSA O NO.
  
  trestbps <- ifelse(df$trestbps >= 129, "hiper","normal")
  
  
  # CHOL
  # Indica el nivel de colesterol. 
  # Un colesterol es saludable es condicerado hasta los 200 mg/dL
  # por lo tanto eata variable pasaria a ser si una persona tiene 
  # un colesterol saludable o no. 
  
  chol <- ifelse(df$chol >= 200, "healthy","no healthy")
  
  
  
  
  # FBS ya es binario
  fbs <- df$fbs
  
  
  # RESTECG ya esta discretizada en 3 valores [0,1,2]
  restecg <- df$restecg
  
  # THALACH
  # indica la frecuencia maxima de una persona, sin embargo este valor
  # depende de la edad y del sexo de la parsona. Entre muchas otras variables
  
  thalach <- apply(df,1,normalThalach)
  
  # EXANG ya es binaria
  exang <- df$exang
  
  
  #OLDPEAK
  #Debido a que este variable tiene un significado netamente medico,
  # no se puede hacer una clasificaci�n de forma aproximada.
  # por lo que se limitar� a decir si este variable tiene
  # un alto o bajo valor
  
  oldpeak <- ifelse(df$oldpeak >= mean(na.omit(df$oldpeak)), "high", "low")
  
  
  #SLOPE ya esta discretizado en valores [1,2,3]
  
  slope <- df$slope
  
  #CA ya esta discretizado en valores [0,1,2,3]
  
  ca <- df$ca
  
  #THAL ya est� discretizada en valores [3,6,7]
  thal <- df$thal
  
  
  #NUM <- clase
  
  num <- df$num
  
  discre <- cbind(age,sex,cp,trestbps,chol,fbs,restecg,thalach,exang,oldpeak,slope,ca,thal,num)
  
  discre.df <- as.data.frame(discre)
  discre.df$age <- as.factor( discre.df$age)
  discre.df$sex <- as.factor( discre.df$sex)
  discre.df$cp <- as.factor( discre.df$cp)
  discre.df$trestbps <- as.factor( discre.df$trestbps)
  discre.df$chol <- as.factor( discre.df$chol)
  discre.df$fbs <- as.factor( discre.df$fbs)
  discre.df$restecg <- as.factor( discre.df$restecg)
  discre.df$thalach <- as.factor( discre.df$thalach)
  discre.df$exang <- as.factor( discre.df$exang)
  discre.df$oldpeak <- as.factor( discre.df$oldpeak)
  discre.df$slope <- as.factor( discre.df$slope)
  discre.df$ca <- as.factor( discre.df$ca)
  discre.df$thal <- as.factor( discre.df$thal)
  discre.df$num <- as.factor( discre.df$num)
  
  return(discre.df)
  
}