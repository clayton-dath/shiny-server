library(shiny)
library(shinydashboard)
library(dplyr)

function(input, output) {

  
  meals = reactive(meal.list[c( which(meal.list$ï..Meal == input$mon)
                               ,which(meal.list$ï..Meal == input$tue)
                               ,which(meal.list$ï..Meal == input$wed)
                               ,which(meal.list$ï..Meal == input$thu)
                               ,which(meal.list$ï..Meal == input$fri)
                               ,which(meal.list$ï..Meal == input$sat)
                               ,which(meal.list$ï..Meal == input$sun)),c(2,3,4,5)])
  
  grocery_list = reactive(meals()[meals()$Main.Ingredient == 'y',] %>%
                            group_by(Ingredient) %>%
                            summarise(Measurement = first(Measurement), Quantity = sum(Quantity)))
  condiments = reactive(meals()[meals()$Main.Ingredient == 'n',] %>%
                            group_by(Ingredient) %>%
                            summarise(Measurement = first(Measurement), Quantity = sum(Quantity)))
  
  ## Groceries
  output$grocery_list = renderDataTable(grocery_list(), options = list(sDom  = '<"top"><"bottom">'))
  output$condiments = renderDataTable(condiments(), options = list(sDom  = '<"top"><"bottom">'))
  
}
      