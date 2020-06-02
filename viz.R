library(leaflet)
library(RColorBrewer)

show_dat <- function(dat) {
  yearbin <- seq(0, 365, by=20)
  mypalette <- colorBin( palette="Greens", domain=dat$day, na.color="transparent")
  line_palette <- colorBin( palette="Greys", domain=dat$day, na.color="transparent", bins=yearbin, reverse=TRUE)
  mytext <- paste(dat$name, sep=" ") %>%
    lapply(htmltools::HTML)
  nbrs <- paste(dat$day, sep=" ") %>%
    lapply(htmltools::HTML)
  m <- leaflet(dat) %>% 
    addTiles()  %>% 
    setView( lat=25, lng=13 , zoom=6) %>%
    addProviderTiles(providers$CartoDB.Voyager) %>%
    addCircleMarkers(~long, ~lat, color = line_palette(dat$day), weight=0.8, fillColor = ~mypalette(dat$day), fillOpacity = 1, radius=5, stroke=F,
                     label = mytext,
                     labelOptions = labelOptions(textOnly=FALSE, style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "top", noHide=F)
    ) %>%
    addLegend( pal=mypalette, values=~day, opacity=0.9, title = "Day of 2019", position = "bottomleft" )
  m
}

show_dat(dat)
