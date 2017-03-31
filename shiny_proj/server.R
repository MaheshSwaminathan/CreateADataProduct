library(shiny)
library(datasets)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot based on the variables selected against mpg
shinyServer(function(input, output) {

  # Compute the forumla text in a reactive expression since it is
  # shared by the output$caption and output$mpgPlot expressions



    formulaText <- reactive({
      paste("mpg ~ ", paste(unlist(strsplit(input$variables, " ")), collapse=" + "))
    })

    fit <- reactive({
        lm(formulaText(), data = mpgData)
#        lm(as.formula(formulaText()), data = mpgData)
    })

  # Return the formula text for printing as a caption
    output$caption <- renderText({
        formulaText()
    })

    output$summary <- renderTable ({
        data.frame(Name=row.names(summary(fit())$coef), summary(fit())$coef, confint(fit()))
    })

    output$confint <- renderTable ({
        data.frame(Name=row.names(confint(fit())), confint(fit()))
    })

  # Generate a plot of the requested variables against mpg
    output$mpgPlot <- renderPlot({
        par(mfrow=c(2,2))
        plot(fit())
        par(mfrow=c(1,1))
    })
})
