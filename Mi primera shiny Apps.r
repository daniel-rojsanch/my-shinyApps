## Vamos a crear mi primera Shiny App
## daniel-rojsanch

library(shiny)


## ui
ui <- fluidPage("Hello, It's my fist ShinyApp")

## server
server <- function(input, output, session){
    
}

## correr la App
shinyApp(ui, server)


