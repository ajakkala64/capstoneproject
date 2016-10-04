options( java.parameters = "-Xmx4g" )
libs <- c("tm","plyr","class","stringr")
lapply(libs,require,character.only=TRUE)
options(stringsAsFactors = FALSE)

#
raw <- "C:/TOOLS/DataScienceCourceWork/capstone-project/Coursera-SwiftKey/final/en_US/"
bigramDir <-"C:/TOOLS/DataScienceCourceWork/capstone-project/Coursera-SwiftKey/final/en_US/bigram/"
trigramDir <-"C:/TOOLS/DataScienceCourceWork/capstone-project/Coursera-SwiftKey/final/en_US/trigram/"

fnews = "en_US.news"
ftwit = "en_US.twitter"
fblog = "en_US.blogs"
#
removeLatin <- content_transformer(function(x) iconv(x, "latin1", "ASCII", sub=" "))

cleanCorpus <- function(corpus)
{
  corpus.tmp <- tm_map(corpus, removeLatin)
  corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
  corpus.tmp <- tm_map(corpus.tmp, removePunctuation) 
  corpus.tmp <- tm_map(corpus.tmp, removeNumbers) 
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace) 
  return(corpus.tmp)
}

generateTDM <- function(path,file,n)
{
  s.cor <- Corpus(DirSource(directory=path, pattern=file))
  s.cor.cln <- cleanCorpus(s.cor)
  gc()
  BigramTokenizer <- function (x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = n, max =n))}
  s.cor.tdm  <- TermDocumentMatrix(s.cor.cln,control=list(tokenize = BigramTokenizer))
  s.cor.tdm <- removeSparseTerms(s.cor.tdm,sparse=0.7)
  return(s.cor.tdm)
  gc()
}


ngramDF <- function(ngram, count)
{
  for (idx in 1:count)
  {
     s <- str_split(ngram$ngram[idx]," ")
     mywords <- s[[1]]
     except_last <- mywords[1:length(mywords)-1]
     ngram$Key[idx] <-paste0(except_last, collapse = " ")
  }
  return(ngram)
}

process <- function(fname,dir,n)
{
    stime <- proc.time()
    file <- paste0(fname,".txt")

    tdm <- generateTDM(raw,file,n)
    ngram.mat <- as.matrix(tdm)
    ngram.df <- cbind(rownames(ngram.mat),ngram.mat[,1],rep(" "))
    ngram.df <- as.data.frame(ngram.df)
    colnames(ngram.df) <- c("ngram","Freq","Key")
    csvfile <- paste0(dir,fname,".csv")
    write.csv(ngram.df,file=csvfile,row.names=FALSE)
    print(proc.time() - stime)
}

process(fnews,bigramDir,2)
gc()
process(ftwit,bigramDir,2)
gc()
process(fblog,bigramDir,2)
gc()
process(fnews,trigramDir,3)
gc()
process(ftwit,trigramDir,3)
gc()
process(fblog,trigramDir,3)
gc()


