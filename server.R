source("global.R", local = TRUE)

server <- function(input, output, session){
  
  #------------------------------------ JS -------------------------------------
  
  # initialize UI
  js$sidebarState() # manually change state
  js$changeTitleVisibility() # manually change state
  shinyjs::addClass(selector = "body", class = "sidebar-collapse") # manually switch class
  onclick('switchState', js$changeTitleVisibility()) # for user switching
  ### Functions ###
  
  splash_image_timer <- reactiveTimer(10000) # in ms
  
  # shinyjs::js$disableMenu("p2")
  # shinyjs::js$disableMenu("about")
  
  
  ### Variables ###
  
  
  
  ### Reactives ###
  
  observeEvent(input$password, {
    # observe(priority = 100000, {
    if (input$username == "james") {
      if (verifyPassword(Sys.getenv("PASSWORD_HASH"), input$password)) {
        shinyjs::js$enableMenu("p2")
        shinyjs::js$enableMenu("about")
        updateTabItems(inputId = "main_menu", selected = "p2")
        sendSweetAlert(title = "Authenticated",
                       type = "success",
                       btn_labels = NA)
        Sys.sleep("1.50")
        closeSweetAlert()
      }
    }
  })
  
  
  check_device <- function(ip_address, ui_identifier) {
    # ping returns 0 if reachable, 1 if not
    # maybe also return ping time
    response_dev <- system(paste0("ping ", ip_address, " -c 1"))
    if (response_dev == 0) {
      output[[paste0("status_dev_", ui_identifier)]] <- renderText({"Device reachable"})
      output[[paste0("status_dev_", ui_identifier, "_symbol")]] <- renderImage({
        list(src = "www/check-circle-fill.svg",
             alt = "check",
             height = 15)
      }, deleteFile = FALSE)
      
    } else if (response_dev == 1) {
      output[[paste0("status_dev_", ui_identifier)]] <- renderText({"Device unreachable"})
      output[[paste0("status_dev_", ui_identifier, "_symbol")]] <- renderImage({
        list(src = "www/exclamation-circle-fill.svg",
             alt = "check",
             height = 15)
      }, deleteFile = FALSE)
      
    }
  }
  
  observe(priority = -1000, {
    check_device(ip_address = "192.168.0.202",
                 ui_identifier = "202"
    )
  })
  
  observe(priority = -1000, {
    check_device(ip_address = "192.168.0.203",
                 ui_identifier = "203"
    )
  })
  
  
  
  
  ### Outputs ###
  
  output$splash_image <- renderImage({
    splash_image_timer() # do it async
    image_number <- round(runif(1, 1, 12))
    # jpegoptim --size=750k *.JPG
    filename <- paste0("www/photos_compressed/", image_number, ".jpg")
    list(src = filename,
         alt = "Splash",
         height = shinybrowser::get_height()*0.93)
  }, deleteFile = FALSE)
  
  
  
  
}