### Libraries ###

library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyBS)
library(bsplus)
library(shinybusy)
# library(Cairo)
library(kableExtra)
library(DT)
library(markdown)
library(shinyjs)
library(V8)
library(dotenv)

library(shinybrowser) # get window dimensions
library(scrypt)

# options(shiny.usecairo = T) #better graphics

app_dir <- "/home/james/Documents/IoT-Dashboard/" # local
# app_dir <- "/srv/shiny-server/IoT-Dashboard/" # docker
load_dot_env(file = paste0(app_dir, ".env"))

# have a peer list on the about page
# nordvpn meshnet peer list > file


### Metadata ###


### Data ###


### Global vars ###