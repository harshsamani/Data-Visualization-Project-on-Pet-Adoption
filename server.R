setwd("C:\\Users\\User\\Desktop\\New folder")
library(shiny)
library(ggplot2)
library(dplyr)

server <- function(input, output)
{
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
  
  #data <- reactive({ input$num })
  
  data <- eventReactive(input$go, {
    (input$num)
  })
  data_2 <-
    reactive ({
      a <- data_1[(data_1$AdoptionSpeed %in% (input$Adoption_Speed)),]
      return(a)
    })
  adoption <- eventReactive(input$go1, {
    (input$Adoption_Speed)
  })
  
  
  #output$print <- renderPrint({ print("Summary According to neibourhood")})
  output$stats <-
    renderPrint({
      print("Summary According to AdoptionSpeed :")
      print(input$Adoption_Speed)
      summary(data_2()$Fee)
    })
  output$table <- renderPlot({
    pairs.panels(data_1)
  })
  output$scatt <-
    renderPlot({
      ggplot(data_2(), aes(x = Fee, y = Age, col = AdoptionSpeed)) +
        geom_point(col = "darkblue", size = 3) + xlim(data()) + xlab("Fee") +
        theme(
          axis.text = element_text(size = 10, face = "bold"),
          axis.title.y = element_text(size = rel(1.5), face = "bold"),
          axis.title.x = element_text(size = rel(1.5), face = "bold")
        )
    })
  
}
