######################################################
## Coursera Data Science Capstone Project
## Aleksandr Voishchev
## 23/04/2016
## This is the user-interface definition of a Shiny web application.
######################################################

library(markdown)
library(shiny)

shinyUI(fluidPage(
# Set the page title
title = "Coursera Data Science Capstone Project",
titlePanel("Coursera Data Science Capstone Project"),
fixedRow(
        column(4, style = "background-color:#dddddd;",
               br(),
               textInput("inText",
                         h5("Input the sentence:"),
                         ""),
               strong(textOutput('outText')),
               tags$head(tags$style("#outText{color: red;
                                 font-size: 20px;
                                 }"
               )),
               br()
        ),
        column(8, 
               tabsetPanel(
                       tabPanel("Getting started", 
                                includeMarkdown("README.md")
                       ),
                       tabPanel("Information", 
                                includeMarkdown("INFO.md")
                       ))
        )
)))

