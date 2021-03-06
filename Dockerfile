FROM rocker/shiny

# install system packages here
#RUN apt-get update && apt-get install -y \
#    sudo \
#    gdebi-core \
#    pandoc \
#    pandoc-citeproc \
#    libcurl4-gnutls-dev \
#    libcairo2-dev \
#    libxt-dev \
#    xtail \
#    wget


# install R packages here
RUN R -e "install.packages(c('dplyr', 'pandas', 'shinySignals'))"

COPY shiny-server.sh /usr/bin/shiny-server.sh

# COPY APP FILES
COPY apps/ /srv/shiny-server/apps

RUN chmod -R 755 /srv/shiny-server/

RUN chown shiny:shiny /var/lib/shiny-server

RUN chown shiny:shiny /usr/bin/shiny-server.sh

RUN chmod -R 755 /usr/bin/shiny-server.sh

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]