## We'll add data frames and sf data
##
## Some data that we'll access as raw data will also go into inst/extdata
##    Those will include some CSVs to illustrate reading them, and also
##    some spatial data that will similarly be used to illustrate reading them

# Start with some data frames
library(tidyverse)
overwrite = TRUE

sierraFeb <- read_csv("data-raw/sierraFeb.csv")
usethis::use_data(sierraFeb)

ConcentrationReport <- read_csv("data-raw/ConcentrationReport.csv")
usethis::use_data(ConcentrationReport)

sierraData <- read_csv("data-raw/sierraData.csv")
usethis::use_data(sierraData)

sierraStations<- read_csv("data-raw/sierraStations.csv")
usethis::use_data(sierraStations)

soilCO2_97<- read_csv("data-raw/soilCO2_97.csv")
usethis::use_data(soilCO2_97)

tidy_eucoak<- read_csv("data-raw/tidy_eucoak.csv")
usethis::use_data(tidy_eucoak)

XSptsNDVI<- read_csv("data-raw/XSptsNDVI.csv")
usethis::use_data(XSptsNDVI)

eucoakrainfallrunoffTDR<- read_csv("data-raw/eucoakrainfallrunoffTDR.csv")
usethis::use_data(eucoakrainfallrunoffTDR)


library(sf)
library(raster)


CA_counties <- st_read("data-raw/CA_counties.shp")
usethis::use_data(CA_counties)

BayAreaCounties <- st_read("data-raw/BayAreaCounties.shp")
usethis::use_data(BayAreaCounties)

BayAreaTracts <- st_read("data-raw/BayAreaTracts.shp")
usethis::use_data(BayAreaTracts)

CAfreeways <- st_read("data-raw/CAfreeways.shp")
usethis::use_data(CAfreeways)

CAhillsh <- raster("data-raw/ca_hillsh_WGS84.tif")
usethis::use_data(CAhillsh)

BayArea_hillsh <- raster("data-raw/BayArea_hillsh.tif")
usethis::use_data(BayArea_hillsh)
