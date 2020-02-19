install.packages('NLP'); 
install.packages('RColorBrewer')
library(twitteR); library(ROAuth); library(base64enc); library(httpuv); 
library(tm)
library(SnowballC); library(wordcloud); library(RColorBrewer)
library(twitteR)
apiKey = "WiR17LsF4t4kkWsraWOMJyga9"
apiSecret = "d1MdUbazO3Ia2swnI9C10Jel7NepOqZtlAO5YM3d1JI3aAIoV8"
accessToken = "998472200721068032-DQTZOe7DJJK0wa1uynIVKnJeVDm9FXT"
accessTokenSecret = "JJodl4JWlfNH5WTU2QRtvg3xhgF7PRdKBXEuEIdUN1Jfk"

setup_twitter_oauth(apiKey,apiSecret, accessToken, accessTokenSecret)

setup_twitter_oauth(apiKey,apiSecret, accessToken, accessTokenSecret)

matchTweets = searchTwitter("lg washing machine", n = 1500, lang = 'en', resultType = "recent")
insta_text = sapply(matchTweets, function(x) x$getText())
insta_text_corpus <- Corpus(VectorSource(insta_text))
insta_text_corpus <- tm_map(insta_text_corpus, removePunctuation)
insta_text_corpus <- tm_map(insta_text_corpus, content_transformer(tolower))
insta_text_corpus <- tm_map(insta_text_corpus, function(x) removeWords(x, stopwords()))
insta_text_corpus <- tm_map(insta_text_corpus, removeWords, c("RT", "are", "that","\u23f0 ","$"))
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x)
insta_text_corpus <- tm_map(insta_text_corpus, content_transformer(removeURL))

insta_2 <- TermDocumentMatrix(insta_text_corpus)
insta_2 <- as.matrix(insta_2)
insta_2 <- sort(rowSums(insta_2), decreasing = T)
insta_2 <- data.frame(word = names(insta_2), freq = insta_2)
head(insta_2, 10)

barplot(insta_2[1:10,]$freq, las = 2, names.arg = insta_2[1:10,]$word, col = "pink", main = "Most Frequent Words", ylab = "Word frequencies")

set.seed(1234)
wordcloud(insta_text_corpus, min.freq = 1, max.words = 80, scale = c(2.2,1), colors = brewer.pal(8, "Dark2"), random.color = T, random.order = F)


# myCorpus = tm_map(myCorpus, content_transformer(gsub), pattern = "\\W", replace =" ")
# removeURL = function(x) gsub("http[^[:space:]]*", "", x)
# myCorpus <- tm_map(myCorpus, content_transformer(removeURL))
# myCorpus <- tm_map(myCorpus, content_transformer(tolower))
# removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "",x)
# myCorpus <- tm_map(myCorpus, content_transformer(removeNumPunct))
# myCorpus <- tm_map(myCorpus, removePunctuation)
# myCorpus <- tm_map(myCorpus, removeNumbers)
# myCorpus <- tm_map(myCorpus, removeWords, stopwords("english"))
# myCorpus <- tm_map(myCorpus, stripWhitespace)

wordcloud(words = d)
