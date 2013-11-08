library(shiny)
source('shinyExtras.R')

#shinyUI(pageWithSidebar(
#
#   customHeaderPanel("Normal Distribution"),
#
#   sidebarPanel(),
#
#   mainPanel(
#      tabsetPanel(
#         tabPanel("NormalDist",htmlOutput('teaching')),
#         tabPanel("Tab1",verbatimTextOutput('tab1')),
#         tabPanel("Tab2",verbatimTextOutput('tab2')),
#         id='visibleTab'
#      )
#   )
#))

shinyUI(basicPage(
  customHeaderPanel("Normal Distribution"),
  htmlOutput('teaching')
  )
)

