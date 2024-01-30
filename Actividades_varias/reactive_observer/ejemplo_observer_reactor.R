#Cargar las librerías a utilizar
library(shiny)
library(plotly)

# Función que toma un numero y devuelve el doble del número
calcularResultado <- function(num) {
  return(num * 2)
}

# Función que muestra el número ingresado
realizarAccionesAdicionales <- function(num) {
  print(num)
}
#Interfaz de usuario 
ui <- fluidPage(
  #Estilización del título por medio de herramientas de HTML
  tags$head(
    tags$style(HTML("
      .titulo {
        font-family: 'Arial', sans-serif;
        font-size: 24px;
        color: #333333;
        font-weight: bold;
        text-align: center;
        text-decoration: underline;
      }
    "))
  ),
  
  #Creación del título y agregación del estilo HTML
  titlePanel(tags$div(class = "titulo", 
                      "Ejemplo de Shiny con Reactivos y Observadores")),
  #Creación de inputs 
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "num", 
                   label = "Ingrese un número:", 
                   value = 0),
      actionButton(inputId = "incrementar", 
                   label = "Incrementar Contador"),
      actionButton(inputId = "actualizar", 
                   label = "Actualizar Valores"),
      textInput(inputId = "input1", 
                label = "Input 1", 
                value = ""),
      textInput(inputId = "input2", 
                label = "Input 2", 
                value = ""),
      actionButton(inputId = "boton", 
                   label = "Hacer Algo"),
      
      #Mostrar valores por medio de Outputs de texto
      textOutput("value"),
      textOutput("valorContador"),
      textOutput("resultadoA"),
      textOutput("resultadoB")
    ),
    #Mostrar valores y gráfica de acuerdo a los ingresados por el usuario o las acciones
    #que este realice dentro de la aplicación
    mainPanel(
      textOutput("mensaje"),
      plotlyOutput("grafica")  # Cambié "resultados" a "grafica"
    )
  )
)

server <- function(input, output, session) {
  
  # Reactivo relacionado con el doble de un numero y visualización de este en la pantalla
  resultado <- reactive({
    calcularResultado(input$num)
  })
  
  output$value <- renderText({
    resultado()
  })
  
  observe({
    realizarAccionesAdicionales(input$num)
  })
  #Reactivo del contador el cuál va imprimiendo el valor correspondiente
  contador <- reactiveVal(0)
  
  observeEvent(input$incrementar, {
    contador(contador() + 1)
  })
  
  output$valorContador <- renderText({
    contador()
  })
  
  # Reactivo que realiza una acción en un evento específico
  valores <- reactiveValues(a = 10, b = 20)
  
  observeEvent(input$actualizar, {
    valores$a <- valores$a * 2
    valores$b <- valores$b + 5
  })
  
  output$resultadoA <- renderText({
    valores$a
  })
  
  output$resultadoB <- renderText({
    valores$b
  })
  
  # Visualización en la consola de los valores
  observe({
    print(paste("Los valores son:", input$input1, "y", input$input2))
  })
  
  # Observador de Evento Botón
  observeEvent(input$boton, {
    # Resta de un número ingresado a los valores
    valores$a <- valores$a - as.numeric(input$num)
    valores$b <- valores$b - as.numeric(input$num)
    
    # Resta de un número ingresado a los inputs
    updateTextInput(session, "input1", value = as.character(as.numeric(input$input1) - as.numeric(input$num)))
    updateTextInput(session, "input2", value = as.character(as.numeric(input$input2) - as.numeric(input$num)))
    
    print(paste("Se restó", input$num, "a los valores y a los inputs."))
  })
  
  # Creación y visualización de la gráfica para comparar Inputs y Valores
  output$grafica <- renderPlotly({
    datos_grafica <- data.frame(
      categoria = c("Input 1", "Input 2", "Valores A", "Valores B"),
      valor = c(as.numeric(input$input1), as.numeric(input$input2), valores$a, valores$b),
      grupo = rep(c("Inputs", "Valores"), each = 2)
    )
    
    p <- plot_ly(datos_grafica, x = ~categoria, y = ~valor, type = "bar", name = ~grupo)
    
    layout <- list(title = "Gráfico de Barras",
                   xaxis = list(title = "Categoría"),
                   yaxis = list(title = "Valor"))
    
    p |> layout(layout)
  })
}

shinyApp(ui, server)
