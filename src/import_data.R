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

transilien_regularite_transilien <- read.csv(
  file=paste0(getwd(),"/data/ponctualite-mensuelle-transilien.csv"), 
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

lapply(names(transilien_trafic), function(item)
{
  transilien_trafic[[item]][
    is.na(transilien_trafic[[item]]) |
      transilien_trafic[[item]] == ""
    ] <<- "Undefined"
})

lapply(names(transilien_regularite_transilien), function(item)
{
  transilien_regularite_transilien[[item]][
    is.na(transilien_regularite_transilien[[item]]) |
      transilien_regularite_transilien[[item]] == ""
    ] <<- "Undefined"
})

#########################################
################ !CLEAN DATA ############
#########################################


############################################
################ PREPARE DATA ##############
############################################

# transilien_regularite_transilien et transilien_trafic UTILE POUR LA PREDICTION

# ADD FEATURE FOR TRANSILIEN_TRAFIC
transilien_trafic$Date.de.comptage <- as.Date( transilien_trafic$Date.de.comptage, '%Y-%m-%d')
transilien_trafic$Date <- format(transilien_trafic$Date.de.comptage, '%Y-%m')

#MERGE TRANSILIEN_REGULARITE_TRANSILIEN AND TRANSILIEN_TRAFIC
merged_transilien_trafic <- merge(
  x=transilien_regularite_transilien,
  y=transilien_trafic,
  by = c("Ligne", "Date"),
  all.y = TRUE
)

#LIMIT PERIMETER
merged_transilien_trafic <- merged_transilien_trafic[merged_transilien_trafic$Ligne != "C",]

#FORMAT
merged_transilien_trafic$Montants <- as.numeric(merged_transilien_trafic$Montants)
merged_transilien_trafic$Taux.de.ponctualité <- as.double(merged_transilien_trafic$Taux.de.ponctualité)
merged_transilien_trafic$Code.Gare <- as.numeric(merged_transilien_trafic$Code.Gare)
merged_transilien_trafic$Date.de.comptage <- as.Date( merged_transilien_trafic$Date.de.comptage, '%Y-%m-%d')
#!FORMAT

#NUMBER OF ROW
merged_transilien_trafic_count <- nrow(merged_transilien_trafic)

#GIVE RANDOM VALUE FOR EACH
merged_transilien_trafic$alea <- runif(merged_transilien_trafic_count, min=0, max=1)

merged_transilien_trafic$Intensite <- "Undefined"

#FAIBLE INTENSITE USER
merged_transilien_trafic[
  merged_transilien_trafic$Montants >= 0 
  & merged_transilien_trafic$Montants <= 1000
,]$Intensite <- "faible"

#MOYENNE INTENSITE USER
merged_transilien_trafic[
  merged_transilien_trafic$Montants > 1000 
  & merged_transilien_trafic$Montants <= 2000
,]$Intensite <- "moyenne"

#FORTE INTENSITE USER
merged_transilien_trafic[
  merged_transilien_trafic$Montants > 2000 
,]$Intensite <- "forte"

lapply(names(merged_transilien_trafic), function(item)
{
  merged_transilien_trafic[[item]][
    is.na(merged_transilien_trafic[[item]]) |
      merged_transilien_trafic[[item]] == ""
    ] <<- "Undefined"
})

#TRAIN DATA
merged_transilien_trafic.train <- merged_transilien_trafic[
  merged_transilien_trafic$alea <= 0.667,
  c(
    "Nom.gare",
    "Type.jour",
    "Date.de.comptage",
    "Tranche.horaire",
    "Intensite"
  )
]

#TEST DATA
merged_transilien_trafic.test <- merged_transilien_trafic[
  merged_transilien_trafic$alea > 0.667,
  c(
    "Nom.gare",
    "Type.jour",
    "Date.de.comptage",
    "Tranche.horaire",
    "Intensite"
  )
]

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
  transilien_regularite_transilien
)

#########################################
################ !SAVE DATA #############
#########################################