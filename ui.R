library(shiny)
library(ggplot2) # diamonds dataset

dataset <- diamonds

shinyUI(pageWithSidebar(
  
  headerPanel("Estimate Diamond Prices for all cuts and colors"),
  
  sidebarPanel(
    
    sliderInput('carat', 'Diamond size (carat)', min=0, max=10,
                value=3, step=0.1),
    helpText('Use the slider to select the size')
  ),
  
  mainPanel(
    dataTableOutput("mytable")
  )
))
