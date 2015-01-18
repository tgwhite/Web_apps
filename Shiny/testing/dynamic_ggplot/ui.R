
library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  
  h1("Dynamic ggplot2"),
  
  br(),
  tabsetPanel(type = "tabs", 
              tabPanel("Home", textOutput("text_output")),
              tabPanel("Plot", plotOutput("plot")),             
              tabPanel("Table", tableOutput("table")) 
              ),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Import and filter data"),
           selectInput('data_type', 'Data Type', c("delimited file (.csv, .tsv, .txt, etc.)", ".rdata", "Excel (.xlsx)")),
           fileInput('data_import', 'Choose file to upload',
                     accept = c(
                       'text/csv',
                       'text/comma-separated-values',
                       'text/tab-separated-values',
                       'text/plain',
                       '.csv',
                       '.tsv',
                       '.rdata', 
                       '.xlsx'
                     )
           ),           
           textInput("filter_text", "Custom Filtering Code", "None"),
           br(), br(), br()           
    ), 
    column(4, offset = .5,
           h4("Plot options"),
           uiOutput("ui_x"),          
           uiOutput("ui_y"),           
           uiOutput("ui_plot_type"),
           uiOutput("ui_color"),
           br()          
    ),
    column(3,
           h4("Theme and export options"),
           uiOutput("ui_facet_row"),
           uiOutput("ui_facet_col"),           
           uiOutput("ui_smooth_checkbox"),
          br()
    )
    
)))
