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
#!CONVERT R DATAFRAME OBJET INTO SPARK OBJECT

#STOP SPARK SESSION
sparkR.session.stop()