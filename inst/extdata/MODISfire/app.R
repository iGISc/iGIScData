library(sf); library(leaflet); library(tidyverse); library(lubridate)
library(shiny); library(here)
dataPath <- paste(here::here(),"/MODISdata",sep="")
if (!file.exists(dataPath)){dir.create(dataPath)}
setwd(dataPath)
pal <- colorNumeric(c("orange", "firebrick4"),domain=300:550)
ui <- fluidPage(
  titlePanel("MODIS fire detections from temperature anomalies"),
  leafletOutput("view"),
  sliderInput(inputId = "end_jday",
              label = "ending Julian day",
              value = yday(now()), min = 1, max = 365, step = 1),
  sliderInput(inputId = "numdays",
              label = "number of days",
              value = 1, min = 1, max = 14, step = 1),
  sliderInput(inputId = "year",
              label = "year",
              value = year(now()), min = 2009, max = year(now()), step = 1, sep = ""),
  helpText(paste("Jerry Davis, SFSU Institute for Geographic Information Science.",
                 "Data source: USDA Forest Service https://fsapps.nwcg.gov/afm/gisdata.php"))
)

server <- function(input, output, session) {
  output$view <- renderLeaflet({  # Only year is reactive, so only runs initially/year change
    yrst <- as.character(input$year)
    txt <- read_file(str_c("https://fsapps.nwcg.gov/afm/data/fireptdata/modisfire_",
                           yrst,"_conus.htm"))
    shpPath <- str_extract(txt,
                           "https://fsapps.nwcg.gov/afm/data/fireptdata/modis_fire_.........conus_shapefile.zip")
    shpZip <- str_extract(shpPath, "modis_fire_.........conus_shapefile.zip")
    MODISfile <- str_c(dataPath,"/",str_extract(shpZip,
                                                "modis_fire_.........conus"),".shp")
    if(yrst == as.character(year(now())) | !file.exists(MODISfile)) {
      shpZipPath <- str_c(dataPath, "/",shpZip)
      download.file(shpPath, shpZipPath)
      unzip(shpZipPath, exdir=dataPath) }
    fires <<- st_read(MODISfile)
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldTopoMap) %>%
      fitBounds(-123,37,-120,39)
  })
  observe({                   # Allows the map to retain its location and zoom
    numdays <- input$numdays; end_jday <- input$end_jday
    fireFilt <- filter(fires,between(JULIAN, end_jday - numdays, end_jday))
    yrst <- as.character(input$year)
    dat <- as.Date(end_jday-1, origin=str_c(yrst,"-01-01"))  # Julian day fix
    leafletProxy("view", data = fireFilt) %>%
      clearMarkers() %>%
      addCircleMarkers(
        radius = ~(TEMP-250)/50,  # scales 300-500 from 1:5
        color = ~pal(TEMP),
        stroke = FALSE, fillOpacity = 0.8) %>%
      clearControls() %>%   # clears the legend
      addLegend("topright", pal=pal, values=~TEMP, opacity=0.6,
                title=str_c("MODIS °K</br>",numdays, " days: ",
                            dat,"</br>maxJulian: ",as.character(max(fires$JULIAN))))
  })
}
shinyApp(ui = ui, server = server, options = list(width = "100%", height = 800))
