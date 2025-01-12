library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(lubridate)
library(fresh)


mytheme <- create_theme(
  adminlte_color(
    light_blue = "#483D8B"
  ),
  adminlte_sidebar(
    width = "400px",
    dark_bg = "#7B68EE",
    dark_hover_bg = "#483D8B",
    dark_color = "#483D8B"
  ),
  adminlte_global(
    content_bg = "#FFF",
    box_bg = "#FFF", 
    info_box_bg = "#FFF"
    
  )
)

ui <-dashboardPage(
  
  dashboardHeader(title="Laboratorinis Nr.2 Grupe 461000", titleWidth = 500),
  dashboardSidebar(
      selectizeInput(inputId = "imones_kodas", label = "Imones pavadinimas", choices = NULL, selected = NULL)
    ),
    dashboardBody( use_theme(mytheme),
                   fluidRow(box("",valueBoxOutput("Kodas", width = 250), width = 500)),
      fluidRow(box("Vidutinis atlyginimas", plotOutput("plot"), width = 500)),
      fluidRow(box("Apdraustų darbuotojų skaičius", plotOutput("plotly"), width = 500))
      )
)

server <- function(input, output, session) {
  data <- read_csv("https://github.com/GalaXeaMil/KTU-duomenu-vizualizacija/raw/main/laboratorinis/data/lab_sodra.csv")
  data1 <- data %>% filter(ecoActCode==461000) 
  data12 <- mutate (data1,month1=parse_date_time(month, "ym"))
 
  
  updateSelectizeInput(session, "imones_kodas", choices = data1$name, server = TRUE)
  

  
  output$table <- renderTable(
    data1 %>%
      filter(name == input$imones_kodas) , digits = 0
  )
  
  output$Kodas <-renderValueBox({ 
    t <- data12 %>% filter(name==input$imones_kodas) %>% head(1)
                                  valueBox(t$code, "", color = "purple")
  })
    
  output$plot <- renderPlot(
    data12 %>%
      filter(name == input$imones_kodas) %>%
      ggplot(aes(x = month1, y = avgWage)) +
      geom_line(size = 0.9, linetype = 4, alpha=0.4, colour="darkorchid4" )+geom_point(color="#7B68EE")+
      theme_bw()+labs( y="Average salary", x="Month")+
      scale_x_datetime(date_labels="%b %y",date_breaks  ="1 month")
    
  )
  
  output$plotly <- renderPlot(
    data12 %>% 
        filter(name == input$imones_kodas) %>%
      ggplot(aes(month1,numInsured, fill="numInsured"))+geom_col(fill = ("#7B68EE"))+
      scale_y_continuous(labels = scales::number_format())+theme_light()+
      scale_x_datetime(date_labels="%b %y",date_breaks  ="1 month")+labs( y="Average salary", x="Month")
        
    
    
  )
}
shinyApp(ui, server)
