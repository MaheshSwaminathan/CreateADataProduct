library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Miles Per Gallon Regression Feature Selection"),

  # Sidebar with controls to select the variables to regress against mpg
  sidebarPanel(
      checkboxGroupInput("variables", h3("Select variables:"),
                         list("Weight" = "wt",
                              "Horsepower" = "hp",
                              "Transmission" = "am"),
                         selected="wt"),

      h3(helpText("Documentation")),
      helpText(paste("This simple app allows a user to select features",
                     "from the mtcars dataset to regress against mpg.",
                     "The plots and summary table show the goodness of fit",
                     "and leverage measures.",
                     "Choices available are any combination of wt, hp, and am variables."))
  ),

  # Show the caption and plot of the requested variable against mpg
  mainPanel(
      h3(textOutput("caption")),

      plotOutput("mpgPlot"),

      tableOutput("summary")
  )
))
