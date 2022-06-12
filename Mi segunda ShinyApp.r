## Esta es mi segunda Shiny App
## todavia no es muy interesante

library(shiny)

## Vamos a hacer que el usuario pueda interectuar un poco 
## va a escoger un conjunto de datos del paquete datasets

ui <- fluidPage(
    selectInput("mi_data", label = "Selecciona un conjunto de Datos", choices = ls("package:datasets")),
    verbatimTextOutput("resumen"),
    tableOutput("tabla")
)

## los nombres "resumen" y "tabla" son id que se usan en la funcion server

##  le decimos que hacer con el conjunto de datos que selecciono

server <- function(input, output, session) {
  output$resumen <- renderPrint({
    dataset <- get(input$mi_data, "package:datasets")
    summary(dataset)
  })
  
  output$tabla <- renderTable({
    dataset <- get(input$mi_data, "package:datasets")
    dataset
  })
}

## corremos la App

shinyApp(ui, server)


