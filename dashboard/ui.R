ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),

  ## Sidebar content -----------------------------------------------------------
  dashboardSidebar(

    sidebarMenu(
      menuItem(text = "Analysis", tabName = "analysis", icon = icon("fa-line-chart", lib = "font-awesome"))
    )

  ),

  ## Body content --------------------------------------------------------------
  dashboardBody(

    ## Analysis content --------------------------------------------------------
    tabItem(
      tabName = "analysis",
      box(
        title = "Movies",
        status = "primary",
        width = 6,
        height = "500px",
        plotOutput(outputId = "scatter")
      ),
      tabBox(
        width = 6,
        height = "500px",
        tabPanel(
          title = "Movie info"
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
