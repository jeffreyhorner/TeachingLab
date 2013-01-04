library(knitr)
library(markdown)
options(markdown.HTML.options=c('fragment_only',markdownHTMLOptions(TRUE)))

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

reactiveRmd <- function(file,input){
   forceMathJax <- tags$script('MathJax.Hub.Queue(["Typeset",MathJax.Hub]);')
   fileMTIME <- file.info(file)$mtime
   knit2html(file)
   htmlContent <- paste(readLines(sub('.Rmd','.html',file)),forceMathJax,collapse="\n",sep="\n")
   function(){
      newMTIME <- file.info(file)$mtime
      if (newMTIME > fileMTIME){
         knit2html(file)
         paste(readLines(sub('.Rmd','.html',file)),forceMathJax,collapse="\n",sep="\n")
         fileMTIME <<- newMTIME
         htmlContent <<- paste(readLines(sub('.Rmd','.html',file)),forceMathJax,collapse="\n",sep="\n")
      }
      htmlContent
   }
}
