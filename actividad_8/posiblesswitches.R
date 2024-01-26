# Input: Selector for choosing dataset ----
selectInput(inputId = "feminicidios",
            label = "Seleccione el departamento:",
            choices = departamento),
# Input: Selector for choosing dataset ----
selectInput(inputId = "feminicidios",
            label = "Relación existente entre la victima y su agresor:",
            choices = relacion),
sliderInput(inputId = "femenicidios",
            label = "Rango de edad:",
            min(0, na.rm = 0), max(100, na.rm = 0), value = c(20,50))





datos = data.frame(casos = c("Arma de fuego","Objeto contundente", "Degollamiento"),
                   numcasos = c(numArmaFuego,numObjContundente,numDegollam))