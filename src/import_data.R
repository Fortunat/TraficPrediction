###############################################
################ GET ANNUAL TRAFIC ############
###############################################

trafic_2016 <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/trafic-annuel-entrant-par-station-du-reseau-ferre-2016.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8"
)
trafic_2016$Column.12 <- NULL
trafic_2016$Column.13 <- NULL
trafic_2016$Column.14 <- NULL
trafic_2016$Column.15 <- NULL

trafic_2015 <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/trafic-annuel-entrant-par-station-du-reseau-ferre-2015.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8"
)

trafic_2014 <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/trafic-annuel-entrant-par-station-du-reseau-ferre-2014.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8"
)

trafic_2013 <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/trafic-annuel-entrant-par-station-du-reseau-ferre-2013.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8"
)

###############################################
################ !GET ANNUAL TRAFIC ###########
###############################################


###############################################
################ GET RER A TRAFIC #############
###############################################

RER_A_stop_times <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/stop_times.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_stops <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/stops.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_routes <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/routes.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_transfers <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/transfers.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_trips <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/trips.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_calendar <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/calendar.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

RER_A_calendar_dates <- read.table(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/RATP_GTFS_LINES/RATP_GTFS_RER_A/calendar_dates.txt", 
  header = TRUE,
  sep = ",",
  encoding="UTF-8"
)

###############################################
################ !GET RER A TRAFIC ############
###############################################


####################################################
################ GET TRANSILIEN TRAFIC #############
####################################################

transilien_trafic <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/comptage-voyageurs-trains-transilien.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_incident_securite <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/incidents-securite.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_localisation_gare <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/sncf-gares-et-arrets-transilien-ile-de-france.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

transilien_ligne_par_gare <- read.csv(
  file="C:/Users/Fortunat/Documents/EPITA_LINUX/Techno du web/Projet_Prediction/data/sncf-lignes-par-gares-idf.csv", 
  header = TRUE,
  sep = ";",
  encoding="UTF-8",
  stringsAsFactors=FALSE
)

####################################################
################ !GET TRANSILIEN TRAFIC ############
####################################################


#########################################
################ CLEAN DATA #############
#########################################

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