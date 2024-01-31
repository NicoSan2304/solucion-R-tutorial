library(shiny)
library(tidyverse)
library(plotly)
library(DT)

feminicidios <- read.csv("cases_2017.csv", na.strings = c("Sin información","NA"))

modalidad <- unique(feminicidios$modalidad)
feminicidios$modalidad[is.na(feminicidios$modalidad)] <- "No hay información"

ui <- fluidPage(

  titlePanel("Feminicidios en colombia 2017"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "modalidades",
                  label = "Tipo de modalidad:",
                  choices = modalidad, multiple = T),
      sliderInput(inputId = "rango_edad",
                  label = "Rango de edad:",
                  min(0, na.rm = 0), 
                  max(100, na.rm = 0), 
                  value = c(20,50)),
      dateRangeInput(inputId = "rango_fechas",
                     label = "Seleccionar rango de fechas",
                     start = min(feminicidios$fecha),
                     end = max(feminicidios$fecha))
    ),
    
    mainPanel(
      
      tabsetPanel(
        
        tabPanel("Gráficas",
                 verbatimTextOutput("informacion_descriptiva"),
                 
                 plotOutput("plot_output")
        ),
        
        tabPanel("Tabla",
                 DTOutput("tabla_interactiva"),
                 plotlyOutput("numModalidad")
        )
      )
    )
  )
)

server <- function(input, output) {
    
    output$informacion_descriptiva <- renderText({
      paste("Número total de casos:", nrow(feminicidios), "\n",
            "Fecha más temprana:", min(feminicidios$fecha), "\n",
            "Fecha más reciente:", max(feminicidios$fecha))
    })
    
    output$tabla_interactiva <- renderDT({
      req(data_viz())
      datatable(data_viz(), options = list(pageLength = 5))
    })
  
  data_viz <- reactive({
    df <- feminicidios
    if (!is.null(input$modalidades)) {
      df <- df |>
        dplyr::filter(modalidad %in% input$modalidades)
    }
    casos_1 <-  df |>
      group_by(modalidad) |>
      tally() |> 
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

shinyApp(ui = ui, server = server)


