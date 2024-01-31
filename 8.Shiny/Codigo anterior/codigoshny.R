library(shiny)
library(tidyverse)
library(plotly)

feminicidios <- read.csv("cases_2017.csv", na.strings = c("Sin información","NA"))

modalidad <- unique(feminicidios$modalidad)
feminicidios$modalidad[is.na(feminicidios$modalidad)] <- "No hay información"

ui <- fluidPage(
  # Título de la aplicación
  titlePanel("Feminicidios en colombia 2017"),
  
  # Definicion de los Inputs y los Outputs
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Explicación de cuales son los inputs
      selectInput(inputId = "modalidades",
                  label = "Tipo de modalidad:",
                  choices = modalidad, multiple = T),
      sliderInput(inputId = "rango_edad",
                  label = "Rango de edad:",
                  min(0, na.rm = 0), 
                  max(100, na.rm = 0), 
                  value = c(20,50))
      
    ),
    # Panel para los outputs
    mainPanel(
      
      # Output que muestra el panel de la modalidad escogida por el usuario
      plotlyOutput("numModalidad"),
      plotOutput("plot_output")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  data_viz <- reactive({
    df <- feminicidios
    if (!is.null(input$modalidades)) {
      df <- df %>% 
        dplyr::filter(modalidad %in% input$modalidades)
    }
    casos_1 <-  df %>%
      group_by(modalidad) %>%
      tally() %>%
      select(modalidad, n)
    casos_1
  })  
  
  
  output$numModalidad <- renderPlotly({
    req(data_viz())
    plot_ly(data_viz(), x = ~modalidad, y = ~n, type = "bar")
  })
  output$plot_output <- renderPlot({
    grafica_final(feminicidios,input$rango_edad)
  })
  
}

# Creación y visualización de la aplicación Shiny
shinyApp(ui = ui, server = server)


