# Sys.setenv(SPARK_HOME = paste0(getwd(), "/spark-2.0.1-bin-hadoop2.7"))
Sys.setenv(SPARK_HOME = paste0(getwd(), "/spark-2.1.1-bin-hadoop2.7"))

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(
  master = "local[*]",
  sparkConfig = list(spark.driver.memory = "1g"),
  # sparkPackages = "com.databricks:spark-csv_2.10:1.4.0",
  sparkPackages = "com.databricks:spark-csv_2.11:1.5.0",
  enableHiveSupport = FALSE
)

#CONVERT R DATAFRAME OBJET INTO SPARK OBJECT
df_merged_transilien_trafic <- as.DataFrame(merged_transilien_trafic)
df_merged_transilien_trafic.train <- as.DataFrame(merged_transilien_trafic.train)
df_merged_transilien_trafic.test <- as.DataFrame(merged_transilien_trafic.test)
#!CONVERT R DATAFRAME OBJET INTO SPARK OBJECT

#MODEL
# model <- SparkR::spark.randomForest(df_merged_transilien_trafic.train, Intensite ~ ., type = "classification", maxDepth = 5, maxBins = 3)
model <- SparkR::spark.logit(df_merged_transilien_trafic.train, Intensite ~ ., regParam = 0.1)
#!MODEL

#PREDICT
prediction <- SparkR::predict(model, newData = df_merged_transilien_trafic.test)
#!PREDICT

#ANALYSE RESULT
prediction_local <- SparkR::collect(select(prediction,c('Intensite','prediction')))
confusion_table <- base::table(prediction_local$Intensite,prediction_local$prediction)
confusion_matrix <- as.data.frame.matrix(base::table(prediction_local$Intensite,prediction_local$prediction))
error_rate <- 1-sum(diag(confusion_table))/sum(confusion_table)
#!ANALYSE RESULT

#DISPLAY RESULT
print("RESULT:")
SparkR::showDF(SparkR::select(prediction,c('Intensite','Nom_gare', 'Type_jour', 'Tranche_horaire','rawPrediction','probability','prediction')),100)
print("")

print("MATRIX:")
print(confusion_matrix)
print("")

print("ERROR RATE:")
print(error_rate)
#!DISPLAY RESULT

#STOP SPARK SESSION
# sparkR.session.stop()