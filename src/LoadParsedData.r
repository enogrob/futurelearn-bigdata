library(RCurl)
rawData <- getURL("http://stats.grok.se/json/en/201410/Friday")
library(RJSONIO)
parsedData <- fromJSON(rawData)
viewsData <- data.frame(Date=names(parsedData$daily_views),  # get the names
                        Views=parsedData$daily_views,  # get the data points
                        row.names=NULL)   # stop using the dates as names
viewsData$Date <- as.Date(viewsData$Date)
viewsData <- viewsData[order(viewsData$Date),]
row.names(viewsData) <- NULL
install.packages("ggplot2")
library(ggplot2)
ggplot(data=viewsData,  # Make a plot using our views data
       aes(x=Date,  # with Date on the x-axis
           y=Views,  # and Views on the y-axis
           group=1)) +  # Use all the data as one data series
  geom_line()  # and draw a line of this data
