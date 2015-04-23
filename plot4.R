library(dplyr)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by coal combustion
coal <- SCC[grep(".*Fuel.*Coal", SCC$EI.Sector),]
# Select rows in NEI that matches the above
coal_data <- NEI[NEI$SCC %in% coal$SCC,]

# Calculate total emissions
coal_tbl <- tbl_df(coal_data)
data <- coal_tbl %>%
  group_by(year) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year)

# Plot the graph
png("plot4.png", bg="white", width=600, height=480)
plot(data$year, 
     data$TotalEmission/10^5, 
     type="o", 
     ylab="Total Emissions (x 100,000 Tons)", 
     xlab="Year", 
     main="Emissions from coal combustion-related sources from 1999-2008")
dev.off()