
install.packages('quanteda')
library(quanteda)
install.packages('quanteda.textplots')
library("quanteda.textplots")
install.packages('quanteda.textstats')
library("quanteda.textstats")

library(tidyverse)
url = 'https://bit.ly/2QoqUQS'
data = read_csv(url)
head(data) 


corp <- corpus(data, text_field = 'text')
corp

class(corp)

#DOCUMENT TERM MATRIX

dtm <-  dfm(corp, stem=T, remove = stopwords('en'), remove_punct=T, tolower = TRUE )
dtm
 
dtm <- dfm_trim(dtm, min_termfreq = 10)
dtm

#WORD CLOUD

textplot_wordcloud(dtm, max_words=50)
textstat_frequency(dtm, n=10)


#Conditional word cloud
m_GW <-  dfm_subset(dtm, President=="George Washington")
m_postwar <-  dfm_subset(dtm, date > 1945)


textplot_wordcloud(m_postwar, max_words = 25)

#Keywords in context
#for entire data
head( kwic(corp, 'state*'), 5)

is_GW <- docvars(dtm)$President == 'George Washington'
ts <- textstat_keyness(dtm, is_GW)
head(ts, 10)

tail(ts, 10)
