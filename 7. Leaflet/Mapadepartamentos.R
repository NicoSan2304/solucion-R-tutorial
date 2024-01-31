#Librerias a usar
library(sf)
library(leaflet)
library(readxl)

# Descarga el archivo TopoJSON, de la base de datos y organización de datos
colombia_sf <- st_read("https://github.com/datasketch/R-Data-Science-Tasks/raw/main/annexes/col_departments/col-departments.topojson")
datos <- read_xlsx("departamentosco.xlsx")
dataa <- data.frame(datos)
Lng <- datos$Lng
Lat <- datos$Lat
Ciudad <- datos$Ciudad
Poblacion <- datos$Poblacion
Departamento <- datos$Departamento