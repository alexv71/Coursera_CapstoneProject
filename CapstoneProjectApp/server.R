######################################################
## Coursera Data Science Capstone Project
## Aleksandr Voishchev
## 23/04/2016
## This is the server logic for a Shiny web application.
######################################################

library(shiny)

source('models.R')

shinyServer(function(input, output) {
        
        output$outText <- renderText({
                getNgramBackoff(input$inText)
        })
})
