library(shiny)
library(tidyverse)

server <- function(input, output, session) {
  guess <- reactive(as.numeric(input$cor_guess))
  num_rand <- reactive(rchisq(input$num, 10))
  x <- rnorm(100, rnorm(1, 100, 50), rchisq(1, 10, 5))
  y <- sign(runif(1, -1, 1))*x + rnorm(100, 0, 10)
  DF = data.frame(x, y)
  true_cor <- cor(x, y)
  
  output$graph <- renderPlot(
    ggplot(DF, aes(x, y)) +
      geom_point(size = 3)
  )
  
  observeEvent(
    eventExpr = input[["submit_guess"]],
    handlerExpr = {
      output$message <- renderText(
        paste0("Your guess was ",guess(),".\n\n
             The true value was ", round(true_cor,3),".\n
             That is a difference of ", abs(guess() - round(true_cor,3))
               ,".")
      )
    }
  )
  
  observeEvent(input$reset_input, {
    #shinyjs::reset()
    session$reload() # Works, but won't store guesses.
  })
}