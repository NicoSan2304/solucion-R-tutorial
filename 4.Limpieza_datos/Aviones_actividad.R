#Carga de paquetes necesarios
library(tidyverse)
library(nycflights13)

#Agrupamos los datos por aerolínea y guardamos la informacion en la variable grupos1
grupos1 <- flights %>%
  group_by(carrier)

#Dividimos la información de cada aerolínea en una lista
tipo_aerolinea <- split(grupos1, grupos1$carrier)

#Hacemos uso de purrr para sacar más información por medio de otras funciones

promedio_llegada <- tipo_aerolinea %>%
  map(~mean(.$arr_delay, 
            na.rm = TRUE))

promedio_salida <- tipo_aerolinea %>%
  map(~mean(.$dep_delay, 
            na.rm = TRUE))

promedio_vuelo  <- tipo_aerolinea %>%
  map(~mean(.$air_time, 
            na.rm = TRUE))