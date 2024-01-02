# NYC-Shooting-Incident-Data-Analysis
This project reflects a thorough approach to understanding gun violence patterns in NYC, employing both traditional statistical analysis and advanced spatial techniques.

## Introduction
This repository hosts an in-depth spatial and temporal analysis of the NYPD Shooting Incident Data (Historic). The project aims to uncover the patterns and trends of gun violence incidents in New York City using advanced data analysis techniques. This analysis is crucial for understanding urban crime dynamics and contributing to public safety strategies.

## Data Sources
This analysis utilizes datasets from NYC Open Data and the US Census Bureau:

1. **NYPD Shooting Incident Data (Historic)**
   - Description: Records of shooting incidents in New York City as reported by the NYPD.
   - Access: Download at [NYPD Shooting Incident Data (Historic)](https://data.cityofnewyork.us/Public-Safety/NYPD-Shooting-Incident-Data-Historic-/833y-fsy8).

2. **2020 Census Tracts for New York City (Clipped to Shoreline)**
   - Description: Shapefile for New York City census tracts, derived from the US Census Bureau's TIGER products and modified to fit the NYC base map.
   - Access: Download at [Census - Download and Metadata](https://www.nyc.gov/site/planning/data-maps/open-data/census-download-metadata.page).

## Methodology

### Data Preprocessing
The NYPD Shooting Incident Data is cleaned and structured for analysis. Dates are converted to the correct format, and records are filtered by coordinates and time range (2017-2022).

### Data Visualization
Visualizations are generated to display the distribution and frequency of incidents and the characteristics of victims, using bar charts, histograms, and pie charts. They are saved as image files in the [Visualizations](Visualization) folder.

<p float="left">
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Annual%20Shooting%20Incidents%20Bar%20Chart.png" width="45%" />
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Shooting%20Incidents%20by%20Borough%20and%20Year%20Bar%20Chart.png" width="54%" /> 
</p>

<p float="left">
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Proportion%20of%20Victim's%20Sex%20by%20Year%20Bar%20Chart.png" width="49%" />
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Victims%20Race%20Distribution%20Pie%20Chart.png" width="49%" /> 
</p>


### Spatial Analysis
The spatial analysis focuses on examining the geographic distribution of shooting incidents across New York City's census tracts. By plotting incidents onto maps for each year, the scripts provide a visual representation of where shootings are concentrated. 

The analysis involves transforming the data into a spatial format that aligns with NYC's census tract shapefile. This allows for an accurate overlay of incidents on the city's map, offering a clear visual perspective of areas with higher frequencies of gun violence. 

<p align="center">
<img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Composite%20Map%20of%20Shooting%20Incidents%20in%20NYC%20(2017-2022).png" width="80%" /> 
</p>

### Moran's I Test for Spatial Autocorrelation
The Moran's I test is used to measure spatial autocorrelation, indicating whether the pattern of shootings is dispersed, clustered, or random across the city. Global Moran's I provides a single summary measure, giving an overall indication of spatial clustering. Local Moran's I, on the other hand, identifies specific locations where shootings are significantly clustered. 

<p align="center">
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Moran's%20I%20Test%20Results%20Summary.png" width="60%" />

The test results are visualized to highlight these areas, contributing to a more nuanced understanding of the spatial dynamics at play. 

<p align="center">
<img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Local%20Moran's%20I%20Scatter%20Plot.png" width="70%" /> 
</p>

### Quadrat and Kernel Density Analysis
This section of the code applies Quadrat and Kernel Density Analysis to the 2022 data, offering geographic hotspots of shooting incidents in the city. Quadrat counting divides the map into a grid, counting the number of incidents within each quadrat, which helps in identifying areas with unusually high or low counts. The Kernel Density Estimation then calculates the probability density of shooting occurrences over the space, smoothing out the distribution to understand the broader patterns of intensity across the city. 

<p float="left">
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Quadrat%20Analysis%20of%20Shooting%20Incidents%20in%20NYC.png" width="45%" />
  <img src="https://github.com/Chloe1123/NYC-Shooting-Incident-Data-Analysis/blob/main/Visualization/Kernel%20Density%20Estimation%20Map%20of%20Shootings%20in%20NYC.png" width="45%" /> 
</p>


## Key Findings
- The data displays a clear seasonal pattern, with the lowest numbers of shootings occurring in the colder months of January and February and peaking during the summer, especially in July.
- Certain boroughs and neighborhoods in New York City showed higher concentrations of shooting incidents, indicating non-uniform distribution of gun violence.
- The Moran's I test results confirmed significant spatial autocorrelation, suggesting that shootings are not randomly distributed but are influenced by underlying factors.
- Quadrat and Kernel Density Analyses highlighted specific areas within boroughs that experienced a higher intensity of incidents, which can inform targeted, data-driven approaches to reducing gun violence.

## Usage
Instructions for running the analysis and replicating visualizations are provided in the script files. The datasets should be in the same directory or appropriately linked within the scripts.

## Dependencies
- R (Version 3.6.0 or later)
- R Packages: `apaTables`, `lubridate`, `dplyr`, `knitr`, `sf`, `spatstat`, `ggplot2`, `sp`, `patchwork`

## License
This project is licensed under the [MIT License](LICENSE.md).
