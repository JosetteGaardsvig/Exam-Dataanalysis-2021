library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(shinythemes)
library(leaflet)
library(magrittr)
library(rvest)
library(readxl)
library(dplyr)
library(maps)
library(ggplot2)
library(reshape2)
library(plotly)
library(rpart)
library(rpart.plot)


library(extrafont)
library(hrbrthemes)
library(waffle)
library(pander)
library(knitr)

dc <- read.csv("dc.csv")



shinyApp(
  ui = dashboardPage(
    dashboardHeader(title = "DONORSCHOOSE"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Antalsfordeling", tabName="antalsfordeling"),
        menuItem("procentfordeling", tabName="procentfordeling")
      )
    ),
    body <- dashboardBody(
      fluidRow(
        
        tabItems(
          tabItem(tabName="antalsfordeling",
                  h2("Faktorernes fordeling i forhold til donortype"),
                  
                  
                  tabBox(
                    title = "Antalsfordeling",
                    # The id lets us use input$tabset1 on the server to find the current tab
                    id = "tabset1", width="12", height="500px",
                    tabPanel("Ledelse", "Projektledelse versus engangsdonorer (t.v.) og flergangsdonorer (t.h.)", plotOutput('plot1')),
                    tabPanel("Klassetrin", "Klassetrin versus engangsdonorer (t.v.) og flergangsdonorer (t.h.)", plotOutput('plot2')),
                    tabPanel("Projektkategori", "Projektkategori versus engangsdonorer (t.v.) og flergangsdonorer (t.h.)", plotOutput('plot3')),
                    tabPanel("Undervisere", "Antal undervisere versus engangsdonorer (t.v.) og flergangsdonorer (t.h.)", plotOutput('plot4'))
                  )),
          
          tabItem(tabName="procentfordeling",
                  h2("Procentvis fordeling af flergangsdonorer"),
                  
                  tabBox(
                    title = "Procentfordeling",
                    # The id lets us use input$tabset1 on the server to find the current tab
                    id = "tabset2", width="12", height="500px",
                    tabPanel("Flergangsdonorer", "", plotOutput('model1')),
                    tabPanel("Undervisere", "", plotOutput('model2'))
                    
                  ))
          
        ))     
      
      
    )
    
  ),
  server = function(input, output) {
    
    # The currently selected tab from the tabBox
    output$tab1Selected <- renderText({
      input$tab1
    })
    output$plot1 = renderPlot(
      {
        ggplot(dc) +
          geom_bar(mapping= aes(x = y, fill = pro_type))}
      
    )
    
    
    # The currently selected tab from the tabBox
    output$tab2Selected <- renderText({
      input$tab2
    })
    output$plot2 = renderPlot(
      {
        ggplot(dc) +
          geom_bar(mapping= aes(x = y, fill = pro_grade))}
      
    )
    
    # The currently selected tab from the tabBox
    output$tab3Selected <- renderText({
      input$tab3
    })
    output$plot3 = renderPlot(
      {
        ggplot(dc) +
          geom_bar(mapping= aes(x = y, fill = pro_rcat_c))}
      
    )
    
    # The currently selected tab from the tabBox
    output$tab4Selected <- renderText({
      input$tab4
    })
    output$plot4 = renderPlot(
      {
        ggplot(dc) +
          geom_bar(mapping= aes(x = y, fill = don_teach))}
      
    )
    
    # The currently selected tab from the tabBox
    output$tab1Selected <- renderText({
      input$tab1
    })
    output$model1 = renderPlot(
      {
        waffle(c(90, 10), rows = 10, title = "Andelen af flergangsdonorer, der er undervisere (B)")}
      
    )
    
    # The currently selected tab from the tabBox
    output$tab2Selected <- renderText({
      input$tab2
    })
    output$model2 = renderPlot(
      {
        waffle(c(41, 59), rows = 10, title = "Andelen af flergangsdonorer blandt undervisere (B)")}
      
    )    
    
  }
)
