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
      h2("Analysis"),
      box(
        title = "Movies",
        status = "primary",
        width = 6,
        plotOutput(outputId = "scatter")
      )
    )

  )
)
