ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),

  ## Sidebar content -----------------------------------------------------------
  dashboardSidebar(

    sidebarMenu(
      menuItem(text = "Load data", tabName = "load_data", icon = icon("fa-database", lib = "font-awesome")),
      menuItem(text = "Analysis", tabName = "analysis", icon = icon("fa-line-chart", lib = "font-awesome"))
    )

  ),

  ## Body content --------------------------------------------------------------
  dashboardBody(
    tabItems(

      ## load data content -------------------------------------------------------
      tabItem(
        tabName = "load_data",
        box(
          title = "Upload data",
          status = "primary",
          width = 6,
          fileInput(
            "data_file",
            "Choose CSV File",
            multiple = FALSE,
            accept = c("text/csv",
                       "text/comma-separated-values,text/plain",
                       ".csv")),
        )
      ),
      ## Analysis content --------------------------------------------------------
      tabItem(
        tabName = "analysis",
        box(
          title = "Movies",
          status = "primary",
          width = 6,
          height = "500px",
          plotOutput(outputId = "scatter",
                     hover = "scatter_hover")
        ),
        tabBox(
          width = 6,
          height = "500px",
          tabPanel(
            title = "Movie info",
            uiOutput("movie_info")
          ),
          tabPanel(
            title = "Data Table",
          ),
          tabPanel(
            title = "Model",
          )
        ),
        box(
          width = 12,
          dataTableOutput("select_table")
        )
      )

    )
  )
)
