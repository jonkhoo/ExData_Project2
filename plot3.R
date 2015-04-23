library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Filter by Baltimore City
bc <- NEI[NEI$fips=="24510",]

# Calculate total emissions for Baltimore City group by year, type
bc_tbl <- tbl_df(bc)
data <- bc_tbl %>%
  group_by(year, type) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year, type)

# Plot the graph
p <- qplot(year, 
      TotalEmission, 
      data=data, 
      facets=. ~type, 
      color=type, 
      geom=c("point", "line"), 
      method="lm", 
      main="PM2.5 Emissions Baltimore City, 1999-2008, by Source Type",
      xlab="Year", 
      ylab="Total Emissions (Tons)")
ggsave("plot3.png", width=12, height=4, dpi=100, plot=p)
