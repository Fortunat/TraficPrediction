Sys.setenv(SPARK_HOME = paste0(getwd(), "/spark-2.0.1-bin-hadoop2.7"))
Sys.setenv('SPARKR_SUBMIT_ARGS'='"--packages" "com.databricks:spark-csv_2.10:1.4.0" "sparkr-shell"')

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(
  master = "local[*]", 
  sparkConfig = list(spark.driver.memory = "1g"),
  sparkPackages = "com.databricks:spark-csv_2.10:1.4.0",
  enableHiveSupport = FALSE
)

#CONVERT R DATAFRAME OBJET INTO SPARK OBJECT
df_transilien_ligne_par_gare <- as.DataFrame(transilien_ligne_par_gare)
df_transilien_localisation_gare <- as.DataFrame(transilien_localisation_gare)
df_transilien_incident_securite <- as.DataFrame(transilien_incident_securite)
df_transilien_trafic <- as.DataFrame(transilien_trafic)
df_transilien_regularite_intercite <- as.DataFrame(transilien_regularite_intercite)
df_transilien_regularite_transilien <- as.DataFrame(transilien_regularite_transilien)
df_transilien_regularite_tgv <- as.DataFrame(transilien_regularite_tgv)
df_transilien_regularite_ter <- as.DataFrame(transilien_regularite_ter)
df_transilien_trips <- as.DataFrame(transilien_trips)
df_transilien_stops <- as.DataFrame(transilien_stops)
df_transilien_stop_times <- as.DataFrame(transilien_stop_times)
df_transilien_calendar <- as.DataFrame(transilien_calendar)
df_transilien_routes <- as.DataFrame(transilien_routes)
#!CONVERT R DATAFRAME OBJET INTO SPARK OBJECT

#STOP SPARK SESSION
sparkR.session.stop()
