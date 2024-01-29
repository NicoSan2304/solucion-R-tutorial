library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(tidyverse)

feminicidios <- read.csv("cases_2017.csv", na.strings = c("Sin información","NA"))

edad <- unique(feminicidios$edad)
view(edad)

ui <- fluidPage(
  
  # Título de la aplicación
  titlePanel("Feminicidios en colombia 2017"),
  
  # Definicion de los Inputs y los Outputs
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Explicación de cuales son los inputs
    sliderInput(inputId = "rango_edad",
                label = "Rango de edad:",
                min(0, na.rm = 0), max(100, na.rm = 0), value = c(20,50))
    ),
    # Panel para los outputs
    mainPanel(
      
      # Output que muestra el panel de la modalidad escogida por el usuario
      plotOutput("edadesrango")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  data_viz <- reactive({
    df <- feminicidios
    if (!is.null(input$rango_edad)) {
      df <- df %>% 
        dplyr::filter(edad %in% input$rango_edad)
    }
    casos_1 <-  df %>%
      group_by(edad) %>%
      tally() %>%
      select(edad, n)
    casos_1
  })  
  
  output$edadesrango <- renderPlotly({
    req(data_viz())
    plot_ly(data_viz(), x = ~edad, y = ~n, type = "bar")
  })
}


# Create Shiny app ----
shinyApp(ui = ui, server = server)


