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

  output$select_table <- renderDataTable({
    flog.info("Rendering select_table...")

    datatable(
      df,
      option = list(
        search = list(
          regex = TRUE,            # use regular expressions
          caseInsensitive = FALSE, # upper case letter differ from lower case
          search = ''              # initial string to be searched
        ),
        pageLength = 3
      ),
      filter = list(position = 'top'),
    )
  })

}

