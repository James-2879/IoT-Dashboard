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
  cache_timer <- reactiveTimer(900000)
  
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
        list(src = "www/check-circle-fill-green.jpg",
             alt = "check",
             height = 15)
      }, deleteFile = FALSE)
      
    } else if (response_dev == 1) {
      output[[paste0("status_dev_", ui_identifier)]] <- renderText({"Device unreachable"})
      output[[paste0("status_dev_", ui_identifier, "_symbol")]] <- renderImage({
        list(src = "www/exclamation-circle-fill-red.jpg",
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
  
  observe(priority = -1000, {
    check_device(ip_address = "192.168.0.200",
                 ui_identifier = "200"
    )
  })
  
  # reboot stuff
  
  observeEvent(input$reboot_202, {
    inputSweetAlert(inputId = "confirm_reboot_202",
                    title = "Caution",
                    text = "This device should usually remain on, enter pin to continue...",
                    input = "password",
                    type = "warning"
    )
  })
  observeEvent(input$reboot_203, {
    inputSweetAlert(inputId = "confirm_reboot_203",
                    title = "Caution",
                    text = "This device should usually remain on, enter pin to continue...",
                    input = "password",
                    type = "warning"
    )
  })
 
   # shutdown stuff
  
  observeEvent(input$shutdown_202, {
    inputSweetAlert(inputId = "confirm_shutdown_202",
                    title = "Caution",
                    text = "(1) This device cannot be powered back on without physical access.
                    (2) This device runs this web service, continuing will terminate the service.
                    Enter pin to proceed.",
                    input = "password",
                    type = "error"
    )
  })
  observeEvent(input$shutdown_203, {
    inputSweetAlert(inputId = "confirm_shutdown_203",
                    title = "Caution",
                    text = "This device cannot be powered back on without physical access.
                    Enter pin to proceed.",
                    input = "password",
                    type = "warning"
    )
  })
  
  ### audio
  
  observeEvent(input$vol_up, {
    inputSweetAlert(inputId = "ssh_pass_vol_up",
                    title = "Remote password required",
                    input = "password",
                    type = "warning"
    )
  })
  
  observeEvent(input$ssh_pass_vol_up, {
    if (verifyPassword(Sys.getenv("SSH_PASS_HASH"), input$ssh_pass_vol_up)) {
      # instead of below, I should use a key if the password entered matches the hash
      system(str_glue("sshpass -p {input$ssh_pass_vol_up} ssh james@192.168.0.203 < scripts/volume_up.sh"))
      sendSweetAlert(title = "Executed",
                     type = "success",
                     btn_labels = NA)
      Sys.sleep(1)
      closeSweetAlert()
    }
  })
  
  observeEvent(input$vol_down, {
    inputSweetAlert(inputId = "ssh_pass_vol_down",
                    title = "Remote password required",
                    input = "password",
                    type = "warning"
    )
  })
  
  observeEvent(input$ssh_pass_vol_down, {
    if (verifyPassword(Sys.getenv("SSH_PASS_HASH"), input$ssh_pass_vol_down)) {
      system(str_glue("sshpass -p {input$ssh_pass_vol_down} ssh james@192.168.0.203 < scripts/volume_down.sh"))
      sendSweetAlert(title = "Executed",
                     type = "success",
                     btn_labels = NA)
      Sys.sleep(1)
      closeSweetAlert()
    }
  })
  
  
  
  
  ###
  
  
  
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