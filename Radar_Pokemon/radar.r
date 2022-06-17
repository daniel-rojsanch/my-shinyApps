## Cargamos las librerias necesarias
library(shiny)  ## para crear la aplicacion
library(fmsb)   ## Para realizar el grafico de Radar

## Descargamos el conjunto de datos 
pkm2 <- read.csv("https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv")
pk <- pkm2[,c("HP", "Sp..Atk", "Sp..Def", "Attack", "Defense", "Speed")]
rownames(pk) <- pkm2$Name

## Creamo un funcion para que busque y grafique los pokemons que queramos
## ademas de customizar 

# Color vector
colors_border=c("#E74C3C","#2ECC71" , "#BB8FCE" )
colors_in=c("#E74C3C40", "#2ECC7140" , "#BB8FCE50" )

poke_chart <- function(pokes) {
  ## Añadimos dos columnas para el maximo y el minimo
  data <- pk[rownames(pk) %in% pokes,]
  data <- rbind(rep(255, 6), rep(0, 6), data  )
  
  ## Graficmos
  radarchart(data,pcol=colors_border , pfcol=colors_in , 
             plwd=4 , plty=1)
  legend(1, 1.4, col = colors_border, legend = rownames(data[-c(1,2),]), 
         pch=20,pt.cex=2.5, cex=1, bty = "n" )
}

## Ejemplo
x <- c("Pikachu", "Chansey","Latias")
poke_chart(x)



## La aplicacion
ui <- fluidPage(
  titlePanel("Radar Pokemon"),
  sidebarLayout(
    sidebarPanel(
        selectInput("id_pk1", label = "Escoge un Pokemon", 
              choices = rownames(pk)),
        selectInput("id_pk2", label = "Escoge un Pokemon", 
              choices = rownames(pk), selected = "Charizard"),
        selectInput("id_pk3", label = "Escoge un Pokemon", 
              choices = rownames(pk), selected = "Chansey"),
    ),
    mainPanel(
        plotOutput("radar_pkm")
    )
  )
)

server <- function(input, output, session){
  output$radar_pkm <- renderPlot(poke_chart( c(input$id_pk1,
                                               input$id_pk2,
                                               input$id_pk3) ))

}

shinyApp(ui, server)


