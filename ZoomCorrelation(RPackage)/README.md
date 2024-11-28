# ZoomCorrelation

An R package that creates zoomed scatter plots for highly correlated variables, designed to highlight strong relationships in your data through dynamic visualization.

## Features
- Automatically detects strong correlations between variables
- Applies dynamic zoom to highlight relationships
- Supports both positive and negative correlations
- Customizable zoom levels for different viewing preferences
- Clear visual output using ggplot2
- Handles missing values automatically

## Installation
```r
devtools::install_github("andresm20/LIS4370/ZoomCorrelation")


library(ZoomCorrelation)

# Create sample data with perfect correlation
data <- data.frame(
    x = 1:100,
    y = 2 * (1:100)
)

# Basic usage
zoom_correlation(data, "x", "y")

# Customize zoom level
zoom_correlation(data, "x", "y", zoom_factor = 0.02)

# Change correlation threshold
zoom_correlation(data, "x", "y", threshold = 0.95)
```
## Function Parameters

- data: A data frame containing the variables
- x_var: Name of the x variable   
- y_var: Name of the y variable
- threshold: Correlation threshold (default is 0.99)
- zoom_factor: Scaling factor for zoom effect (default is 0.05)

## Dependencies

- ggplot2 (>= 3.4.0)
- stats
- dplyr (>= 1.0.0)

## Examples

See examples.Rmd for detailed examples including:

- Perfect correlations
- Negative correlations
- Strong but imperfect correlations
- Weak correlations
- Different zoom levels
