server <- function(input, output, session) {

  # variables --------------------------------------------------------------

  x_colour <- "darkred"
  y_colour <- "darkgoldenrod"
  marvel_color <- 'lightblue'
  dc_color <- 'lightgreen'
  dollar_bill_color <- "#85bb65"

  # reactives --------------------------------------------------------------

  data_subset <- reactive({
    flog.info("updating data_subset...")

    subset_indices <- input$select_table_rows_all       # rows on all pages (after being filtered)
    dataset()[subset_indices,]
  })

  data_visible <- reactive({
    flog.info("updating data_visible...")

    visible_indices <- input$select_table_rows_current   # rows on the current page
    dataset()[visible_indices,]
  })

  data_selected <- reactive({
    flog.info("updating data_selected...")

    selected_indices <- input$select_table_rows_selected # selected rows (by a click)
    dataset()[selected_indices,]
  })

  dataset <- eventReactive(input$data_file, {
    # input$dataset will be NULL initially. And so the dataset() reactive
    req(input$data_file)

    tryCatch(
      {
        df <- read_csv(input$data_file$datapath) %>%
          mutate(Company = factor(Company),
                 Release = as.integer(Release),
                 Id = as.integer(Id),
                 Metascore = as.integer(Metascore))
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )

    return(df)
  })

  budget_range <- eventReactive(dataset(), {
    df <- dataset()
    range(df$Budget, df$Opening_Weekend_USA, df$Gross_USA, df$Gross_Worldwide)
  })

  # scatter ----------------------------------------------------------------

  output$scatter <- renderPlot({
    flog.info("Rendering scatter...")

    ggplot(dataset()) +
      aes_string(x = "Budget", y = "Gross_Worldwide") +
      geom_point(pch=21, fill="gray", size=2, colour="gray", stroke=1) +
      geom_point(data = data_subset(),
                 pch=21, fill="black", size=2, colour="black", stroke=1) +
      geom_point(data = data_visible(),
                 pch=21, fill="blue", size=4, colour="blue", stroke=1) +
      geom_point(data = data_selected(),
                 pch=21, fill=NA, size=6, colour="red", stroke=1) +
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
      dataset(),
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
        background = styleColorBar(dataset()$Rate, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # in-line bar
      formatStyle(
        'Metascore',
        background = styleColorBar(dataset()$Metascore, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # in-line bar
      formatStyle(
        'Minutes',
        background = styleColorBar(dataset()$Minutes, 'steelblue'),
        backgroundSize = '90% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # category coloured label
      formatStyle(
        'Company',
        transform = 'rotateX(45deg) rotateY(0deg) rotateZ(0deg)',
        backgroundColor = styleEqual(
          unique(dataset()$Company), c(marvel_color, dc_color)
        )
      ) %>%
      # dollar bars with the same scales
      formatStyle(
        c("Budget", "Opening_Weekend_USA", "Gross_USA", "Gross_Worldwide"),
        color = 'black',
        background = styleColorBar(budget_range(), dollar_bill_color),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      ) %>%
      # highlight scatter variables
      formatStyle("Budget",  color = x_colour, fontWeight = 'bold') %>%
      formatStyle("Gross_Worldwide",  color = y_colour, fontWeight = 'bold')
  })

  # movie_info -------------------------------------------------------------
  output$movie_info <- renderUI({
    point <- input$scatter_hover
    flog.info("Point hover is %s", point$Original_Title)

    if (is.null(point)) {
      tags$p("Please select a movie from the plot")
    } else {
      tagList(
        p("Budget: ", round(point$x,2)) ,
        p("Gross_Worldwide: ", round(point$y,2))
      )
    }
  })

}

