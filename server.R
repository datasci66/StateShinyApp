require(datasets)
library(shiny)
library(googleVis)

shinyServer(function(input, output,session) { 
     
     # create dataframe for US states info
     
     mystates<-data.frame(state=row.names(state.x77),state.x77,row.names=NULL)
     vars<-names(mystates)
     vars<-vars[vars!="state"] # remove state as a choice for plotting, etc.
     
     ################################################################
     # plot tab
     
     observe(            
          updateSelectInput(session, "xAxis", choices = vars)
     )
     
     observe(            
          updateSelectInput(session, "yAxis", choices = vars)
     )
     
#      xData=reactive({
#           mystates[,input$xAxis]
#      })
#      
#      yData=reactive({
#           mystates[,input$yAxis]
#      })
     
     chartData = reactive({
          mystates[,c(input$xAxis,input$yAxis)]
     })

     output$plot <- renderGvis({
          if (input$xAxis == input$yAxis)
               return(NULL)
          h<-paste("{title:'", input$xAxis)
          h<-paste(h, "'}")
          v<-paste("{title:'", input$yAxis)
          v<-paste(v, "'}")
          gvisScatterChart(chartData(),options=list(hAxis=h,vAxis=v,legend="none"))
     })
     
     ################################################################
     # calculation tab
     
     observe(            
          updateSelectInput(session, "calcVar", choices = vars)
     )
     
     
     clcType <- function(x, type) {
          switch(type,
                 mean = mean(x),
                 max  = max(x),
                 min  = min(x))
     }
     
     val<-reactive({
          data<-as.numeric(mystates[,input$calcVar])
          clcType(data,input$calcType) 
       
     })
     
     output$calculation <-renderText({          
          str <- paste0('The ', input$calcType, ' of ', input$calcVar, ' is: ')
          paste0(str, val())           
     })
     
     ###############################################################
     # map tab
     
     observe(            
          updateSelectInput(session, "mapVar", choices = vars)
     )
     
     output$map = renderGvis({
          gvisGeoChart(mystates, locationvar="state", colorvar=input$mapVar,
                       options=list(region="US", displayMode="regions", resolution="provinces",
                                    width=600, height=400))
     })
          
})