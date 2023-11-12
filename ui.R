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
                                fluidRow(
                                  box(width = 2,
                                      title = "192.168.0.202",
                                      style = "font-size:14px;",
                                      collapsible = TRUE,
                                      collapsed = FALSE,
                                      fluidRow(
                                        column(width = 1, style = "height:50px;",
                                               imageOutput(outputId = "status_dev_202_symbol")
                                               ),
                                        column(width = 5,
                                               textOutput(outputId = "status_dev_202")
                                               )
                                      )
                                  )
                                ),
                                fluidRow(
                                  box(width = 2,
                                      title = "192.168.0.203",
                                      style = "font-size:14px;",
                                      collapsible = TRUE,
                                      collapsed = FALSE,
                                      fluidRow(
                                        column(width = 1, style = "height:50px;",
                                               imageOutput(outputId = "status_dev_203_symbol")
                                        ),
                                        column(width = 5,
                                               textOutput(outputId = "status_dev_203")
                                        )
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

