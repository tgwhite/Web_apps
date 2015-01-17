library(shiny)
library(ggplot2)
library(data.table)

shinyServer(function(input, output) {  
  dataset <- reactive({
    inFile = input$data_import
    current_files = ls()    
          
    if (is.null(inFile)) {
      return(NULL)
      
    } else if (input$data_type == ".rdata") {
      load(inFile$datapath)    
      file_just_loaded = ls()[!(ls() %in% c(current_files, "current_files"))]
      
      if (length(file_just_loaded) > 1) 
        return("Error: .rdata object must contain only one data.frame like object")      
      else 
        imported_data = get(file_just_loaded)
      
    } else {
      imported_data = fread(inFile$datapath)      
    }
    
    names(imported_data) = gsub(x = names(imported_data), pattern = " ", replacement = "_", fixed = T)
  
    imported_data 
  })
    
      
  output$table <- renderTable({
    dataset()
  })
  
  output$ui_x <- renderUI({
    if (is.null(dataset())) 
      return(NULL)            
    selectInput('x', 'X', names(dataset()))
  })
  
  output$ui_y <- renderUI({
    if (is.null(dataset()))
      return(NULL)            
    selectInput('y', 'Y', names(dataset()))
  })
  
  output$ui_plot_type <- renderUI({
    if (is.null(dataset()))
      return(NULL)
    selectInput('plot_type', 'Plot Type', c("Scatterplot", "Lineplot", "Histogram", "Density", "Boxplot", "Barplot"))
  })  
    
  output$ui_color <- renderUI({
    if (is.null(dataset()))
      return(NULL)            
    selectInput('color', 'Color', c('None', names(dataset())))
  })
  
  output$ui_smooth_checkbox <- renderUI({
    if (is.null(dataset()))
      return(NULL)
    checkboxInput('smooth', 'Smooth')
  })
  
  output$ui_facet_row <- renderUI({
    if (is.null(dataset()))
      return(NULL)                
    selectInput('facet_row', 'Facet Row',
              c(None='.', names(dataset()[sapply(dataset(), is.factor)])))    
  })
  
  output$ui_facet_col <- renderUI({
    if (is.null(dataset()))
      return(NULL)            
    
    selectInput('facet_col', 'Facet Column',
               c(None='.', names(dataset()[sapply(dataset(), is.factor)])))
  })    
  

  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) 
    
    if (input$plot_type == "Scatterplot") 
      p <- p + geom_point() 
    else if (input$plot_type == "Lineplot") 
      p <- p + geom_line() 
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
        
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  })
  
})