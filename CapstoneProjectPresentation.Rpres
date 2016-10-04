Coursera Data Science Capstone Project
========================================================
author: Jayarama Ajakkala
date:   10/03/2016

An overview of the next word prediction data product. 

Objective
========================================================

Goal of this project is to build a predictive model to predict next word using a large corpus of unstructured text. This has been developed to demostrate the data science skills acquired thorugh the data scinece specialization. 
- Dowload corpus of text data. Clean and sample the data to train the prediction model.
- Develop prediction model using Markov's backoff model. Generate bi-gram, tri-gram models using the corpus. Sample the data for performance with reasonable accuracy.
- Develop a shiny app to provide user interface to end-user to predict the next word based on input phrase.

Predictive Model
========================================================
The data is from a corpus called HC Corpora (www.corpora.heliohost.org). Prediction model is based N-Gram prediction algorithm.
- English language text is taken from news, blogs and twitter. Data is cleaned by removing non-alpha characters and converting into lower case before used to train the model.
- Bi-gram and Tri-gram prediction models are generated. Used R package [ tm ]  to generate n-gram models.
- N-gram prediction model is sampled based on probablity rank of the n-gram word sequence. Frequency lower than three are filtered for performance and a reasonalble accuracy.
- Katz's back-off model used for smoothing. Input phrase is first validated in trigram and next in bigram model.

Next Word Prediction App
========================================================
Data product is developed using R shiny package. Application is hosted in shinyapp server. Application can be accessed using the url "https://ajakkala64.shinyapps.io/nextword/" Application will present a input box to enter a phrase. Upon clicking the "Next" buttion, predicted next word will be displayed next. 

![Next Word App](nextword.jpg)

Additional Information
========================================================
- Application url

   https://ajakkala64.shinyapps.io/nextword/
- Source repository GitHub url
   https://github.com/ajakkala64/capstoneproject
- Presentation rpubs location
  http://rpubs.com/ajakkala/capstoneproject

  
