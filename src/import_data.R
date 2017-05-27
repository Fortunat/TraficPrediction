####################################################
################ GET TRANSILIEN TRAFIC #############
####################################################

transilien_trafic <- read.csv(
  file=paste0(getwd(),"/data/comptage-voyageurs-trains-transilien.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_incident_securite <- read.csv(
  file=paste0(getwd(),"/data/incidents-securite.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_localisation_gare <- read.csv(
  file=paste0(getwd(),"/data/sncf-gares-et-arrets-transilien-ile-de-france.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_ligne_par_gare <- read.csv(
  file=paste0(getwd(),"/data/sncf-lignes-par-gares-idf.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_regularite_intercite <- read.csv(
  file=paste0(getwd(),"/data/regularite-mensuelle-intercites.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_regularite_transilien <- read.csv(
  file=paste0(getwd(),"/data/ponctualite-mensuelle-transilien.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_regularite_tgv <- read.csv(
  file=paste0(getwd(),"/data/regularite-mensuelle-tgv.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_regularite_ter <- read.csv(
  file=paste0(getwd(),"/data/regularite-mensuelle-ter.csv"), 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_trips <- read.csv(
  file=paste0(getwd(),"/data/transilien_gtfs/trips.txt"), 
  header = TRUE,
  sep = ",",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_stops <- read.csv(
  file=paste0(getwd(),"/data/transilien_gtfs/stops.txt"), 
  header = TRUE,
  sep = ",",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_stop_times <- read.csv(
  file=paste0(getwd(),"/data/transilien_gtfs/stop_times.txt"), 
  header = TRUE,
  sep = ",",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_calendar <- read.csv(
  file=paste0(getwd(),"/data/transilien_gtfs/calendar.txt"), 
  header = TRUE,
  sep = ",",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_routes <- read.csv(
  file=paste0(getwd(),"/data/transilien_gtfs/routes.txt"), 
  header = TRUE,
  sep = ",",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

####################################################
################ !GET TRANSILIEN TRAFIC ############
####################################################


#########################################
################ CLEAN DATA #############
#########################################

lapply(names(transilien_routes), function(item)
{
  transilien_routes[[item]][
    is.na(transilien_routes[[item]]) |
      transilien_routes[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_calendar), function(item)
{
  transilien_calendar[[item]][
    is.na(transilien_calendar[[item]]) |
      transilien_calendar[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_stop_times), function(item)
{
  transilien_stop_times[[item]][
    is.na(transilien_stop_times[[item]]) |
      transilien_stop_times[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_stops), function(item)
{
  transilien_stops[[item]][
    is.na(transilien_stops[[item]]) |
      transilien_stops[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_trips), function(item)
{
  transilien_trips[[item]][
    is.na(transilien_trips[[item]]) |
      transilien_trips[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_regularite_ter), function(item)
{
  transilien_regularite_ter[[item]][
    is.na(transilien_regularite_ter[[item]]) |
      transilien_regularite_ter[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_regularite_tgv), function(item)
{
  transilien_regularite_tgv[[item]][
    is.na(transilien_regularite_tgv[[item]]) |
      transilien_regularite_tgv[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_regularite_transilien), function(item)
{
  transilien_regularite_transilien[[item]][
    is.na(transilien_regularite_transilien[[item]]) |
      transilien_regularite_transilien[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_regularite_intercite), function(item)
{
  transilien_regularite_intercite[[item]][
    is.na(transilien_regularite_intercite[[item]]) |
      transilien_regularite_intercite[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_ligne_par_gare), function(item)
{
  transilien_ligne_par_gare[[item]][
    is.na(transilien_ligne_par_gare[[item]]) |
    transilien_ligne_par_gare[[item]] == ""
  ] <<- "0"
})

lapply(names(transilien_localisation_gare), function(item)
{
  transilien_localisation_gare[[item]][
    is.na(transilien_localisation_gare[[item]]) |
    transilien_localisation_gare[[item]] == ""
  ] <<- "Undefined"
})

lapply(names(transilien_incident_securite), function(item)
{
  transilien_incident_securite[[item]][
    is.na(transilien_incident_securite[[item]]) |
    transilien_incident_securite[[item]] == ""
  ] <<- "Undefined"
})

lapply(names(transilien_trafic), function(item)
{
  transilien_trafic[[item]][
    is.na(transilien_trafic[[item]]) |
    transilien_trafic[[item]] == ""
  ] <<- "Undefined"
})

#########################################
################ !CLEAN DATA ############
#########################################


############################################
################ PREPARE DATA ##############
############################################

# transilien_regularite_transilien et transilien_trafic UTILE POUR LA PREDICTION

#ADD FEATURE FOR TRANSILIEN_TRAFIC
transilien_trafic$Date.de.comptage <- as.Date( transilien_trafic$Date.de.comptage, '%Y-%m-%d')
transilien_trafic$Date <- format(transilien_trafic$Date.de.comptage, '%Y-%m')

#MERGE TRANSILIEN_REGULARITE_TRANSILIEN AND TRANSILIEN_TRAFIC
merged_transilien_trafic <- merge(
  x=transilien_regularite_transilien,
  y=transilien_trafic,
  by = c("Ligne", "Date"),
  all.y = TRUE
)

############################################
################ !PREPARE DATA #############
############################################


#CALL SPARK SCRIPT
source(paste0(getwd(), "/src/initialize_spark.R"))


#########################################
################ SAVE DATA ##############
#########################################

save(
  file=paste0(getwd(), "/.RData"),
  transilien_trafic,
  transilien_incident_securite,
  transilien_localisation_gare,
  transilien_ligne_par_gare,
  transilien_regularite_intercite,
  transilien_regularite_transilien,
  transilien_regularite_tgv,
  transilien_regularite_ter,
  transilien_trips,
  transilien_stops,
  transilien_stop_times,
  transilien_calendar,
  transilien_routes,
  df_transilien_ligne_par_gare,
  df_transilien_localisation_gare,
  df_transilien_incident_securite,
  df_transilien_trafic,
  df_transilien_regularite_intercite,
  df_transilien_regularite_transilien,
  df_transilien_regularite_tgv,
  df_transilien_regularite_ter,
  df_transilien_trips,
  df_transilien_stops,
  df_transilien_stop_times,
  df_transilien_calendar,
  df_transilien_routes
)

#########################################
################ !SAVE DATA #############
#########################################