#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# 1) Define extra packages and global objects (e.g. your dataset, model results, formats...)
library(shiny)
library(tidyverse)


# 2) Define UI for application [how it looks to the user]
ui <- fluidPage(    
  
)

# 3) Define server logic [steps taken when app starts and user clicks something]
server <- function(input, output) {
}

# 4) Run the application 
shinyApp(ui = ui, server = server)
