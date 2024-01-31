#Se colocan las librerías necesarias para el desarrollo del código
library(readxl)
library(dplyr)
library(tidyr)

#Realizamos la lectura del archivo de excel, el cuál guardaremos en la variable tabladane,
#en donde especificamos que lea la página 2 y además especificamos el rango de la tabla
tabla_dane <- read_xlsx("anexos_defunciones.xlsx", 
                       sheet = 2, 
                       range = "A12:O12456")

#Completamos los espacios con los datos anteriores para tener una 
#mejor visualización de la tabla
tabla_completada <- tabla_dane |>
  fill("...1","...2") 

#Cambiamos el nombre de las variables para empezar a darle forma y mejor entenimiento
#a la tabla, en este caso renombramos la columna del año, departamento y semana.
tabla_renombrada <- rename(tabla_completada, 
                     Año = ...1, 
                     Departamento = ...2, 
                     Semana = ...3)
#Eliminamos las columnas que no son necesarias en la visualización de datos
tabla_eliminacion <- select(tabla_renombrada,
                            -Total...4,
                            -Total...8,
                            -Total...12)
#Eliminamos la fila 1 ya que no tiene información relevante
tabla_eliminar1 <- tabla_eliminacion[-c(1),]

#Unimos las columnas que se encuentran en el mismo grupo con el fin de poder
#Organizarlas y despues separarlas por genero
tabla_unit <- unite(tabla_eliminar1, 
                    "Natural", 
                    c('Masculino...5','Femenino...6','Indeterminado...7'))
tabla_unit2 <-  unite(tabla_unit, 
                      "Violenta", 
                      c('Masculino...9','Femenino...10','Indeterminado...11'))
tabla_unit3 <-  unite(tabla_unit2,
                      "En estudio",
                      c('Masculino...13','Femenino...14','Indeterminado...15'))
#Creamos una nueva variable en donde se colocará el tipo de muerte
tabla_filas <- tabla_unit3 |> 
  pivot_longer(cols = c("Natural", "Violenta", "En estudio"), 
               names_to = "Tipo de muerte", 
               values_to = "Valor")

#Separamos cada uno de los valores por genero y filtramos para evitar valores no deseados
tabla_separada <- tabladane_filas |> 
  separate(Valor, 
           into = c("Masculino", "Femenino", "Indefinido"), 
           sep = "_") |> 
  filter(!str_detect(Semana, "Total"))


View(tabla_separada)
