server <- function(input, output, session) {

  output$scatter <- renderPlot({
    flog.info("Rendering scatter...")

    ggplot(df) +
      aes_string(x = "Budget", y = "Gross_Worldwide") +
      geom_point() +
      theme_bw() +
      theme(axis.title.x = element_text(size = 18),
            axis.title.y = element_text(size = 18))
  })

}

