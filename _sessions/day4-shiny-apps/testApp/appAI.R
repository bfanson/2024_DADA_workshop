library(shiny)
library(ggplot2)

# Define UI for the application
ui <- fluidPage(
  titlePanel("AI will take over the biometrician's jobs"),
  sidebarLayout(
    sidebarPanel(
      selectInput("cyl", "Select number of cylinders:",
                  choices = unique(mtcars$cyl),
                  selected = unique(mtcars$cyl)[1])
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Regression Plot", plotOutput("scatterPlot")),
        tabPanel("HP Distribution", plotOutput("histPlot"))
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    # Filter the data based on the selected number of cylinders
    filteredData <- mtcars[mtcars$cyl == input$cyl, ]
    
    # Create the scatterplot with ggplot2
    ggplot(filteredData, aes(x = hp, y = mpg)) +
      geom_point() +
      geom_smooth(method = "lm", se = TRUE, color = "blue") +
      labs(title = paste("Scatterplot of hp vs mpg for", input$cyl, "cylinders"),
           x = "Horsepower (hp)",
           y = "Miles per Gallon (mpg)") +
      theme_minimal()
  })
  
  output$histPlot <- renderPlot({
    # Filter the data based on the selected number of cylinders
    filteredData <- mtcars[mtcars$cyl == input$cyl, ]
    
    # Create the histogram with ggplot2
    ggplot(filteredData, aes(x = hp)) +
      geom_histogram(binwidth = 10, fill = "grey", color = "black") +
      labs(title = "Distribution of Horsepower (hp)",
           x = "Horsepower (hp)",
           y = "Count") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)