source("global.R", local = TRUE)

### Selectoze choice vectors ###



### JS ###

collapseInput <- function(inputId, boxId) {
  #' Return the current (collapsed) state of a box.
  #'
  #' State must have been altered in the server using js$collapse(box) before the state is known.
  #' As such, the box needs to be collapsed/expanded when the server loads so the function can get the state.
  tags$script(
    sprintf(
      "$('#%s').closest('.box').on('hidden.bs.collapse', function () {Shiny.onInputChange('%s', true);})",
      boxId, inputId
    ),
    sprintf(
      "$('#%s').closest('.box').on('shown.bs.collapse', function () {Shiny.onInputChange('%s', false);})",
      boxId, inputId
    )
  )
}

#jscode <- read...

### CSS ###

#css <- read...

ui <- dashboardPage(skin = "black",
                    
                    header <- dashboardHeader(title = "Dashboard",
                                              tags$li(
                                                shinybrowser::detect(),
                                                class = "dropdown")
                                              # tags$li(a(href = "www.google.com",
                                              #           img(src = "logo.png",
                                              #               title = "Logo",
                                              #               height = "25px"),
                                              #           style = "padding-top:12px;
                                              #           padding-bottom:5px;
                                              #           padding-left:0px !important;
                                              #           margin-left:0px !important;"),
                                              #         class = "dropdown")
                    ),
                    
                    sidebar <- dashboardSidebar(width = 240,
                                                collapsed = FALSE,
                                                shinyjs::useShinyjs(),
                                                extendShinyjs(script = "extensions.js", functions = c('collapse', 'disableTab','enableTab',
                                                                                                      'changeTitleVisibility', 'sidebarState',
                                                                                                      'disableMenu', 'enableMenu')),
                                                tags$head(
                                                  tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
                                                ),
                                                sidebarMenu(id = "main_menu", 
                                                            style = "font-size:16px",
                                                            # add_busy_bar(color = "#0096FF", timeout = 400, height = "4px"),
                                                            menuItem("Sign in",
                                                                     tabName = "sign_in",
                                                                     icon = icon("log-in",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            ),
                                                            menuItem("Panel 2",
                                                                     tabName = "p2",
                                                                     icon = icon("signal",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            ),
                                                            menuItem("About",
                                                                     tabName = "about",
                                                                     icon = icon("info-sign",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            )
                                                )
                    ),
                    
                    body <- dashboardBody(
                      style = "padding:0px;",
                      #tags$style(css),
                      tabItems(
                        tabItem(tabName = "sign_in", 
                                fluidRow(
                                  column(width = 8,
                                         fluidRow(
                                           imageOutput(outputId = "splash_image"
                                           )
                                         )
                                  ),
                                  fluidRow(
                                    box(width = 4,
                                        style = "font-size:14px;
                                        padding-top:35vh;",
                                        collapsible = FALSE,
                                        height = "93vh",
                                        includeMarkdown("www/sign_in_info.md"),
                                        textOutput(outputId = "sign_in_info"),
                                        textInput(inputId = "username",
                                                  label = "User",
                                                  placeholder = "username"
                                        ),
                                        passwordInput(inputId = "password",
                                                      label = "Pass",
                                                      placeholder = "password"
                                        )
                                    )
                                  ),
                                )
                        ),
                        tabItem(tabName = "p2",
                                # Desktop ----
                                tags$div(style = "padding:10px",
                                         fluidRow(
                                           box(width = 4,
                                               title = "Desktop Server (192.168.0.200)",
                                               style = "font-size:14px;
                                               padding-top:0px;",
                                               collapsible = TRUE,
                                               collapsed = FALSE,
                                               fluidRow(
                                                 tags$div(style = "height:1px !important;
                                                          padding-left:15px;
                                                          padding-top:0px",
                                                          imageOutput(outputId = "status_dev_200_symbol")
                                                 ),
                                                 tags$div(style = "padding-left:40px;
                                                          padding-bottom:10px",
                                                          textOutput(outputId = "status_dev_200")
                                                 )
                                               ),
                                               tags$div(style = "padding-left:15px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "boot_200",
                                                                     label = "Boot",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "primary",
                                                                     icon = icon("off",
                                                                                 lib = "glyphicon")
                                                          ),
                                                          actionBttn(inputId = "reboot_200",
                                                                     label = "Reboot",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "warning",
                                                                     icon = icon("repeat",
                                                                                 lib = "glyphicon")
                                                          ),
                                                          actionBttn(inputId = "shutdown_200",
                                                                     label = "Shutdown",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "danger",
                                                                     icon = icon("off",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               ),
                                               tags$div(style = "padding-left:15px;
                                                 padding-top:10px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "connect_power_200",
                                                                     label = "Connect power",
                                                                     style = "simple",
                                                                     size = "sm",
                                                                     color = "success",
                                                                     icon = icon("ok-circle",
                                                                                 lib = "glyphicon")
                                                          ),
                                                          
                                                          actionBttn(inputId = "disconnect_power_200",
                                                                     label = "Disconnect power",
                                                                     style = "simple",
                                                                     size = "sm",
                                                                     color = "danger",
                                                                     icon = icon("remove-circle",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               )
                                           )
                                         ),
                                         fluidRow(
                                           box(width = 4,
                                               title = "Pi 4 Server (192.168.0.202)",
                                               style = "font-size:14px;
                                               padding-top:0px;",
                                               collapsible = TRUE,
                                               collapsed = FALSE,
                                               fluidRow(
                                                 tags$div(style = "height:1px !important;
                                                          padding-left:15px;
                                                          padding-top:0px",
                                                          imageOutput(outputId = "status_dev_202_symbol")
                                                 ),
                                                 tags$div(style = "padding-left:40px;
                                                          padding-bottom:10px",
                                                          textOutput(outputId = "status_dev_202")
                                                 )
                                               ),
                                               tags$div(style = "padding-left:15px;
                                                 padding-top:10px;
                                                        padding-bottom:10px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "reload_vpn_202",
                                                                     label = "Reload VPN",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "primary",
                                                                     icon = icon("cloud",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               ),
                                               tags$div(style = "padding-left:15px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "reboot_202",
                                                                     label = "Reboot",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "warning",
                                                                     icon = icon("repeat",
                                                                                 lib = "glyphicon")
                                                          ),
                                                          actionBttn(inputId = "shutdown_202",
                                                                     label = "Shutdown",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "danger",
                                                                     icon = icon("off",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               )
                                           )
                                         ),
                                         fluidRow(
                                           box(width = 4,
                                               title = "Pi 2 Server (192.168.0.203)",
                                               # maybe put IPs in a tooltip
                                               style = "font-size:14px;
                                               padding-top:0px;",
                                               collapsible = TRUE,
                                               collapsed = FALSE,
                                               fluidRow(
                                                 tags$div(style = "height:1px !important;
                                                          padding-left:15px;
                                                          padding-top:0px",
                                                          imageOutput(outputId = "status_dev_203_symbol")
                                                 ),
                                                 tags$div(style = "padding-left:40px;
                                                          padding-bottom:10px",
                                                          textOutput(outputId = "status_dev_203")
                                                 )
                                               ),
                                               tags$div(style = "padding-left:15px;
                                                 padding-top:10px;
                                                        padding-bottom:10px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "reload_vpn_203",
                                                                     label = "Reload VPN",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "primary",
                                                                     icon = icon("cloud",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               ),
                                               tags$div(style = "padding-left:15px;
                                                        padding-bottom:10px;",
                                                        fluidRow(
                                                          actionBttn(inputId = "reboot_203",
                                                                     label = "Reboot",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "warning",
                                                                     icon = icon("repeat",
                                                                                 lib = "glyphicon")
                                                          ),
                                                          actionBttn(inputId = "shutdown_203",
                                                                     label = "Shutdown",
                                                                     style = "bordered",
                                                                     size = "sm",
                                                                     color = "danger",
                                                                     icon = icon("off",
                                                                                 lib = "glyphicon")
                                                          )
                                                        )
                                               ),
                                               actionBttn(inputId = "vol_down",
                                                          label = "Decrease volume",
                                                          size = "sm",
                                                          style = "bordered",
                                                          color = "royal"),
                                               actionBttn(inputId = "vol_up",
                                                          label = "Increase volume",
                                                          size = "sm",
                                                          style = "bordered",
                                                          color = "royal")
                                           )
                                         )
                                )
                        ),
                        tabItem(tabName = "about",
                                fluidRow(style = "margin-top: 21px",
                                         column(width = 12,
                                                style="padding:0px",
                                                tabBox(width = 12,
                                                       tabPanel("User info",
                                                                includeMarkdown("www/USERINFO.md") # recommended to set absolute path
                                                       ),
                                                       tabPanel("Dev info",
                                                                includeMarkdown("README.md") # recommended to set absolute path
                                                       )
                                                )
                                         )
                                         
                                )
                        )
                      )
                    ),
                    
                    dashboardPage(
                      header,
                      sidebar,
                      body
                    )
)

