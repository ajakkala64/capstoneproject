options( java.parameters = "-Xmx4g" )
libs <- c("tm","plyr","class","stringr")
lapply(libs,require,character.only=TRUE)
options(stringsAsFactors = FALSE)

#
bigramDir <-"C:/TOOLS/DataScienceCourceWork/capstone-project/Coursera-SwiftKey/final/en_US/bigram/"
trigramDir <-"C:/TOOLS/DataScienceCourceWork/capstone-project/Coursera-SwiftKey/final/en_US/trigram/"

fnews = "en_US.news.csv"
ftwit = "en_US.twitter.csv"
fblog = "en_US.blogs.csv"
#
mergeNgram <- function(dir,mfile,cfilter)
{
  newsFile <- paste0(dir,fnews)
  blogFile <- paste0(dir,fblog)
  twitFile <- paste0(dir,ftwit)
  
  df1 <- read.csv(blogFile)
  df1 <- df1[as.numeric(df1$Freq) > cfilter, ]
  df2 <- read.csv(twitFile)
  df2 <- df2[as.numeric(df2$Freq) > cfilter, ]
  df3 <- read.csv(newsFile)
  df3 <- df3[as.numeric(df3$Freq) > cfilter, ]
  df4 <- rbind(df1,df2)
  df5 <- rbind(df4,df3)
  
  rData <- paste0(dir,mfile)
  saveRDS(df5,file=rData)
}

mergeNgram(bigramDir,"en_US.bigram.Rdata",3)
mergeNgram(trigramDir,"en_US.trigram.Rdata",3)