
# global ------------------------------------------------------------------

library(shiny)
library(dplyr)
library(readr)
library(ggplot2)
library(futile.logger)

flog.info("Loading data...")

df <- read_csv("./data/marvel-vs-dc.csv")

df_colnames <- colnames(df)

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
                  value = 50),
      selectInput(inputId = "var_name",
                  label = "Choose a variable",
                  choices = df_colnames),
      tags$hr(),
      textInput(inputId = "plot_title",
                label = "Customize the plot title"),
      actionButton(inputId = "update_plot",
                   label = "Update plot")
    ),

    mainPanel(
      width = 9,
      plotOutput("histogram"),
      plotOutput("density")
    )
  )
)

# server ------------------------------------------------------------------

server <- function(input, output, session) {

  flog.info("Running the server...")

  output$histogram <- renderPlot({
    req(is.numeric(df[[input$var_name]]))

    flog.info("Rendering 'histogram' with %s bins...", input$n_bins)

    input$update_plot

    ggplot(df) +
      aes_string(x = input$var_name) +
      geom_histogram(bins = input$n_bins,
                     fill = "lightblue",
                     color = "blue",
                     alpha = 0.7) +
      ggtitle( isolate(input$plot_title) ) +
      ylab("Count") +
      theme_bw()
  })

  output$density <- renderPlot({
    req(is.numeric(df[[input$var_name]]))

    flog.info("Rendering 'density'")

    input$update_plot

    ggplot(df) +
      aes_string(x = input$var_name, fill = "Company") +
      geom_density(color = "blue",
                   alpha = 0.7) +
      ggtitle( paste("Distribution of", input$var_name) ) +
      ylab("Count") +
      theme_bw()
  })

}


# run ---------------------------------------------------------------------

shinyApp(ui, server)
