library(dplyr)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by vehicles
vehicles <- SCC[grep("Vehicles", SCC$SCC.Level.Two, ignore.case=TRUE),]
# Filter by Baltimore City
baltimore <- NEI[NEI$fips=="24510",]
# Filter by vehicles in Baltimore City
baltimore_vehicles <- baltimore[baltimore$SCC %in% vehicles$SCC,]

# Calculate total emissions by baltimore vehicles
bv_tbl <- tbl_df(baltimore_vehicles)
data <- bv_tbl %>%
  group_by(year) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year)

# Plot the graph
png("plot5.png", bg="white", width=600, height=480)
plot(data$year, 
     data$TotalEmission, 
     type="o", 
     ylab="Total Emissions (Tons)", 
     xlab="Year", 
     main="Total Emissions from motor vehicle sources, Baltimore City, 1999-2008")
dev.off()