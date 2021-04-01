## We'll add data frames and sf data
##
## Some data that we'll access as raw data will also go into inst/extdata
##    Those will include some CSVs to illustrate reading them, and also
##    some spatial data that will similarly be used to illustrate reading them

# Start with some data frames
library(tidyverse)
overwrite = TRUE

sierraFeb <- read_csv("inst/extdata/sierraFeb.csv")
usethis::use_data(sierraFeb)

sierraClimate <- read_csv("inst/extdata/sierraClimate.csv")
usethis::use_data(sierraClimate, overwrite=TRUE)

ConcentrationReport <- read_csv("inst/extdata/ConcentrationReport.csv")
usethis::use_data(ConcentrationReport)

sierraData <- read_csv("inst/extdata/sierraData.csv")
usethis::use_data(sierraData)

sierraStations<- read_csv("inst/extdata/sierraStations.csv")
usethis::use_data(sierraStations)

soilCO2_97<- read_csv("inst/extdata/soilCO2_97.csv") %>%
  rename(`SOIL C`, `TEMPC`) %>%
  select(SITE, DATE, TEMPC, `CO2%`)
usethis::use_data(soilCO2_97)

tidy_eucoak<- read_csv("inst/extdata/tidy_eucoak.csv")
usethis::use_data(tidy_eucoak)

XSptsNDVI<- read_csv("inst/extdata/XSptsNDVI.csv")
usethis::use_data(XSptsNDVI)

eucoakrainfallrunoffTDR<- read_csv("inst/extdata/eucoakrainfallrunoffTDR.csv")
usethis::use_data(eucoakrainfallrunoffTDR)

CA_ClimateNormals <- read_csv("inst/extdata/CA_ClimateNormals.csv")
usethis::use_data(CA_ClimateNormals)

TRI_1987_CA <- read_csv("inst/extdata/TRI_1987_CA.csv")
usethis::use_data(TRI_1987_CA)

TRI_1997_CA <- read_csv("inst/extdata/TRI_1997_CA.csv")
usethis::use_data(TRI_1997_CA)

TRI_2007_CA <- read_csv("inst/extdata/TRI_2007_CA.csv")
usethis::use_data(TRI_2007_CA)

TRI_2017_CA <- read_csv("inst/extdata/TRI_2017_CA.csv")
usethis::use_data(TRI_2017_CA)



library(sf)
library(raster)


CA_counties <- st_read("inst/extdata/CA_counties.shp")
usethis::use_data(CA_counties)

BayAreaCounties <- st_read("inst/extdata/BayAreaCounties.shp")
usethis::use_data(BayAreaCounties)

BayAreaTracts <- st_read("inst/extdata/BayAreaTracts.shp")
usethis::use_data(BayAreaTracts)

CAfreeways <- st_read("inst/extdata/CAfreeways.shp")
usethis::use_data(CAfreeways)

