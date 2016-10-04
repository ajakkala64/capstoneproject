# Predict next word - Coursera Data science capstone project.
# Author: Jayarama Ajakkala
# 
library(shiny)

shinyUI(
  fluidPage(
    titlePanel(div("Predict Next Word App - Data Science Project",
                   style="font-size:24px;text-shadow:4px 4px 4px #013ADF;")),
    br(),
    tabsetPanel(
      tabPanel(HTML("<strong>Predict Next Word</strong>"),
       fluidRow(
        column(6, div(style = "border-radius: 10px;height:250px;background-color: #E5E4F7;box-shadow: 5px 5px;", "",
                   tags$head(
                     tags$style(type="text/css", ".well { margin-left:25px;min-width: 600px; }")
                   ),
                   HTML("&nbsp;Enter a word or phrase in the input field below. Click the 'Next' button to get the next word."),
                   textInput("phrase", " ", value = "", width = "550px"),
                   HTML("<strong>&nbsp;Next word is:</strong>"),textOutput("nextword"),
                   HTML("<div id='waitimg' style='display:none;'><img src='2.gif'/></div>"),
                   br(),
                   div(style="display:inline-block",actionButton("nextBtn", "Next",style="color: #fff; background-color: #337ab7; border-color: #2e6da4")), 
                   div(style="display:inline-block",actionButton("clearBtn", "Clear",style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
                 )
        ),
        tags$script(HTML('document.getElementById("nextBtn").onclick = function(){document.getElementById("waitimg").style.display="none";}')),
        column(3,"")
       )
      ),
      tabPanel(HTML("<strong>About</strong>"),
               fluidRow(
                 column(6,div(style = "height:250px;background-color: #E5E4F7;", "",
                      HTML("&nbsp;This application predicts the next word given a sentence or a phrase. 
                                 On launching the application user will be presented with the screen   
                                 to enter a sentence or a phrase. Click Next button to the get the next word. 
                                 Clear button will clear the text box to start with a new sentence. 
                                 This application has been developed to fullfill the course requirement for Coursera 
                                 Data Science Specialisation."))
                 ),
                 column(3,"")
               )
      )
    )
  )
)