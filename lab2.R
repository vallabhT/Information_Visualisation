install.packages("maptools")
install.packages("rgeos")
install.packages("rgdal")
install.packages("mapproj")
install.packages("classInt")
install.packages("RColorBrewer")

library(maptools)
library(rgeos)
library(mapproj)
library(classInt)
library(RColorBrewer)
library(ggplot2)
library(rgdal)
##Reding the shapefile 
eurMap <- readOGR(dsn = file.choose())

#Reading the CSV file
eurEdu <- read.csv(file = file.choose(),stringsAsFactors = FALSE)

#Plotting eurMap
plot(eurMap)


##Tidying up the data
eurMapDf <- fortify(eurMap,region="CNTR_ID")

#Plotting the map using ggplot2
ggplot(eurMapDf)+
  aes(long,lat,group = group)+
  geom_polygon()




#Merging of the csv data with eurMapDf

eurEduMapDf <- merge(eurMapDf,eurEdu,
                     by.x = "id", by.y = "GEO")

eurEduMapDf <- eurEduMapDf[order(eurEduMapDf$order),]


ggplot(eurEduMapDf) + 
  aes(long,lat,group = group) +
  geom_polygon()

ggplot(eurEduMapDf) + aes(long, lat, group=group) + geom_polygon()




ggplot(eurEduMapDf) + aes(long, lat, group=group, fill=Value) + geom_polygon()
