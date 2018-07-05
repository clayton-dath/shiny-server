library(shiny)
library(shinydashboard)
library(dplyr)

meal.list <- read.csv('data/meal.csv')

function(input, output) {

  meals = reactive(meal.list[c( which(meal.list$Meal == input$mon)
                               ,which(meal.list$Meal == input$tue)
                               ,which(meal.list$Meal == input$wed)
                               ,which(meal.list$Meal == input$thu)
                               ,which(meal.list$Meal == input$fri)
                               ,which(meal.list$Meal == input$sat)
                               ,which(meal.list$Meal == input$sun)),c(2,3,4,5)])
  
  test = reactive() 
  
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
  
  output$test = reactive(class(grocery_list()))
  ## Groceries
  output$grocery_list = renderDataTable(grocery_list())
  output$condiments = renderDataTable(condiments())
  
}
      
