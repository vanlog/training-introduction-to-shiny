
# global ------------------------------------------------------------------

library(shiny)
library(dplyr)
library(ggplot2)

df <- data.frame(
  id = 1:1000,
  values = rnorm(1000)
)

# ui ----------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("Hello World!"),
  sliderInput(inputId = "n_bins",
              label = "Number of bins:",
              min = 0,
              max = 100,
              value = 50),
  plotOutput("histogram")
)


# server ------------------------------------------------------------------

server <- function(input, output, session) {

  output$histogram <- renderPlot({
    ggplot(df) +
      aes(x = values) +
      geom_histogram(bins = input$n_bins)
  })

}


# run ---------------------------------------------------------------------

shinyApp(ui, server)
