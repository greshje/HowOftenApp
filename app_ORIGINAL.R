library(OhdsiShinyModules)
library(ShinyAppBuilder)

library(dplyr)
library(ShinyAppBuilder)
library(markdown)

config <- loadConfig("config.json")

schema = "covid_homeless_nachc"

resultDatabaseSettings <- createDefaultResultDatabaseSettings(
  schema = schema
)

cli::cli_h1("Starting shiny server")
server <- "MyServer"
cli::cli_alert_info("Connecting to {server}")

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = "postgresql",
  connectionString = "jdbc:postgresql://localhost:5432/OHDSI_HOMELESS_COVID_RESULTS_DB?user=postgres&password=ohdsi&currentSchema=OHDSI_HOMELESS_COVID_RESULTS_DB",
  pathToDriver = "D:/_YES/databases/postgres/drivers/42.3.3"
)

cli::cli_h2("Loading MyServer")
createShinyApp (
  config = config,
  connectionDetails = connectionDetails,
  resultDatabaseSettings = resultDatabaseSettings,
  usePooledConnection = FALSE
)



