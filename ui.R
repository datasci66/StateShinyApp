shinyUI(fluidPage( 
     titlePanel("State Data"),
     sidebarLayout(
          sidebarPanel(               
               conditionalPanel(
                    condition="input.tabSet=='Plot'",
                    
                    selectInput("xAxis", "Choose an x variable:",
                                choices = NULL,
                                selected = NULL),
                    selectInput("yAxis", "Choose a y variable:",
                                choices = NULL,
                                selected = NULL),   
                    
                    helpText("Select two variables to create a scatterplot for all states.
                             Hover over a plot to view the values.")
               ),
               
               conditionalPanel(
                    condition="input.tabSet=='Calculate'",
                    
                    selectInput("calcVar", "Choose a variable:",
                                choices = NULL,
                                selected = NULL),
                    selectInput("calcType", "Choose a calculation:",
                                choices =  c("Min" = "min",
                                             "Max" = "max",
                                             "mean" = "mean"),
                                selected = "mean"),   
                    
                    helpText("Select a variable and a calculation to determine the value across all states.")
               ),
               
               conditionalPanel(
                    condition="input.tabSet=='Map'",
                    
                    selectInput("mapVar", "Choose a variable:",
                                choices = NULL,
                                selected = NULL),   
                    
                    helpText("Select a variable to map all states. Hover over a state to view its value.")
               )
               
          ),
          mainPanel(
               tabsetPanel(id="tabSet",
                    tabPanel("Plot", htmlOutput("plot")),
                    tabPanel("Calculate", 
                             verbatimTextOutput("calculation")
                    ),
                    tabPanel("Map", htmlOutput("map"))
               )
                          
         )
    )
))