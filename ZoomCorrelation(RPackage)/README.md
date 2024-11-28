# ZoomCorrelation

An R package that creates zoomed scatter plots for highly correlated variables.

## Features
- Automatically detects strong correlations
- Applies dynamic zoom to highlight relationships
- Supports both positive and negative correlations
- Customizable zoom levels

## Installation
```r
devtools::install_github("andresm20/ZoomCorrelation")

library(ZoomCorrelation)

# Create sample data
data <- data.frame(
    x = 1:100,
    y = 2 * (1:100)
)

# Create zoomed plot
zoom_correlation(data, "x", "y")

# Adjust zoom level
zoom_correlation(data, "x", "y", zoom_factor = 0.02)
