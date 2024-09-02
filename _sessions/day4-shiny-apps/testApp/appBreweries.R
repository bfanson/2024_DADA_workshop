library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(mapview)

# Load the breweries dataset from mapview
data("breweries", package = "mapview")

# Define UI for the app
ui <- fluidPage(
  titlePanel("Breweries in the USA"),
  sidebarLayout(
    sidebarPanel(
      selectInput("state", "Select a state:", choices = unique(breweries$state))
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server logic for the app
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles()
  })
  
  observe({
    filteredData <- breweries %>% filter(state == input$state)
    
    leafletProxy("map", data = filteredData) %>%
      clearMarkers() %>%
      addCircleMarkers(
        lng = ~st_coordinates(geometry)[,1], 
        lat = ~st_coordinates(geometry)[,2],
        popup = ~paste(brewery, "<br>", village, "<br>", state)
      )
  })
}

# Run the app
shinyApp(ui, server)

