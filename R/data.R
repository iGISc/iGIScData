#' California Climate Normals
#'
#' 30 year normals of monthly temperature, precipitation, and other climate variables
#' from NOAA/NCDC weather stations in California
#'
#' @format A data frame with 5100 observations and 51 variables using mm for precipitation and Celsius for temperature variables
#'
#' @source \url{https://www.ncdc.noaa.gov/}
"CA_ClimateNormals"

#' Sierra Stations
#'
#' Station names and ids selected to represent Sierra Nevada, southern Sierra, and towns
#' adjacent the Sierra in the central valley and east side.  Selected from NCDC points.
#'
#' @source \url{https://www.ncdc.noaa.gov/}
"sierraStations"

#' Sierra climate data
#'
#' Derived from monthly California Climate Normals (in mm, degC) at Sierra Stations,
#' with County names added from a spatial join.
#'
#' @format A data frame with 983 observations and 53 variables
#' same as California Climate Normals, with county and geometry added
"sierraClimate"

#' Sierra February climate data
#'
#' Selection from SierraData to only include February data
#'
#' @format A data frame with 82 entries and 7 variables selected and renamed
#' \describe{
#'   \item{STATION_NAME}{Station name}
#'   \item{COUNTY}{County Name}
#'   \item{ELEVATION}{Elevation in meters}
#'   \item{LATITUDE}{Latitude in decimal degrees}
#'   \item{LONGITUDE}{Longitude in decimal degrees}
#'   \item{PRECIPITATION}{February Average Precipitation in mm}
#'   \item{TEMPERATURE}{Febrary Average Temperature in degrees C}
#' }
#' @source \url{https://www.ncdc.noaa.gov/}
"sierraFeb"

#' Concentration Report
#'
#' Marine debris concentration report
#'
#' @format A data frame with 431 observations and 194 variables
#' @source \url{https://marinedebris.noaa.gov/research/marine-debris-monitoring-and-assessment-project"}
"ConcentrationReport"

#' Soil CO2 1997
#'
#' Soils CO2 measurements from a transect of 11 sites from Super Sink across Marble Valley
#' in the Marble Mountains Wilderness of California
#'
#' @format data frame of 558 observations of 4 variables
#' \describe{
#'    \item{SITE}{Site number north to south}
#'    \item{DATE}{Date}
#'    \item{TEMPC}{Temperature degrees C}
#'    \item{`CO2%`}{Soil CO2 concentration in %}
#'  }
#' @source field measurements from 1997 research by Davis, Amato, and Kiefer
"soilCO2_97"

#' Eucalyptus and Oak rainfall, runoff, soil moisture
#'
#' Study of runoff under Eucalyptus and oak canopy in Bay Area sites
#' @source measurements collected for
#' Thompson, Davis, Oliphant (2016) Surface runoff and soil erosion under
#' eucalyptus and oak canopy. Earth Surface Processes and Landforms 41: 1018-1026.
"eucoakrainfallrunoffTDR"

#' Eucalyptus and Oak rainfall and runoff, tidied
#'
#' @format 180 observations of 12 variables
#' \describe{
#'   \item{site}{site id}
#'   \item{`site #`}{site number}
#'   \item{tree}{euc or oak}
#'   \item{Date}{date}
#'   \item{month}{starts with month}
#'   \item{rain_mm}{rain gauge measurements in mm since last visit}
#'   \item{rain_subcanopy}{rain gauge measurements under canopy}
#'   \item{slope}{site slope in degrees}
#'   \item{aspect}{site aspect in degrees of azimuth}
#'   \item{runoff_L}{runoff in L captured in Gerlach trough overflow buckets}
#'   \item{surface_tension}{soil hydrophobicity as surface tension}
#'   \item{runoff_rainfall_ratio}{runoff/rainfall}
#' @source measurements collected for
#' Thompson, Davis, Oliphant (2016) Surface runoff and soil erosion under
#' eucalyptus and oak canopy. Earth Surface Processes and Landforms 41: 1018-1026.
"tidy_eucoak"

#' Meadow cross section with vegetation and NDVI
#'
#' NDVI derived from multispectral drone imagery of Knuthson Meadow cross section
#' during growing and senescent seasons in 2017 & 2018.
#'
#' @format data frame with 29 observations and 6 variables
#' \describe{
#'   \item{DistNtoS}{cross sectional distance location in m}
#'   \item{elevation}{laser-leveled elevation of data point}
#'   \item{vegetation}{vegetation type}
#'   \item{geometry}{UTM zone 10 N coordinates of point}
#'   \item{NDVIgrowing}{NDVI from drone imagery during growing season Jul 2017}
#'   \item{NDVIsenescent}{NDVI from drone imagery during senescent season Sep 2018}
#'   }
#' @source from study of Knuthson meadow for
#' Davis et al. (2020). Unpiloted aerial system (UAS)-supported biogeomorphic
#' analysis of restored Sierra Nevada montane meadows. Remote Sensing 12: 1828. 25p.
"XSptsNDVI"

#' Bay Area Counties
#'
#' Bay Area Counties as sf features
#'
#' @format sf
"BayAreaCounties"

#' Bay Area Census Tracts
#'
#' @format sf
"BayAreaTracts"

#' CA counties
#'
#' @format sf
"CA_counties"

#' CA freeways
#'
#' @format sf
#'
"CAfreeways"

#' Bay Area hillshade
#'
#' @format raster
"BayArea_hillsh"

#' CA hillshade
#'
#' @format raster
"CAhillsh"

