library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by vehicles
vehicles <- SCC[grep("Vehicles", SCC$SCC.Level.Two, ignore.case=TRUE),]
# Filter by Baltimore City and Los Angeles County
bcla <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
# Filter by vehicles in both cities
bcla_vehicles <- bcla[bcla$SCC %in% vehicles$SCC,]
# Create a new column City that contains the cities names
bcla_vehicles$City[bcla_vehicles$fips=="24510"] <- "Baltimore City"
bcla_vehicles$City[bcla_vehicles$fips=="06037"] <- "Los Angeles County"

# Calculate total emissions for the 2 cities
bcla_tbl <- tbl_df(bcla_vehicles)
data <- bcla_tbl %>%
  group_by(year, City) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year, City)

# Plot the graph
p <- qplot(year, 
      TotalEmission, 
      data=data, 
      color=City, 
      geom=c("point", "line"), 
      method="lm", 
      main="Vehicles Emissions Baltimore vs Los Angeles, 1999-2008",
      xlab="Year", 
      ylab="Total Emissions (Tons)")

ggsave("plot6.png", width=7, height=4, dpi=100, plot=p)