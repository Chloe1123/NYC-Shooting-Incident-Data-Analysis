# NYPD Shooting Incident Data Analysis Script

# -----------------------------
# 1. Library Imports and Data Loading
# -----------------------------
# Load necessary libraries for data manipulation, analysis, and visualization
library(apaTables)
library(lubridate)
library(dplyr)
library(knitr)
library(sf)
library(spatstat)
library(ggplot2)
library(sp)

# Load the NYPD Shooting Incident Data
# (Replace with the correct path to the dataset)
data <- read.csv('/path/to/NYPD_Shooting_Incident_Data__Historic_.csv')

# -----------------------------
# 2. Data Preprocessing
# -----------------------------
# Convert dates and filter data for the desired time range
data$OCCUR_DATE <- mdy(data$OCCUR_DATE)
data <- data %>%
  mutate(Year = year(OCCUR_DATE)) %>%
  filter(OCCUR_DATE >= ymd("2017-01-01") & OCCUR_DATE <= ymd("2022-12-31")) %>%
  filter(!is.na(Longitude) & !is.na(Latitude))

# -----------------------------
# 3. Statistical Summary and Tables
# -----------------------------
# Summarize key variables and create frequency tables
summary(data$Latitude)
summary(data$Longitude)
table(data$Year)
table(data$Month)
table(data$BORO)
table(data$VIC_RACE)
table(data$VIC_SEX)
table(data$VIC_AGE_GROUP)

# Generate frequency and percentage tables for Borough and Victim Race
freq_table_BORO <- table(data$BORO)
percent_table_BORO <- prop.table(freq_table_BORO) * 100

freq_table <- table(data$VIC_RACE)
percent_table <- prop.table(freq_table) * 100

# Combine frequency and percentage in a data frame for Victim Race
table_df <- data.frame(
  VIC_RACE = names(freq_table),
  Frequency = as.integer(freq_table),
  Percentage = round(percent_table, 2)
)

# -----------------------------
# 4. Data Visualization
# -----------------------------
# Plotting the number of incidents by year, month, hour, borough, etc.
# (Various ggplot visualizations to showcase data trends)

# Plot the number of incidents by year
ggplot(data, aes(x = as.factor(Year))) +
  geom_bar(stat = "count", fill = "steelblue") +
  labs(title = "Number of Incidents by Year", x = "Year", y = "Count")

# Plot the number of incidents by quarter
ggplot(data, aes(x = as.factor(Month))) +
  geom_bar(stat = "count", fill = "steelblue") +
  labs(title = "Number of Incidents by Month", x = "Month", y = "Count")

# Plot the number of incidents by month
ggplot(data, aes(x = as.factor(Month))) +
  geom_bar(stat = "count", fill = "steelblue") +
  labs(title = "Number of Incidents by Month", x = "Month", y = "Count")
# This plot shows the distribution of shooting incidents across different months.

# Plot the number of incidents by hour of the day
ggplot(data, aes(x = Hour)) +
  geom_histogram(binwidth = 1, fill = "steelblue") +
  labs(title = "Number of Incidents by Hour of the Day", x = "Hour", y = "Count")
# This histogram displays the frequency of incidents at different hours of the day.

# Plot the number of incidents by borough and year
ggplot(data, aes(x = as.factor(Year), fill = as.factor(BORO))) +
  geom_bar(position = "dodge") +
  labs(title = "Number of Incidents by Borough and Year", x = "Year", y = "Number of Incidents") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_brewer(palette = "Paired", name = "Borough") +  
  theme_minimal()

# This plot illustrates the distribution of shooting incidents across different boroughs over the years.

# Plot the distribution of perpetrator's sex
ggplot(data) +
  geom_bar(aes(x = PERP_SEX), fill = "coral") +
  labs(title = "Distribution of Perpetrator's Sex", x = "Sex", y = "Frequency")
# This bar chart represents the frequency of incidents based on the sex of the perpetrators.

# Plot the proportion of jurisdiction codes by borough
ggplot(data, aes(x = BORO, fill = as.factor(JURISDICTION_CODE))) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Proportion of Jurisdiction Codes by Borough", 
       x = "Borough", 
       y = "Proportion", 
       fill = "Jurisdiction Code") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# This plot shows the proportion of different jurisdiction codes within each borough.

# Plot the proportion of victim's sex by year
ggplot(data, aes(x = Year, fill = VIC_SEX)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Victim's Sex by Year", x = "Year", y = "Proportion")
# This plot illustrates the proportion of shooting incidents involving victims of different sexes over the years.

# Plot the distribution of victim's race using a polar chart
ggplot(data, aes(x = "", fill = factor(VIC_RACE))) +
  geom_bar(width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(fill = "Victim's Race") +
  ggtitle("Distribution of Victim's Race")
# This polar bar chart displays the distribution of incidents by the race of the victims.

# -----------------------------
# 5. Spatial Analysis
# -----------------------------

# Read the shapefile for New York City's census tracts
CT_sf <- st_read('/path/to/nyct2020.shp')
# Replace the path with the correct location of your shapefile.

# Assign the original data to a new variable for further processing
incidents <- data

# Prepare and plot spatial data for each year from 2017 to 2022
# Each segment follows the same pattern: 
# - Filter the incidents for the specific year
# - Convert the data to a spatial format
# - Set the coordinate reference system
# - Create a map with census tract boundaries and incident locations

# 2017 Incidents
incidents_2017 <- incidents[incidents$Year == 2017, ]
coordinates(incidents_2017) <- ~Longitude+Latitude
incidents_sf_2017 <- st_as_sf(incidents_2017)
incidents_sf_2017 <- st_set_crs(incidents_sf_2017, 4326)
ggplot() +
  geom_sf(data = CT_sf, fill = "lightgray") +
  geom_sf(data = incidents_sf_2017, color = "red", size = 0.2) +
  theme_minimal() +
  labs(title = "Map of Shooting Incidents in NYC for the Year 2017", x = "Longitude", y = "Latitude")

# Repeat the same process for the years 2018 to 2022
# Replace 'incidents_2017' with 'incidents_2018', 'incidents_2019', etc.
# Change the color in 'geom_sf' for visual distinction

# 2018 Incidents
# ...

# 2019 Incidents
# ...

# 2020 Incidents
# ...

# 2021 Incidents
# ...

# 2022 Incidents
# ...

# -----------------------------
# Combining Yearly Maps into a Single Plot
# -----------------------------

incidents_sf_all <- rbind(incidents_sf_2017, incidents_sf_2018, incidents_sf_2019, incidents_sf_2020, incidents_sf_2021, incidents_sf_2022)

incidents_sf_all$Year <- as.factor(incidents_sf_all$Year)

# Combine all plots into a single plot

ggplot(data = incidents_sf_all) +
  geom_sf(data = CT_sf, fill = "lightgray", color = NA) + 
  geom_sf(aes(color = Year), size = 0.3) + 
  facet_wrap(~Year) + 
  theme_minimal() +
  labs(title = "Map of Shooting Incidents in NYC (2017-2022)",
       x = "Longitude", y = "Latitude") +
  theme(legend.position = "bottom")

# -----------------------------
# 6. Moran's I Test for Spatial Autocorrelation
# -----------------------------

# Convert the incident data to a spatial format
points_sf <- st_as_sf(data, coords = c("Longitude", "Latitude"), crs = 4326)
points_sf <- st_transform(points_sf, st_crs(CT_sf))

# Join the incident data with the census tract shapefile
joined_data <- st_join(points_sf, CT_sf)

# Group and summarize shooting counts by census tract
ct_shootings_count <- joined_data %>%
  group_by(CT2020) %>%
  summarise(count = n(),
            geometry = first(geometry))

# Prepare a list of census tracts for spatial analysis
ct_list <- CT_sf %>% select(CT2020, geometry)

# Join the count data with the census tract list
ct_shootings_count <- st_join(ct_list, ct_shootings_count)

# Replace NA counts with zero and remove unnecessary column
ct_shootings_count$count[is.na(ct_shootings_count$count)] <- 0
ct_shootings_count <- ct_shootings_count[,-2]
ct_shootings_count <- ct_shootings_count %>% rename(CT2020 = CT2020.x)

# Load spatial dependency library
library(spdep)

# Create a neighbors list for the census tracts
nb <- poly2nb(CT_sf)
lw <- nb2listw(nb, style="W", zero.policy=TRUE)

# Perform Global Moran's I test
global_moran <- moran.test(ct_shootings_count$count, listw = lw, zero.policy = TRUE)
print(global_moran)
# This test evaluates overall spatial autocorrelation in shooting incidents.

# Visualize the Global Moran's I result
moran.plot(ct_shootings_count$count, listw = lw, zero.policy = TRUE)
# This plot helps in understanding the spatial autocorrelation distribution.

# Perform Local Moran's I test
local_moran <- localmoran(ct_shootings_count$count, lw,zero.policy = TRUE)

# Convert Local Moran's I output to a data frame
local_moran_df <- as.data.frame(local_moran)
colnames(local_moran_df) <- c("Ii", "Var.Ii", "Z.Ii", "Pr(z > 0)")

# Plot Local Moran's I results
ggplot(local_moran_df, aes(x = Ii, y = Z.Ii, color = Z.Ii)) +
  geom_point() +
  scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  labs(title = "Local Moran's I", x = "Moran's I", y = "Z-Score of Moran's I") +
  theme_minimal() +
  coord_fixed()
# This plot shows local spatial autocorrelation, indicating areas of clustering.

# -----------------------------
# 7. Quadrat and Kernel Density Analysis for the year 2022
# -----------------------------

# Select data for the year 2022
data_Point <- data[data$Year == 2022, ]

# Set coordinates for spatial analysis
coordinates(data_Point) <- ~Longitude+Latitude

# Convert data to 'SpatialPoints' format for spatstat analysis
data_Point <- as(data_Point, "SpatialPoints")

# Set projection to WGS84 and transform to NAD83 / New York Long Island
proj4string(data_Point) <- CRS("+init=epsg:4326")
data_Point <- spTransform(data_Point, CRS("+init=epsg:2263"))

# Create a window object from the census tract shapefile for bounding the analysis
W <- as.owin(CT_sf)  

# Convert the data to a point pattern object within the defined window
data_ppp <- ppp(coordinates(data_Point)[,1], coordinates(data_Point)[,2], window=W)

# Perform quadrat counting with specified grid dimensions
Q <- quadratcount(data_ppp, nx=20, ny=20)

# Plot the point pattern with the quadrat count overlay
plot(data_ppp, pch=2, col="grey70", main=NULL)
plot(Q, add=TRUE)

# Calculate and plot the intensity of points within each quadrat
Q_d <- intensity(Q)
plot(intensity(Q, image=TRUE), main=NULL, las=1)
# Optionally, add the original points on top for more context

# Perform Kernel Density Estimation with a specified bandwidth
K1 <- density(data_ppp, kernel = "quartic", sigma=2000)  

# Plot the density estimation and add contours for clarity
plot(K1, main=NULL, las=1)
contour(K1, add=TRUE)
