######################################################
## Coursera Data Science Capstone Project
## Aleksandr Voishchev
## 23/04/2016
## This is the model output functions
######################################################

library(quanteda)
library(data.table)

freq_2345 <- readRDS(file="./freq_2345.RDS")

getNgramBackoff <- function(text) {
        maxNgram <- 4 
        numResults <- 4
        text <- tolower(text)
        sentence <- tokenize(text, what = "word", removeNumbers = TRUE,
                           removePunct = TRUE, removeSeparators = TRUE,
                           removeTwitter = TRUE, removeHyphens = TRUE)
        sentence <- unlist(sentence[1])

        for (i in min(length(sentence), maxNgram):1) {
                ngram <- paste(tail(sentence, i), collapse=" ")
                
                predicted <- freq_2345[freq_2345$pre == ngram,]                
                if (nrow(predicted) > 0) 
                        return(as.array(head(predicted$out, numResults)))
        }
        
        return(as.array(c('the', 'on', 'a')))
}
