
# global ------------------------------------------------------------------

library(shiny)
library(dplyr)
library(ggplot2)
library(futile.logger)

flog.info("Loading data...")

df <- data.frame(
  id = 1:1000,
  values = rnorm(1000)
)

# ui ----------------------------------------------------------------------

ui <- fluidPage(

  titlePanel("Hello World!"),

  sidebarLayout(
    sidebarPanel(
      width = 3,
      sliderInput(inputId = "n_bins",
                  label = "Number of bins:",
                  min = 0,
                  max = 100,
                  value = 50)
    ),

    mainPanel(
      width = 9,
      plotOutput("histogram")
    )
  )
)

# server ------------------------------------------------------------------

server <- function(input, output, session) {

  flog.info("Running the server...")

  output$histogram <- renderPlot({
    flog.info("Rendering 'histogram' with %s bins...", input$n_bins)

    ggplot(df) +
      aes(x = values) +
      geom_histogram(bins = input$n_bins,
                     fill = "lightblue",
                     color = "blue",
                     alpha = 0.7) +
      ggtitle("Values Histogram") +
      xlab("Values") +
      ylab("Count") +
      theme_bw()
  })

}


# run ---------------------------------------------------------------------

shinyApp(ui, server)
