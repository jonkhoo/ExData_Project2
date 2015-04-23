library(dplyr)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Filter by Baltimore City
bc <- NEI[NEI$fips=="24510",]

# Calculate total emission for Baltimore City
bc_tbl <- tbl_df(bc)
data <- bc_tbl %>%
  group_by(year) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year)

# Plot the graph
png("plot2.png", bg="white", width=480, height=480)
plot(data$year, 
     data$TotalEmission, 
     type="o", 
     ylab= "Total Emissions (Tons)", 
     xlab="Year",
     main="Total PM2.5 emission from Baltimore City, 1999-2008")
dev.off()