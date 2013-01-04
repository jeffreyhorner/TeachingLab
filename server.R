library(shiny)
library(Hmisc)

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
      if (input$visibleTab=='Teaching')
         teachingRmd() # returns the HTML
      else
         NULL
   })

})
