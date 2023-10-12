# get shiny server and R from the rocker project
FROM rocker/r-ver:4.2.3

# system libraries
# Try to only install system libraries you actually need
# Package Manager is a good resource to help discover system deps
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev\
    default-jdk \
    r-cran-rjava \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# install R packages required
RUN R -e 'install.packages("remotes")'

RUN R -e 'remotes::install_github("OHDSI/OhdsiShinyModules")'
RUN R -e 'remotes::install_github("OHDSI/ShinyAppBuilder")'

ENV DATABASECONNECTOR_JAR_FOLDER /root
RUN R -e 'DatabaseConnector::downloadJdbcDrivers("postgresql")'

# Set an argument for the app name and port
ARG APP_NAME
ARG SHINY_PORT

# Set arguments for the GitHub branch and commit id abbreviation
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT_ID_ABBREV=unknown

# Set workdir and copy app files
WORKDIR /srv/shiny-server/${APP_NAME}

# copy the app directory into the image
COPY ./app.R .
COPY ./config.json .

# run app
EXPOSE 3838
CMD R -e "shiny::runApp('./', host = '0.0.0.0', port = 3838)"