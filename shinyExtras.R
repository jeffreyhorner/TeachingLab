library(brew)
library(knitr)
library(markdown)
options(markdown.HTML.options=c('fragment_only','base64_images'))

spanOutput <- function(id){
  paste('<span id="',id,'" class="shiny-text-output shiny-bound-output"></span>',sep='')
}

customHeaderPanel <- function(title,windowTitle=title){
    tagList(
       tags$head(
          tags$title(windowTitle),
          tags$link(rel="stylesheet", type="text/css",
                  href="app.css"),
          tags$link(rel="stylesheet", type="text/css",
                  href="markdown.css"),
          tags$link(rel="stylesheet", type="text/css",
                  href="rsyntax.css"),
          tags$script(src="rsyntax.js"),
          tags$script(src="https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
       ), 
       div(class = "span12", style = "padding: 10px 0px;", h1(title))
    )
}

# Reactive on file content change, not the input values.
reactiveRmd <- function(file,input){
   forceMathJax <- tags$script("MathJax.Hub.Queue([\"Typeset\",MathJax.Hub]);$('pre code').each(function(i, e) {hljs.highlightBlock(e)});")
   fileMTIME <- file.info(file)$mtime
   brew(file,output=textConnection("brewOutput","w"),envir=parent.frame())
   htmlContent <- paste(try(knit2html(text=brewOutput)),forceMathJax,sep="\n")
   function(){
      newMTIME <- file.info(file)$mtime
      if (newMTIME > fileMTIME){
         fileMTIME <<- newMTIME
         brew(file,output=textConnection("brewOutput","w"))
         htmlContent <<- paste(try(knit2html(text=brewOutput)),forceMathJax,sep="\n")
      }
      htmlContent
   }
}
