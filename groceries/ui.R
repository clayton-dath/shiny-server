library(shiny)
library(shinydashboard)

meal.list <- read.csv('data/meal.csv', fileEncoding="UTF-8-BOM")

meals <- unique(meal.list$Meal)

header <-  dashboardHeader(title = "Meal & Grocery Planner")
  
body <-  dashboardBody(
            column(width = 3,
                   box(width = NULL, status = 'primary', title = "Weekly Meals", solidHeader = TRUE,
                         selectInput('mon','Monday',meals)
                       , selectInput('tue','Tuesday',meals)
                       , selectInput('wed','Wednesday',meals)
                       , selectInput('thu','Thursday',meals)
                       , selectInput('fri','Friday',meals)
                       , selectInput('sat','Saturday',meals)
                       , selectInput('sun','Sunday',meals))
                   ),
            column(width = 9,
                   box(width = NULL, status = 'primary', title = "Grocery list", solidHeader = TRUE
                       , textOutput("test")
                       , tableOutput("grocery_list")),
                   box(width = NULL, status = 'primary', title = "Condiments", solidHeader = TRUE
                       , tableOutput("condiments"))
            )
                
            )

dashboardPage(
            header
          , dashboardSidebar(disable = TRUE)
          , body
          )

