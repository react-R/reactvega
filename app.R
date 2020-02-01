library(shiny)
library(reactvega)

ui <- fluidPage(
  titlePanel("reactR Input Example"),
  reactvegaInput("textInput"),
  textOutput("textOutput")
)

server <- function(input, output, session) {
  output$textOutput <- renderText({
    sprintf("You entered: %s", input$textInput)
  })
}

shinyApp(ui, server)