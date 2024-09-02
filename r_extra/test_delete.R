library(shiny)
library(plotly)
library(tidyverse)

v_cyl <- unique(mtcars$cyl)

ui <- fluidPage(
  headerPanel('Best example'),
  sidebarPanel(
    selectInput('cyl','Cylinders', v_cyl, selected=v_cyl[1]),
    selectInput('x','X Variable', names(mtcars), selected=names(mtcars)[[4]]),
    selectInput('y','Y Variable', names(mtcars), selected=names(mtcars)[[1]])
  ),
  mainPanel(
    plotOutput('plot')
  ),
  fluidRow(
    column(3,tableOutput( 'table' ))
  )
)

server <- function(input, output) {
  d_filter <- reactive( filter(mtcars, cyl==input$cyl ) )

  output$table <- renderTable( d_filter()    )
  
  output$plot <- renderPlot({
    # ggplot(mtcars %>% filter(cyl==input$cyl), aes( get(input$x), get(input$y) ) ) + geom_point() +
    #   labs( x=input$x, y=input$y )
    # ggplot( d_filter(), aes( .data[[input$x]], .data[[input$y]] ) ) + geom_point() +
    #   labs( x=input$x, y=input$y )
    d <- select(d_filter(), all_of( c(input$x, input$y) ) )
    plot( d[,1],d[,2] )
  })
  
}

shinyApp(ui,server)