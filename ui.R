library(shiny)
source('shinyExtras.R')

shinyUI(pageWithSidebar(

   # Application title
   customHeaderPanel("Application Title Here"),

   sidebarPanel(
      helpText("Inputs Here")
   ),

   mainPanel(
      tabsetPanel(
         tabPanel("Teaching",htmlOutput('teaching')),
         tabPanel("Tab1",verbatimTextOutput('tab1')),
         tabPanel("Tab2",verbatimTextOutput('tab2')),
         id='visibleTab'
      )
   )
))
