rm(list = ls())
setwd("C:/Users/jasonjia/Dropbox/02 Jason Personal/R-intro-divvy")

stations<-read.csv("Divvy_Stations_2017_Q3Q4.csv",
                   stringsAsFactors = FALSE)
ls()
class(stations) # Dataframe object
typeof(stations)

nrow(stations)
ncol(stations)
head(stations)
tail(stations)
summary(stations)
str(stations)

sapply(stations,class)
object.size(stations)

getwd()

x <- stations$dpcapacity
class(x)
length(x)
summary(x)
min(x)
max(x)
mean(x)
median(x)
quantile(x,0.5)
table(x) # gets all possible values and does a count of them
levels(x)

head(stations,n = 4)
tail(stations,n = 4)
stations[1:4,]
stations$name[1:4]
stations[1:4,2]
stations[1:4,"name"]

stations[1:4,c(2,3,6)]
stations[1:4,c("name","city","dpcapacity")]

subset(stations,dpcapacity > 40)
stations[stations$dpcapacity > 40,]
stations[stations$dpcapacity == 0,]

largest_stations<-subset(stations,dpcapacity > 40)
class(largest_stations)

rows <- order(stations$dpcapacity)
stations2 <- stations[rows,]
head(stations2)
tail(stations2)

x <- stations$city
class(x)
summary(x)

x <- factor(stations$city)
class(x)
summary(x)
levels(x)

rows <- which(stations$city == "Chicago ")
stations[rows,"city"] <- "Chicago"
x <- factor(stations$city)
summary(x)

stations$city <- factor(stations$city)
summary(stations$city)

plot(stations$longitude,stations$latitude,
     pch = 20)
plot(stations$longitude,stations$latitude,
     col = stations$city,pch = 20)

install.packages("ggplot2")
install.packages("cowplot")
library(ggplot2)
p <- ggplot(stations,
            aes(x = longitude,
                y = latitude,
                color = city)) +
  geom_point()
print(p)

p <- ggplot(stations,
            aes(x = longitude,
                y = latitude,
                fill = city)) +
  geom_point(shape = 21,size = 2,color = "white")
print(p)

library(cowplot)
p <- p +
  scale_fill_manual(values = c("dodgerblue",
                               "darkorange",
                               "darkblue")) +
  theme_cowplot(font_size = 10)
print(p)

ggsave("stations.png",p,dpi = 200)
ggsave("stations.pdf",p)

save.image("divvy_analysis.RData")
load("divvy_analysis.RData") # can be used to jumpstart the process to here

install.packages("readr")
source("read_trip_data.R")

nrow(trips)
ncol(trips)
head(trips)
summary(trips)

summary(trips$dayofyear)
trips$dayofyear <- factor(trips$dayofyear)
counts <- table(trips$dayofyear)

counts <- as.numeric(counts)
plot(274:365,counts,pch = 20)

pdat <- data.frame(day = 274:365,counts = counts)
p <- ggplot(pdat,aes(x = day,y = counts)) +
  geom_point() +
  theme_cowplot()
print(p)

counts <- table(trips$from_station_name)

length(stations$name)
length(names(counts))
length(intersect(stations$name,names(counts)))
stations$trips <- as.numeric(counts[stations$name])

p <- ggplot(stations,
            aes(x = longitude,
                y = latitude,
                size = sqrt(trips))) +
  geom_point(shape = 21,color = "white",
             fill = "black") +
  theme_cowplot()
print(p)
save.image("divvy_analysis.RData")
ggsave("size.png",p,dpi = 200)

install.packages("workflowr")
