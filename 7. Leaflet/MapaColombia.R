#Librerias a usar
library(sf)
library(leaflet)
library(readxl)

# Descarga el archivo TopoJSON, de la base de datos y organización de datos
colombia_sf <- st_read("https://github.com/datasketch/R-Data-Science-Tasks/raw/main/annexes/col_departments/col-departments.topojson")
datos <- read_xlsx("co.xlsx")
dataa <- data.frame(datos)
Lng <- datos$Lng
Lat <- datos$Lat
City <- datos$City
Population <- datos$Population

# Creación del mapa interactivo con Leaflet
mapa_leaflet <- leaflet(colombia_sf) |> 
  addProviderTiles("CartoDB.Positron") |> 
  addPolygons(data = colombia_sf, 
              fillColor = "lightblue", 
              color = "white", 
              weight = 1, 
              highlight = highlightOptions( weight = 3, color = "#666", fillOpacity = 0.7, bringToFront = TRUE ), 
              popup = ~name) |> 
  addCircles(lng = ~Lng,
             lat = ~Lat,
             weight = 1,
             radius = ~sqrt(Population)* 30,
             popup = ~Population)

# Visualización del mapa
mapa_leaflet

