

library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  
  h2("Dynamic ggplot2"),
  
  br(),
  tabsetPanel(type = "tabs", 
              tabPanel("Plot", plotOutput("plot")),             
              tabPanel("Table", tableOutput("table"))),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Import data"),
           selectInput('data_type', 'Data Type', c(".rdata", "comma (.csv) or tab (.tsv) delimited or plain text")),
           fileInput('data_import', 'Choose file to upload',
                     accept = c(
                       'text/csv',
                       'text/comma-separated-values',
                       'text/tab-separated-values',
                       'text/plain',
                       '.csv',
                       '.tsv',
                       '.rdata'
                     )
           ),
           br()           
    ), 
    column(4, offset = 1,
           h4("Plot options"),
           uiOutput("ui_x"),          
           uiOutput("ui_y"),
           # selectInput('x', 'X', names(dataset())),          
           # selectInput('y', 'Y', names(dataset())),
           selectInput('plot_type', 'Plot Type', c("Scatter", "Line")),
           uiOutput("ui_color"),
           br()
          # selectInput('color', 'Color', c('None', names(dataset())))
    ),
    column(4,
           h4("Theme options"),
           uiOutput("ui_facet_row"),
           uiOutput("ui_facet_col"),
           # selectInput('facet_row', 'Facet Row',
          #           c(None='.', names(dataset()[sapply(dataset(), is.factor)]))),          
          # selectInput('facet_col', 'Facet Column',
            #            c(None='.', names(dataset()[sapply(dataset(), is.factor)]))),
           checkboxInput('smooth', 'Smooth'),
          br()
    )
    
    
)))
