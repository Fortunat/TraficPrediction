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


#########################################
################ SAVE DATA ##############
#########################################

save(
  file=paste0(getwd(), "/.RData"),
  transilien_trafic,
  transilien_incident_securite,
  transilien_localisation_gare,
  transilien_ligne_par_gare
)

#########################################
################ !SAVE DATA #############
#########################################