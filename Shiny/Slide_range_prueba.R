# Instalar y cargar el paquete Shiny
if (!require("shiny")) install.packages("shiny")
library(shiny)

# Crear la interfaz de usuario (UI)
feminicidios <- read.csv("cases_2017.csv", na.strings = c("Sin información","NA"))

ui <- fluidPage(
  titlePanel("Aplicación Shiny con Slider de Rango"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "rango_edad",
                  label = "Rango de edad:",
                  min(0, na.rm = 0), 
                  max(100, na.rm = 0), 
                  value = c(20,50))
      ),
    
    mainPanel(
      plotOutput("plot_output")
    )
  )
)

# Crear el código del servidor
server <- function(input, output) {
  output$plot_output <- renderPlot({
    # Generar un gráfico con el rango seleccionado
    grafica_final(feminicidios,input$rango_edad)
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui, server)
