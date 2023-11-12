FROM rocker/shiny-verse:latest

LABEL author="James Swift"
LABEL maintainer="James Swift"
LABEL name="IoT Dashboard"
LABEL version="1.0"

RUN apt update
RUN apt upgrade -y
RUN apt install iputils-ping -y

COPY . /srv/shiny-server/IoT-Dashboard/
# EXPOSE 3838
# CMD shiny-server 2>&1
RUN R -e "install.packages(c('shinydashboard', 'shinyWidgets', 'shinyBS', 'bsplus', 'shinybusy', 'kableExtra', 'DT', 'markdown', 'shinyjs', 'V8', 'dotenv', 'shinybrowser', 'scrypt'), dependencies=TRUE)"
