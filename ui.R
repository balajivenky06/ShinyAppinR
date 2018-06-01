#reactive values act as data streams that flow through your app, the input list is a list of reactive values 
#The values show current state of inputs,  


# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

if (!require(udpipe)){install.packages("udpipe")}
if (!require(stringr)){install.packages("stringr")}
if (!require(shiny)){install.packages("shiny")}
if (!require(textrank)){install.packages("textrank")}
if (!require(lattice)){install.packages("lattice")}
if (!require(igraph)){install.packages("igraph")}
if (!require(ggraph)){install.packages("ggraph")}
if (!require(wordcloud)){install.packages("wordcloud")}
if (!require(readtext)){install.packages("readtext")}


library(shiny)
library(udpipe)
library(textrank)
library(lattice)
library(igraph)
library(ggraph)
library(ggplot2)
library(wordcloud)
library(stringr)


# Define UI for application that draws a histogram
shinyUI(
   fluidPage(
  
    ##today's date
     dateInput("date6", "Date:",
               startview = "decade"),
     ##current time
     h2(textOutput("CurrentTime")),
  # Application title
  titlePanel("UDPipe Text Analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # Input: for uploading a file ----
      #fileInput(inputId= "file1", "Choose Text File", accept=c('text/csv','text/comma-separated-values,text/plain','.csv')),
      fileInput("file1", "Choose Text File"),
      # Horizontal line ----
      tags$hr(),
      
      ##checkbox input
      checkboxGroupInput("myupos",label = h4("Parts Of Speech to Show:"),
                         c("Adjective" = "ADJ",
                           "Propernoun" = "PROPN",
                           "Adverb" = "ADV",
                           "Noun" = "NOUN",
                           "Verb"= "VERB"),
      selected = c("ADJ","NOUN","VERB"),
      width = '100%'
      ),
      
      sliderInput("freq", "Minimum Frequency in Co-Occurance Graph:", min = 0,  max = 50, value = 30),
      sliderInput("freq1", "Minimum Frequency in wordcloud:", min = 0,  max = 50, value = 5),
      sliderInput("max1", "Maximum no of words in wordcloud:", min = 1,  max = 300, value = 100)
      ),
mainPanel(
  tabsetPanel(type = "tabs",
              tabPanel("Overview",h2(p("App Overview")),
                       p("This application is developed by Balaji Venktesh, Gireesh Sundaram and Vineet Kapoor as part of ISB CBA Text Analytics Assignment"),
                       p("This app supports only text files. Ensure the data input is in *.txt notpad format ", align = "justify"),
                       p("Please refer to the link below for sample text file."),
                       a(href="https://raw.githubusercontent.com/balajivenky06/ShinyAppinR/master/nokia.txt"
                         ,"Sample data input file"),   
                       br(),
                       h4("Pupropse of this app"),
                       p("To make use of udpipe for making annotation table, wordclouds and co-occurence graphs"),
                       h4("what precaution to take"),
                       p("Please upload the text files first and then move on to tabs.")
              ),
              tabPanel("Annotate",dataTableOutput('Annotate')),
              tabPanel("Co-Occurance Plot", plotOutput("Cooccurance")),
              tabPanel("wordclouds",
                       h4("Nouns"),
                       plotOutput('plot1'),
                       h4("Verbs"),
                       plotOutput('plot2'),
                       h4("Adverbs"),
                       plotOutput('plot3'),
                       h4("Adjectives"),
                       plotOutput('plot4'))
  
              )

  
)

)
))