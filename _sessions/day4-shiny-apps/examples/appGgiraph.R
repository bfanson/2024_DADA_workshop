#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggiraph)
library(tidyverse)
library(patchwork)


mtcars_db <- rownames_to_column(mtcars, var = "carname")

plotCombined <- function(d){
  # First plot: Scatter plot
  fig_pt <- ggplot(
    data = d,
    mapping = aes(
      x = disp, y = qsec,
      tooltip = carname, data_id = carname
    )
  ) +
    geom_point_interactive(
      size = 3, hover_nearest = TRUE
    ) +
    labs(
      title = "Displacement vs Quarter Mile",
      x = "Displacement", y = "Quarter Mile"
    ) +
    theme_bw()
  
  # Second plot: Bar plot
  fig_bar <- ggplot(
    data = d,
    mapping = aes(
      x = reorder(carname, mpg), y = mpg,
      tooltip = paste("Car:", carname, "<br>MPG:", mpg),
      data_id = carname
    )
  ) +
    geom_col_interactive(fill = "skyblue") +
    coord_flip() +
    labs(
      title = "Miles per Gallon by Car",
      x = "Car", y = "Miles per Gallon"
    ) +
    theme_bw()
  
  # Combine the plots using patchwork
  combined_plot <- fig_pt + fig_bar + plot_layout(ncol = 2) 
  
  # Combine the plots using cowplot
  # combined_plot <- cowplot::plot_grid(fig_pt, fig_bar, ncol=2) 
  
  # Create a single interactive plot with both subplots
  interactive_plot <- girafe(ggobj = combined_plot)
  
  # Set options for the interactive plot
  girafe_options(
    interactive_plot,
    opts_hover(css = "fill:cyan;stroke:black;cursor:pointer;"),
    opts_selection(type = "single", css = "fill:red;stroke:black;")
  )  
}


# Define UI for application that draws a histogram
ui <- fluidPage(
  fluidRow(
    column(3, 
           numericInput("n", label = "n", value = 10, min = 1, max=nrow(mtcars) )
    ),
    column(9, girafeOutput('fig_combined') 
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data <-  reactive( slice_sample(mtcars_db, n= input$n ) ) 
  
  output$fig_combined <- renderGirafe({
      d <- data()
      plotCombined( d )
      })
}# Run the application 

shinyApp(ui = ui, server = server)
