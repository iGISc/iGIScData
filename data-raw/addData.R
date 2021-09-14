## We'll add data frames and sf data
##
## Some data that we'll access as raw data will also go into inst/extdata
##    Those will include some CSVs to illustrate reading them, and also
##    some spatial data that will similarly be used to illustrate reading them

# Start with some data frames
library(tidyverse)

sierraFeb <- read_csv("inst/extdata/sierraFeb.csv")
usethis::use_data(sierraFeb, overwrite = TRUE)

sierraClimate <- read_csv("inst/extdata/sierraClimate.csv")
usethis::use_data(sierraClimate, overwrite=TRUE)

ConcentrationReport <- read_csv("inst/extdata/ConcentrationReport.csv")
usethis::use_data(ConcentrationReport, overwrite = TRUE)

sierraData <- read_csv("inst/extdata/sierraData.csv")
usethis::use_data(sierraData, overwrite = TRUE)

sierraStations<- read_csv("inst/extdata/sierraStations.csv")
usethis::use_data(sierraStations, overwrite = TRUE)

soilCO2_97<- read_csv("inst/extdata/soilCO2_97.csv") %>%
  rename(TEMPC = `SOIL C`) %>%
  select(SITE, DATE, TIME, TEMPC, `CO2%`)
usethis::use_data(soilCO2_97, overwrite = TRUE)

tidy_eucoak<- read_csv("inst/extdata/tidy_eucoak.csv")
usethis::use_data(tidy_eucoak, overwrite = TRUE)

XSptsNDVI<- read_csv("inst/extdata/XSptsNDVI.csv")
usethis::use_data(XSptsNDVI, overwrite = TRUE)

eucoakrainfallrunoffTDR<- read_csv("inst/extdata/eucoakrainfallrunoffTDR.csv")
usethis::use_data(eucoakrainfallrunoffTDR, overwrite = TRUE)

CA_ClimateNormals <- read_csv("inst/extdata/CA_ClimateNormals.csv")
usethis::use_data(CA_ClimateNormals, overwrite = TRUE)

TRI_1987_CA <- read_csv("inst/extdata/TRI_1987_CA.csv")
usethis::use_data(TRI_1987_CA, overwrite = TRUE)

TRI_1997_CA <- read_csv("inst/extdata/TRI_1997_CA.csv")
usethis::use_data(TRI_1997_CA, overwrite = TRUE)

TRI_2007_CA <- read_csv("inst/extdata/TRI_2007_CA.csv")
usethis::use_data(TRI_2007_CA, overwrite = TRUE)

TRI_2017_CA <- read_csv("inst/extdata/TRI_2017_CA.csv")
usethis::use_data(TRI_2017_CA, overwrite = TRUE)



library(sf)
library(raster)


CA_counties <- st_read("inst/extdata/CA_counties.shp")
usethis::use_data(CA_counties, overwrite = TRUE)

BayAreaCounties <- st_read("inst/extdata/BayAreaCounties.shp")
usethis::use_data(BayAreaCounties, overwrite = TRUE)

BayAreaTracts <- st_read("inst/extdata/BayAreaTracts.shp")
usethis::use_data(BayAreaTracts, overwrite = TRUE)

CAfreeways <- st_read("inst/extdata/CAfreeways.shp")
usethis::use_data(CAfreeways, overwrite = TRUE)

