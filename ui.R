library(shiny)
library(tidyverse)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  textInput("cor_guess", "Guess the correlation!"),
  actionButton(
    inputId = "submit_guess",
    label = "Submit Guess"
  ),
  plotOutput("graph"),
  textOutput("message"),
  actionButton("reset_input", "Press to Play Again!")
)