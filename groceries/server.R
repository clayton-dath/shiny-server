library(shiny)
library(shinydashboard)
library(dplyr)

function(input, output) {

  meals = reactive(meal.list[,c(2,3,4,5)]
                  load(meal.list))
  
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
      
