#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Workshop Survey"),
  dashboardSidebar(disable = F),
  dashboardBody(
    fluidRow(
      box( title= textOutput( 'text' ),status='primary', solidHeader = TRUE )
    ),
    fluidRow(
      box(title = "Survey", status = "primary", solidHeader = TRUE, width = 12,
          textInput("name", "Name:"),
          radioButtons("rating", "How would you rate the workshop?",
                       choices = list("Excellent" = 1, "Good" = 2, "Average" = 3, "Poor" = 4)),
          checkboxGroupInput("topics", "Which topics were most useful?",
                             choices = list("Topic 1" = "topic1", "Topic 2" = "topic2", "Topic 3" = "topic3")),
          radioButtons("ai_useful", "Was AI useful in this course?",
                       choices = list("Yes" = "yes", "No" = "no")),
          radioButtons("q3", "could this be improved?",
                       choices = list("Yes" = "yes", "No" = "no","Maybe"="maybe")),
          textAreaInput("comments", "Additional Comments:", ""),
          actionButton("submit", "Submit"),
          dataTableOutput("table")
      )
    )
  )
)


server <- function(input, output, session) {
  output$text <- renderText( glue::glue('HELLO {input$name}') )
  output$table <- renderDataTable(data.frame(rating=input$ai_useful, ai=input$ai_useful))
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you!",
      "Your responses have been recorded.",
      easyClose = TRUE,
      footer = NULL
    ))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
