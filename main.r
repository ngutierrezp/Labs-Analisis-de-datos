
###################################
#     Paquetes utilizados:        #


#install.packages("corrplot")
#install.packages("ggpubr")
#install.packages('plyr')


library(ggplot2)
library(corrplot)
library(ggpubr)
library(plyr)


###################################



# Estructura del main

# Es el archivo principal para el llamado de funciones de todo el c�digo
# primeramente se carga todo el dataset limpio para el tabajo de analisis


# La Estadistica descriptiva que se hace se ha separado en dos partes:

#       1-  Descriptiva para las variables numericas

#       2-  Descriptiva para las variables categoricas


# Luego de esto se hace estadistica inferencial de la forma:

#       1-  Docimas de contraste para las variable numericas

#       2-  Regresi�n lineal para generar el modelo de
#           personas sanas o enfermas




dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("showCorplot", mode="function")) source("scripts/corAnalysis.R")
if(!exists("normal.test.2df", mode="function")) source("scripts/statisticalTest.R")
if(!exists("getAnalysis", mode="function")) source("scripts/getAnalysis.R")
if(!exists("getAnalysisLoc", mode="function")) source("scripts/getAnalysisLoc.R")
if(!exists("bar.plot.categorical", mode="function")) source("scripts/categoricalPlot.R")





#################
# DATOS LIMPIOS #
#################


# Los datos limpios son una serie de dataframes
# que contienen la informaci�n ya limpia de todo
# el data set. Tambien contienen informaci�n
# diferenciada segun se especifique:



#     all.df :  Contiene toda la informaci�n del dataset
#               incluida la informaci�n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- getAllData()

#     mixed.all.df :  Contiene toda la informaci�n limpia
#                     y legible con con la interpretaci�n
#                     categorica de los numeros.
mixed.all.df <- getMixedData(all.df)


#     var.numerical : Es un vector quer indica las columnas
#                     que son numericas.
var.numerical <- c(1,4,5,8,10,12)

#     var.categorial : Es un vector quer indica las columnas
#                     que son categoricas y dicotomicas.

var.categorial <- c(2,3,6,7,9,11,13,14)


#     numerical.df :  Dataframe general pero solo con
#                     variables numericas
numerical.df <- all.df[var.numerical]


#     healthy : Es un dataframe que proviene de all.df y
#               contiene toda la informaci�n de las personas
#               sanas del coraz�n
healthy <- all.df[all.df$num == 0,] 


#     sicky :   Es un dataframe que proviene de all.df y
#               contiene toda la informaci�n de las personas
#               enfermas del coraz�n
sicky <- all.df[all.df$num > 0,] 


#     numerical.health :  Dataframe de personas sanas pero
#                         solo con variables numericas
numerical.health <- healthy[var.numerical]  


#     numerical.sick :    Dataframe de personas enfermas 
#                         pero solo con variables numericas
numerical.sick <- sicky[var.numerical]


#     categorical.health :  Dataframe de personas sanas pero
#                           solo con variables categoricas
categorical.health <- healthy[var.categorial]  


#     categorical.sick :    Dataframe de personas enfermas 
#                           pero solo con variables categoricas
categorical.sick <- sicky[var.categorial]


####################################################
#                                                  #  
#         I.    ESTADISTICA DESCRIPTIVA            #
#                                                  #
####################################################

#   1- Variables numericas
################################


var.numerical.loc <- c(var.numerical, 15) # nueva var numerica con locacion

numerical.loc.df <- all.df[var.numerical.loc] 

all.analysis <- getAnalysis(numerical.df) # analisis completo


## Analisis por localizacion
cleve.analysis <- getAnalysisLoc(numerical.loc.df,"cleve") 

hung.analysis <- getAnalysisLoc(numerical.loc.df,"hung")

switz.analysis <- getAnalysisLoc(numerical.loc.df,"switz")

va.analysis <- getAnalysisLoc(numerical.loc.df,"va")



## Matriz de correlaci�n

showCorplot(all.df,var.numerical)

# como se puede ver la relaci�n que se ve en la matriz
# es muy debil lo cual significa que no existen relaciones
# del tipo lineal entre las variables, o tambien que
# las variables tienen valores muy extremos que afectaton
# la medicion de la correlaci�n.


#   1- Variables categoricas
################################

# Una tabla de contigencia de todas las variables 
# categoricas, resulta en una matriz muy extensa


contigency.table <- table(all.df[var.categorial])


# sin embargo se puede estudiar las clases que son de interes 
# las cuales son Sanos y enfermos.

# Entonces �qu� frecuencia tienen las variables segun sanos
# y enfermos ?


plots <- bar.plot.categorical(mixed.all.df)



###############################################################
# Test de medias para dos grupos -> Sanos y enfermos
###############################################################





alpha <- 0.05

# lista de 2 df que contiene los p-valor para cada una de las variables
# numericas de los dos grupos a analizar
df.normal.result <- normal.test.2df(numerical.health,numerical.sick)


normal.dist.health <- df.normal.result[[1]]$names[df.normal.result[[1]]$p.value > alpha]

normal.dist.sick <- df.normal.result[[2]]$names[df.normal.result[[2]]$p.value > alpha]

# Como se puede ver ningun grupo comparte la normalidad en sus variables
# por lo que es necesario utilizar una prueba no parametrica

# Entonces una alternativa no parametrica para prueba de medias seria Mann-Whitney



result.maan <- mann.whitney.2df.test(numerical.health,numerical.sick) 

# dados los resutados de Mann-Whitney, se puede ver que las caracteristicas
# de los dos grupos difieren, por lo que se podria pensar que 
# estas caracteristicas podrian ser significativas al momento de 
# discriminar a un enfermo de coraz�n






## Analisis estadisticos con variables numericas

# Test estatico para dos grupos (sanos y enfermos) y comparar las diferentes medias
# para ver si hay alguna diferencia entre las medias de los grupos


# regresion logista probando diferentes variables contra el grupo de sanos o enfermos (dicotomica)