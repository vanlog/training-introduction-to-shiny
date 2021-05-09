server <- function(input, output, session) {

  # variables --------------------------------------------------------------

  x_colour <- "darkred"
  y_colour <- "darkgoldenrod"
  marvel_color <- 'lightblue'
  dc_color <- 'lightgreen'
  dollar_bill_color <- "#85bb65"
  budget_range <- range(df$Budget, df$Opening_Weekend_USA, df$Gross_USA, df$Gross_Worldwide)

  # reactives --------------------------------------------------------------

  data_subset <- reactive({
    flog.info("updating data_subset...")

    subset_indices <- input$select_table_rows_all       # rows on all pages (after being filtered)
    df[subset_indices,]
  })

  # scatter ----------------------------------------------------------------

  output$scatter <- renderPlot({
    flog.info("Rendering scatter...")

    ggplot(df) +
      aes_string(x = "Budget", y = "Gross_Worldwide") +
      geom_point(pch=21, fill="gray", size=2, colour="gray", stroke=1) +
      geom_point(data = data_subset(),
                 pch=21, fill="black", size=2, colour="black", stroke=1) +
      theme_bw() +
      theme(axis.title.x = element_text(colour = x_colour,
                                        size = 18),
            axis.title.y = element_text(colour = y_colour,
                                        size = 18))
  })

  # select_table -----------------------------------------------------------

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
    ) %>%
      # in-line bar
      formatStyle(
        'Rate',
        background = styleColorBar(df$Rate, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # in-line bar
      formatStyle(
        'Metascore',
        background = styleColorBar(df$Metascore, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # in-line bar
      formatStyle(
        'Minutes',
        background = styleColorBar(df$Minutes, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # category coloured label
      formatStyle(
        'Company',
        transform = 'rotateX(45deg) rotateY(0deg) rotateZ(0deg)',
        backgroundColor = styleEqual(
          unique(df$Company), c(marvel_color, dc_color)
        )
      ) %>%
      # dollar bars with the same scales
      formatStyle(
        c("Budget", "Opening_Weekend_USA", "Gross_USA", "Gross_Worldwide"),
        color = 'black',
        background = styleColorBar(budget_range, dollar_bill_color),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # highlight scatter variables
      formatStyle("Budget",  color = x_colour, fontWeight = 'bold') %>%
      formatStyle("Gross_Worldwide",  color = y_colour, fontWeight = 'bold')
  })

}

