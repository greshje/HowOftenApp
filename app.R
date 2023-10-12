library(OhdsiShinyModules)
library(ShinyAppBuilder)

config <- loadConfig("config.json")
resultDatabaseSettings <- createDefaultResultDatabaseSettings(
  schema = Sys.getenv("RESULT_DATABASE_SCHEMA")
)

connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = Sys.getenv("CD_DBMS"),
  server = Sys.getenv("CD_SERVER"),
  port = Sys.getenv("CD_PORT"),
  user = Sys.getenv("CD_USER"),
  password = Sys.getenv("CD_PASSWORD")
)
createShinyApp(config = config,
               connectionDetails = connectionDetails,
               resultDatabaseSettings = resultDatabaseSettings)