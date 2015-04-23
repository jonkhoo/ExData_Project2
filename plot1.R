library(dplyr)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Calculate total emissions
nei <- tbl_df(NEI)
data <- nei %>%
  group_by(year) %>%
  summarize(TotalEmission = sum(Emissions)) %>%
  arrange(year)

# Plot the graph
png("plot1.png", bg="white", width=600, height=480)
plot(data$year, 
     data$TotalEmission/10^6, 
     type="o", 
     ylab="Total Emissions (x 1,000,000 Tons)", 
     xlab="Year",
     main="Total PM2.5 emission from all sources in United States, 1999-2008")
dev.off()