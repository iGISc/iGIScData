#source("Shiny/apps/sierra/sierraSource.R")
library(shiny); library(sf); library(leaflet); library(rgdal)
library(tidyverse); library(raster, exclude = "select")
library(iGIScData)

# Read data and create initial model from January
# XXsierraAllMonths <- right_join(sierraStations,sierraClimate,by="STATION") %>%
#   filter(!is.na(STATION_NA)) %>%
#   filter(`MLY-PRCP-NORMAL` >= 0) %>%
#   filter(`MLY-TAVG-NORMAL` >= -100) %>%
#   rename(PRECIPITATION = `MLY-PRCP-NORMAL`, TEMPERATURE = `MLY-TAVG-NORMAL`)
#

#%>%
#   mutate(STATION = str_sub(STATION_NA, end=str_length(STATION_NA)-6))

#dplyr::select(-STATION_NA)# %>%
#  mutate(STATION_NAME_SH = str_sub(STATION_NAME,1,str_locate(s,",")-1))

sierraAllMonths <- read_csv(system.file("extdata","Sierra2LassenData.csv",package="iGIScData")) %>%
  filter(MLY_PRCP_N >= 0) %>%
  filter(MLY_TAVG_N >= -100) %>%
  rename(PRECIPITATION = MLY_PRCP_N, TEMPERATURE = MLY_TAVG_N) %>%
  mutate(STATION = str_sub(STATION_NA, end=str_length(STATION_NA)-6))
sierraJan <- sierraAllMonths %>%   # to create an initial model and then create variable name symbols
  sample_n(0) %>%                  # sample_n(0) samples zero records, so just gets the variable names
  dplyr::select(LATITUDE, LONGITUDE, ELEVATION, TEMPERATURE, PRECIPITATION) #removed STATION
sierraVars <- sierraJan %>%        # Builds list of variables for map
  mutate(RESIDUAL = numeric(), PREDICTION = numeric()) %>%
  dplyr::select(ELEVATION, TEMPERATURE, PRECIPITATION, RESIDUAL, PREDICTION)

# Create basemap, using the weather station points to set the bounding dimensions

co <- CA_counties
ct <- st_read(system.file("extdata","CA_places.shp", package="iGIScData"))
ct$AREANAME_pad <- paste0(str_replace_all(ct$AREANAME, '[A-Za-z]',' '), ct$AREANAME)
hillsh <- raster(system.file("extdata","ca_hillsh_WGS84.tif",package="iGIScData"))
hillshpts <- as.data.frame(rasterToPoints(hillsh))
CAbasemap <- ggplot() +
  geom_raster(aes(x=x, y=y, fill=ca_hillsh_WGS84), data=hillshpts) + guides(fill = F) +
  geom_sf(data = co, fill = NA) +
  scale_fill_gradient(low = "#606060", high = "#FFFFFF") +
  labs(x='',y='')
spdftemp <- st_as_sf(sierraAllMonths, coords = c("LONGITUDE","LATITUDE"), crs=4326)
bounds <- st_bbox(spdftemp)
sierrabasemap <- CAbasemap +
  geom_sf(data=ct) +
  geom_sf_text(mapping = aes(label=AREANAME_pad), data=ct, size = 3, nudge_x = 0.1, nudge_y = 0.1) +
  coord_sf(xlim = c(bounds[1], bounds[3]), ylim = c(bounds[2],bounds[4]))

# Function used by pairs plot:
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

ui <- fluidPage(title = "Sierra Climate",
                tabsetPanel(
                  tabPanel(title = "View",
                           selectInput("month", "Month:",
                                       c("January" = 1, "February" = 2, "March" = 3, "April" = 4, "May" = 5, "June" =6,
                                         "July" = 7, "August" = 8, "September" = 9, "October" = 10, "November" = 11, "December" = 12)),
                           leafletOutput("view"),
                           radioButtons(inputId = "LeafletBasemap", label = "Basemap",
                                        choices = c("OpenStreetMap" = "open",
                                                    "Esri.WorldImagery" = "imagery",
                                                    "Esri.NatGeoWorldMap" = "natgeo"), selected = "open")),
                  tabPanel(title = "Model",
                           plotOutput("scatterplot"),
                           varSelectInput("xvar", "X Variable:", data=sierraJan, selected="ELEVATION"),
                           varSelectInput("yvar", "Y Variable:", data=sierraJan, selected="TEMPERATURE"),
                           verbatimTextOutput("model")),
                  tabPanel(title = "Map",
                           plotOutput("map"),
                           varSelectInput("var", "Variable:", data=sierraVars, selected="TEMPERATURE")),
                  tabPanel(title = "Table",
                           textOutput("eqntext"),
                           tableOutput("table")),
                  tabPanel(title = "Pairs",
                           textOutput("monthTitle4Pairs"),
                           plotOutput("pairsplot"))
                  )
                )
server <- function(input, output) {
  mod <- reactive({
    lm(as.formula(paste(input$yvar, '~', input$xvar)), data=sierraMonth())
  })
  sierraMonth <- reactive({
    monthsel <- 201000 + as.numeric(input$month)
    sierraAllMonths %>%
      filter(DATE == monthsel) %>%
      dplyr::select(STATION, ELEVATION, LATITUDE, LONGITUDE, TEMPERATURE, PRECIPITATION)
  })
  sierradf <- reactive({
    sierraMonth() %>%
      mutate(RESIDUAL = resid(mod()), PREDICTION = predict(mod()))
  })
  sierraSp <- reactive(st_as_sf(sierradf(), coords = c("LONGITUDE","LATITUDE"), crs=4326))

  eqn <- reactive({
    cc = mod()$coefficient
    paste(input$yvar, " =", paste(round(cc[1],2), "+", paste(round(cc[-1], digits=3), sep="*", collapse=" + ", paste(input$xvar))))
  })

  output$view <- renderLeaflet({
    providerTiles <- providers$OpenStreetMap
    if(input$LeafletBasemap == "imagery") {providerTiles <- providers$Esri.WorldImagery}
    if(input$LeafletBasemap == "natgeo") {providerTiles <- providers$Esri.NatGeoWorldMap}
    leaflet(data = sierradf()) %>%
      addTiles() %>%
      addProviderTiles(providerTiles) %>% ######DOESN'T WORK
      #addProviderTiles(providers$Esri.WorldImagery) %>%
      addMarkers(~LONGITUDE, ~LATITUDE,
        popup = ~str_c(ELEVATION,"m ", month.name[as.numeric(input$month)], ": ", TEMPERATURE, "°C ", PRECIPITATION, "mm"),
        label = ~STATION)
  })
  output$map <- renderPlot({
    subTitle <- ""
    if((input$var == "RESIDUAL")|(input$var == "PREDICTION")){
      subTitle <- eqn()}
    v <- get(paste(input$var), pos=sierradf())  # just to be able to use the vector
    sierrabasemap +
      geom_sf(mapping = aes(color = !!input$var), data=sierraSp(), size=4) +
      coord_sf(xlim = c(bounds[1], bounds[3]), ylim = c(bounds[2],bounds[4]))  +
      scale_color_gradient2(low="blue", mid="ivory2", high="darkred", midpoint=mean(v)) +
      labs(title=paste(month.name[as.numeric(input$month)], input$var), subtitle=subTitle) + theme(legend.position = c(0.8, 0.85))
  })
  output$scatterplot <- renderPlot({
    ggplot(data = sierradf()) +
      geom_point(mapping = aes(x = !!input$xvar, y = !!input$yvar)) +
      geom_smooth(mapping = aes(x = !!input$xvar, y = !!input$yvar), method="lm") +
      labs(title=month.name[as.numeric(input$month)])
  })
  output$model <- renderPrint({
    print(eqn())
    summary(mod())
  })
  output$eqntext <- renderText(paste(month.name[as.numeric(input$month)], "data. Residual and Prediction based on linear model: ", eqn()))
  output$monthTitle4Model <- renderText(month.name[as.numeric(input$month)])
  output$monthTitle4Pairs <- renderText(month.name[as.numeric(input$month)])
  output$table <- renderTable(sierradf())
  output$pairsplot <- renderPlot({
    sierradf() %>%
      dplyr::select(LATITUDE, LATITUDE, LONGITUDE, ELEVATION, TEMPERATURE, PRECIPITATION) %>%
      pairs(upper.panel = panel.cor)
  })}
shinyApp(ui = ui, server = server)
