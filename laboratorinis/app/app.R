library(shiny)
library(tidyverse)
library(dplyr)
library(plotly)
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
    dark_hover_bg = "#81A1C1",
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
      selectizeInput(inputId = "imones_kodas", label = "Imones vardas", choices = NULL, selected = NULL)
    ),
    dashboardBody( use_theme(mytheme),
      fluidRow(box("Average salary dynamics", plotOutput("plot"), width = 500)),
      fluidRow(box("grafikas", plotlyOutput("plotly"), width = 500))
    )
)

server <- function(input, output, session) {
  
  data <- read.csv("C:/Users/Zenbook/OneDrive/Desktop/BANDYMAS45/KTU-duomenu-vizualizacija/laboratorinis/data/lab_sodra.csv")
  data1 <- data %>% filter(ecoActCode==461000) 
  data12 <- mutate (data1,month1=parse_date_time(month, "ym"))
  plot3 <- data1  %>% group_by(name,code) %>% summarise(max_insured=max(numInsured)) %>%
    na.omit() %>%
    arrange (desc(max_insured))
  
  updateSelectizeInput(session, "imones_kodas", choices = data$name, server = TRUE)
  
  output$table <- renderTable(
    data1 %>%
      filter(name == input$imones_kodas) , digits = 0
  )
    
  output$plot <- renderPlot(
    data12 %>%
      filter(name == input$imones_kodas) %>%
      ggplot(aes(x = month1, y = avgWage)) +
      geom_line(size = 0.9, linetype = 4, alpha=0.4, colour="#483D8B" )+geom_point(color="#7B68EE")+theme_bw()+
      labs( y="Average salary", x="Month")
    
    
  )
  
  output$plotltly <- renderPlotly({
     p <- plot3  %>% 
        filter(name == input$imones_kodas) %>%
        ggplot(aes(x = month1, y = numInsured)) +
        geom_line(size = 0.9, linetype = 4, alpha=0.4, colour="#483D8B" )+geom_point(color="#7B68EE")+theme_bw()+
        labs( y="Insured people", x="Month")
    ggplot(p)
  }
  )
}
shinyApp(ui, server)