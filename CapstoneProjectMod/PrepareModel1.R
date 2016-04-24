######################################################
## Coursera Data Science Capstone Project
## Aleksandr Voishchev
## 23/04/2016
## This is the model creation script
######################################################

library(data.table)

source("textfunctions.R")

# Load text files...
blogsData<-loadText("./data/en_US/en_US.blogs.txt")
newsData<-loadText("./data/en_US/en_US.news.txt")
twitterData<-loadText("./data/en_US/en_US.twitter.txt")

# Create samples from all sources 3%...
set.seed(2571)
blogsSample <- cleanText(sample(blogsData, length(blogsData) * 0.03, replace = FALSE))
newsSample <- cleanText(sample(newsData, length(newsData) * 0.03, replace = FALSE))
twitterSample <- cleanText(sample(twitterData, length(twitterData) * 0.03, replace = FALSE))

# Create quanteda corpus...
bcorpus <- corpus(blogsSample)
ncorpus <- corpus(newsSample)
tcorpus <- corpus(twitterSample)

rm(blogsData, newsData, twitterData)
rm(blogsSample, newsSample, twitterSample)

# Tokenize and make ngrams...
sentences <- makeSentences(bcorpus + ncorpus + tcorpus)
rm(bcorpus, ncorpus, tcorpus)

ngram1 <- makeTokens(sentences, 1)
ngram2 <- makeTokens(sentences, 2)
ngram3 <- makeTokens(sentences, 3)
ngram4 <- makeTokens(sentences, 4)
ngram5 <- makeTokens(sentences, 5)

rm(sentences)

# Create document-frame matrices...
dfm1 <- dfm(ngram1, ignoredFeatures = profanities)
dfm2 <- dfm(ngram2, ignoredFeatures = profanities)
dfm3 <- dfm(ngram3, ignoredFeatures = profanities)
dfm4 <- dfm(ngram4, ignoredFeatures = profanities)
dfm5 <- dfm(ngram5, ignoredFeatures = profanities)

rm(ngram2, ngram3, ngram4, ngram5)

# Create and clean data.tables...
dt1 <- data.table(word = features(dfm1), freq = colSums(dfm1), key = "word")
dt2 <- data.table(word = features(dfm2), freq = colSums(dfm2), key = "word")
dt3 <- data.table(word = features(dfm3), freq = colSums(dfm3), key = "word")
dt4 <- data.table(word = features(dfm4), freq = colSums(dfm4), key = "word")
dt5 <- data.table(word = features(dfm5), freq = colSums(dfm5), key = "word")

rm(dfm2, dfm3, dfm4, dfm5)

dt1[,word:=gsub("_", " ", word)]
dt2[,word:=gsub("_", " ", word)]
dt3[,word:=gsub("_", " ", word)]
dt4[,word:=gsub("_", " ", word)]
dt5[,word:=gsub("_", " ", word)]

# Nake ngram models...
makeNgramModel <- function(dt) {
        dt[, c("pre", "out") := list(unlist(strsplit(word, "[ ]+?[a-z']+$")), 
                                     unlist(strsplit(word, "^([a-z']+[ ])+"))[2]), by=word]
}

makeNgramModel(dt1)
makeNgramModel(dt2)
makeNgramModel(dt3)
makeNgramModel(dt4)
makeNgramModel(dt5)

dt1 <- dt1[order(-freq)]
dt2 <- dt2[order(-freq)]
dt3 <- dt3[order(-freq)]
dt4 <- dt4[order(-freq)]
dt5 <- dt5[order(-freq)]

# Combine models and save entire model to file...
freq_2345 <- rbind(dt2, dt3, dt4, dt5)
freq_2345 <- freq_2345[, ngram:=NULL]
saveRDS(freq_2345, file="freq_2345.RDS")
