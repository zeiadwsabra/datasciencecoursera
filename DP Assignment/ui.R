#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(leaflet)
library(readr)
  
# Define UI for application that draws a histogram
dataset <-   read_csv(file="data.zip")
dataset$Year= as.factor(dataset$Year)
shinyUI(fluidPage(
  
  title = "San Francisco Crime Data",
  
  leafletOutput('mymap'),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Crime Type"),
           br(),
           checkboxInput('ASSAULT', 'ASSAULT'),
           checkboxInput('ROBBERY', 'ROBBERY'),
           checkboxInput('LARCENY', 'LARCENY/THEFT'),
           checkboxInput('VEHICLE', 'VEHICLE THEFT')
    ),
    column(4, offset = 1,
           selectInput('year', 'Year', levels(dataset$Year)),
           submitButton("Plot")
    )
  )
))
