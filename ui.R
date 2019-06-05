library(shiny)
library(shinydashboard)

data_new <- read.csv("Final_Project_data.csv")
data_1 <-
  data_new[c(
    'Type',
    'Age',
    'Breed1',
    'MaturitySize',
    'AdoptionSpeed',
    'Fee',
    'Gender',
    'Vaccinated',
    'Sterilized'
  )]


ui <- dashboardPage(
  dashboardHeader(title = "How has the adoption speed of pets has influenced", titleWidth = 350),
  dashboardSidebar(
    sliderInput(
      inputId = "num",
      label = "Choose a fee option",
      value = c(50,100),
      min = min(data_1$Fee),
      max = max(data_1$Fee)
    ),
    actionButton(inputId = "go",
                 label = "update"),
    selectInput(
      inputId = "Adoption_Speed",
      label = " select the Adoption parameter",
      choices =  c('1', '2', '3', '4')
    ),
    
    actionButton(inputId = "go1",
                 label = "Change"),
    width = 350
  ),
  dashboardBody(
    box(plotOutput("scatt"),
        verbatimTextOutput("stats")),
    box(plotOutput("table"),
        verbatimTextOutput("print"))
  )
)
