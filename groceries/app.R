library(shiny)
library(shinydashboard)
library(dplyr)


meal.list <- read.csv('data/meal.csv')

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
                       , dataTableOutput("grocery_list")),
                   box(width = NULL, status = 'primary', title = "Condiments", solidHeader = TRUE
                       , dataTableOutput("condiments"))
            )
                
            )

dashboardPage(
            header
          , dashboardSidebar(disable = TRUE)
          , body
          )

function(input, output) {

  meals = reactive(meal.list[,c(2,3,4,5)])
  
  grocery_list = reactive(meals()[meals()$Main.Ingredient == 'y',] %>%
                            group_by(Ingredient) %>%
                            summarise(Measurement = first(Measurement), Quantity = sum(Quantity)) %>%
                            as.data.frame()
                          )
  condiments = reactive(meals()[meals()$Main.Ingredient == 'n',] %>%
                          group_by(Ingredient) %>%
                          summarise(Measurement = first(Measurement), Quantity = sum(Quantity)) %>%
                          as.data.frame()
                        )
  
  ## Groceries
  output$grocery_list = renderDataTable(grocery_list())
  output$condiments = renderDataTable(meals())
  
}
      
