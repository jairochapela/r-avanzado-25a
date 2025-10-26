library(shiny)
library(ggplot2)
library(dplyr)

irisdata <- as_tibble(iris)

ui <- fluidPage(
  titlePanel("Explorando el conjunto de datos Iris"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "Variable para el eje X:",
                  choices = names(irisdata)[1:4],
                  selected = names(irisdata)[1]),
      selectInput("yvar", "Variable para el eje Y:",
                  choices = names(irisdata)[1:4],
                  selected = names(irisdata)[2]),
      checkboxInput("colorear", "Colorear según especie", TRUE), 
    ), 
    
    mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output) {
  output$grafico <- renderPlot({
    if (input$colorear) {
      color <- "Species"
    } else {
      color <- NULL
    }
    
    ggplot(irisdata, aes_string(x = input$xvar, y = input$yvar, color = color)) +
      geom_point(size = 3) +
      labs(title = paste("Gráfico de", input$yvar, "vs", input$xvar),
           x = input$xvar,
           y = input$yvar) +
      theme_minimal()
  })
}


shinyApp(ui = ui, server = server)