library(shiny)
library(Hmisc)
options(shiny.trace=TRUE)

source('shinyExtras.R')

shinyServer(function(input, output) {
  output$tab1 <- reactiveText(function(){
    'Tab 1 Output'
  })

  output$tab2 <- reactiveText(function(){
    'Tab 2 Output'
  })

  # reactiveRmd returns a function that will return the output of knit2html
  # on the Rmd file. Additionally it will only re-run knit2html if the Rmd file
  # has changed.
  teachingRmd <- reactiveRmd('teaching.Rmd',input)

  output$teaching <- reactive(function(){
    # Only call our reactive Rmd function when our tab is visible
    if (input$visibleTab=='NormalDist')
      teachingRmd() # returns the HTML
    else
      NULL
  })

  output$catMu <- reactive(function(){ input$mu })

  output$catSigmaSqr <- reactive(function(){ input$sigmaSqr })

  output$NormalDistPlot <- reactivePlot(function(){
    if (is.null(input$mu) || is.null(input$sigmaSqr)) return()
    x <- seq(-5,5,0.1)
    par(mar=c(2,2,0,0))
    par(yaxp=c(0,1,10))
    plot(c(-5,5),c(0,1),type='n',xlab=NA,ylab=NA,bty='n')
    lines(x,dnorm(x,mean=input$mu,sd=sqrt(input$sigmaSqr)),type='l')
  },400,400)
})
