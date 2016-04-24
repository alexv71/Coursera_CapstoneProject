######################################################
## Coursera Data Science Capstone Project
## Aleksandr Voishchev
## 23/04/2016
## This is the model output functions
######################################################

library(quanteda)

# Load profanity words...
profanities <- read.csv("profanity.txt", header = FALSE, stringsAsFactors = FALSE)
profanities <- profanities$V1

# Load raw texts from files...
loadText <- function(fileName) {
        fh <- file(fileName, open="rb")
        text <- readLines(fh, encoding="UTF-8")
        close(fh)
        text
}

# Clean input texts...
cleanText<- function(text) {
# Erase non-ASCII characters.
        text <- unlist(lapply(text, FUN=iconv, to='ASCII', sub=' '))
# Erase or replace some symbols
        text <- gsub(",?", "", text)
        text <- gsub("\\#", "", text)
        text <- gsub("\\@", " as ", text)
        text <- gsub("\\:", "", text)
# Split on  question marks or exclamation marks
        text <- strsplit(unlist(text),"[\\.]{1}")
        text <- strsplit(unlist(text),"\\?+")
        text <- strsplit(unlist(text),"\\!+")
        text <- strsplit(unlist(text),"\\-+")
# Split on parentheses
        text <- strsplit(unlist(text),"\\(+")
        text <- strsplit(unlist(text),"\\)+")
# Split on quotation marks
        text <- strsplit(unlist(text),"\\\"")
# Remove spaces at start and end of sentences
        text <- gsub("^\\s+", "", text)
        text <- gsub("\\s+$", "", text)
# Replace ~ and any whitespace
        text <- gsub("\\s*~\\s*", " ", text)
# Replace forward slash with space
        text <- gsub("\\/", " ", text)
# Replace + signs with space
        text <- gsub("\\+", " ", text)
# Eliminate empty and single letter values
        text <- text[which(nchar(text)!=1)]
        text <- text[which(nchar(text)!=0)]
        text
}

# Tokenize input text to sentences and remove profanities...
makeSentences <- function(text) {
        output <- tokenize(text, what = "sentence", removeNumbers = TRUE,
                           removePunct = TRUE, removeSeparators = TRUE,
                           removeTwitter = TRUE, removeHyphens = TRUE)
        output <- removeFeatures(output, profanities)
        unlist(output)
}

# Tokenize input text to words...
makeTokens <- function(text, n = 1L) {
        tokenize(text, what = "word", removeNumbers = TRUE,
                 removePunct = TRUE, removeSeparators = TRUE,
                 removeTwitter = FALSE, removeHyphens = TRUE,
                 ngrams = n, simplify = TRUE)
}
