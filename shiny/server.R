library(shiny)

function(input, output) {
  output$regija1 <- renderPlot({
    graf.regije(input$regija)
  })
  output$avto <- renderPlot({
    graf_osebni_avto(input$Leto) 
  })
  
}
