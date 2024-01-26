#Se colocan las librerías necesarias para el desarrollo del código
library(readxl)
library(dplyr)
library(tidyr)

#Realizamos la lectura del archivo de excel, el cuál guardaremos en la variable tabladane,
#en donde especificamos que lea la página 2 y además especificamos el rango de la tabla
tabladane <- read_xlsx("anexos_defunciones.xlsx", 
                       sheet = 2, 
                       range = "A12:O12456")
#Completamos los espacios con los datos anteriores para tener una 
#mejor visualización de la tabla
tabladane1 <- tabladane |>
  fill("...1","...2") 
#Cambiamos el nombre de las variables para empezar a darle forma y mejor entenimiento
#a la tabla, en este caso renombramos la columna del año, departamento y semana.
tabladane2 <- rename(tabladane1, Año = ...1, Departamento = ...2, Semana = ...3)
#Eliminamos las columnas que no son necesarias en la visualización de datos
tabladane3 <- select(tabladane2,-Total...4,-Total...8,-Total...12)
#Eliminamos la fila 1 ya que no tiene información relevante
tabladane4 <- tabladane3[-c(1),]
#Unimos las columnas que se encuentran en el mismo grupo con el fin de poder
#Organizarlas y despues separarlas por genero
tabladaneunit <- unite(tabladane4, 
                    "Natural", 
                    c('Masculino...5','Femenino...6','Indeterminado...7'))
tabladaneunit2 <-  unite(tabladaneunit, 
        "Violenta", 
        c('Masculino...9','Femenino...10','Indeterminado...11'))
tabladaneunit3 <-  unite(tabladaneunit2, 
        "En estudio", 
        c('Masculino...13','Femenino...14','Indeterminado...15'))
