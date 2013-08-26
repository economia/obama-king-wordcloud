library(tm)
library(wordcloud)
library(RColorBrewer)

rec <- readLines("obama.txt")
rec  <- data.frame(rec[rec!=""])
rec.corpus <- Corpus(DataframeSource(data.frame(rec[ ,1])))
rec.corpus <- tm_map(rec.corpus, removePunctuation)
rec.corpus <- tm_map(rec.corpus, tolower)
rec.corpus <- tm_map(rec.corpus, function(x) removeWords(x, stopwords("english")))

tdm <- TermDocumentMatrix(rec.corpus)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

pal2 <- brewer.pal(8,"Dark2")
png("obama.png", width=1280,height=800)
wordcloud(d$word,d$freq, scale=c(8,.2),min.freq=1,
          max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()