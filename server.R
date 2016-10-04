######################################################
# Predict next word - Coursera Data science capstone project.
# Author: Jayarama Ajakkala
# 
libs <- c("shiny","stringr")
lapply(libs,require,character.only=TRUE)
options(stringsAsFactors = FALSE)

## global
##
writeLines("Loading data ..")
bigramFile <- "en_US.bigram.Rdata"
trigramFile <- "en_US.trigram.Rdata"
bigramDf <- readRDS(bigramFile)
trigramDf <- readRDS(trigramFile)

writeLines("Done loading data.")


## clean phrase
##
cleanText <- function(inText)
{
   ctext <- sapply(inText,tolower)
   ctext <- str_replace_all(ctext, "[^[:alnum:]]", " ")
   ctext <- gsub("\\s+", " ", str_trim(ctext))
   ctext <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", ctext)
   return(ctext)
}

## find next word
##
findNextWord <- function(phrase)
{
# clean input text
  cleanText <- cleanText(phrase)
  writeLines(paste0("Clean phrase:",cleanText))
  if (is.null(cleanText) || nchar(cleanText) < 1)
  {
    return ('Try again ...')
  }
  
  words <- strsplit(cleanText," ")[[1]]
  nwords <- length(words)
  lastWord <- words[nwords]
  
  if (nwords < 2)                           # match bigram model
  {
    writeLines("Applying bigram model.")
    phraseLast <- paste0(lastWord, " ")     # add a space to skip matching last word
    matchDf <- bigramDf[grepl(paste0('\\<',phraseLast), bigramDf$ngram),]
  }
  else                           # match trigram model
  {
    writeLines("Applying trigram model.")
    phraseLast <- paste0(words[nwords -1]," ",lastWord)  #take last 2 words.
    phraseLast <- paste0(phraseLast, " ")                    # add a space to skip matching last word
    matchDf <- trigramDf[grepl(paste0('\\<',phraseLast), trigramDf$ngram),]
    if (is.null(matchDf))  # apply Backoff model
    {
      writeLines("Trigram match failed, now wrying with backoff model")
      phraseLast <- paste0(lastWord," ")
      matchDf <- bigramDf[grepl(paste0('\\<',phraseLast), bigramDf$ngram),]
    }
  }

  if (is.null(matchDf))
  {
    writeLines("No match found.")
    return('Try again ...')
  }

  sortedDf <- matchDf[ order(-matchDf$Freq),]
  writeLines(paste0("Frequency:",sortedDf$Freq[1]))
  matchStr <- sortedDf$ngram[1]
  writeLines(paste0("Match phrase:",matchStr))
  matchWord <- strsplit(matchStr," ")[[1]]
  
  wordIdx <- which(matchWord == lastWord)
  return(matchWord[wordIdx+1])
}

## shiny server
##
shinyServer(
  function(input, output,session) {
    
    observeEvent(input$nextBtn, {
      writeLines(paste0("Phrase:", input$phrase))
      nextword <- findNextWord(input$phrase)
      writeLines(paste0("Next word:",nextword))
      output$nextword  <- renderText(nextword)
    })
    
    observeEvent(input$clearBtn, {
      updateTextInput(session, "phrase", value=paste(""))
      output$nextword <- renderText(" ")
    })
  }
)