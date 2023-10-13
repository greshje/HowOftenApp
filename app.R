library(OhdsiShinyModules)
library(ShinyAppBuilder)

config <- loadConfig("config.json")
resultDatabaseSettings <- createDefaultResultDatabaseSettings(
  schema = Sys.getenv("RESULT_DATABASE_SCHEMA")
)

cli::cli_h1("Starting shiny server")
server <- Sys.getenv("howoftendbServer")
cli::cli_alert_info("Connecting to {server}")
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = "postgresql",
  server = Sys.getenv("howoftendbServer"),
  port = 5432,
  user = Sys.getenv("howoftendbUser"),
  password = Sys.getenv("howoftendbPw")
)
createShinyApp(config = config,
               connectionDetails = connectionDetails,
               resultDatabaseSettings = resultDatabaseSettings)