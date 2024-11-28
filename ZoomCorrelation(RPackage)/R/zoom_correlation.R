#' Zoom Plot Based on Perfect Correlation
#'
#' Creates a scatter plot with automatic zoom for highly correlated variables.
#' The function determines correlation strength and applies appropriate zoom levels
#' to highlight the relationship between variables.
#'
#' @param data A data frame containing the variables (must contain numeric columns)
#' @param x_var Name of the x variable (must be a numeric column in data)
#' @param y_var Name of the y variable (must be a numeric column in data)
#' @param threshold Correlation threshold (default is 0.99, range 0 to 1)
#' @param zoom_factor Scaling factor for the zoom effect (default is 0.05, smaller values = more zoom)
#'
#' @return A ggplot object with:
#'   \itemize{
#'     \item Scatter plot of x vs y variables
#'     \item Automatic zoom if correlation exceeds threshold
#'     \item Informative title and axis labels
#'   }
#' @export
#'
#' @examples
#' # Perfect positive correlation
#' test_perfect <- data.frame(x = 1:100, y = 2 * (1:100))
#' zoom_correlation(test_perfect, "x", "y")
#'
#' # Custom zoom level
#' zoom_correlation(test_perfect, "x", "y", zoom_factor = 0.02)
#'
#' # Different threshold
#' zoom_correlation(test_perfect, "x", "y", threshold = 0.95)
zoom_correlation <- function(data, x_var, y_var, threshold = 0.99, zoom_factor = 0.05) {
  # Input validation: Check if variables are numeric type
  # This ensures the correlation calculation will work
  if (!is.numeric(data[[x_var]]) || !is.numeric(data[[y_var]])) {
    stop("Both x_var and y_var must be numeric.")
  }

  # Data validation: Ensure the data frame contains observations
  # Prevents errors from empty datasets
  if (nrow(data) == 0) {
    stop("Data frame is empty. Please provide valid data.")
  }

  # Calculate Pearson correlation coefficient
  # use = "complete.obs" handles missing values by removing them
  correlation <- cor(data[[x_var]], data[[y_var]], use = "complete.obs")

  # Initialize the base scatter plot
  # Using ggplot2 for consistent and professional visualization
  p <- ggplot2::ggplot(data, ggplot2::aes(x = .data[[x_var]], y = .data[[y_var]])) +
    ggplot2::geom_point() +
    ggplot2::labs(
      title = paste("Zoomed Plot for", x_var, "vs", y_var),
      x = x_var,
      y = y_var
    )

  # Apply zoom effect for high correlations
  # Only zoom if correlation exceeds threshold
  if (abs(correlation) >= threshold) {
    message("Zoom applied: Correlation = ", round(correlation, 2))

    # Calculate zoom window parameters
    # Center the view on the mean of each variable
    x_range <- range(data[[x_var]], na.rm = TRUE)
    y_range <- range(data[[y_var]], na.rm = TRUE)
    x_center <- mean(x_range)
    y_center <- mean(y_range)

    # Apply zoom using coord_cartesian
    # zoom_factor controls how tight the zoom is (smaller = more zoom)
    p <- p + ggplot2::coord_cartesian(
      xlim = x_center + c(-zoom_factor, zoom_factor) * diff(x_range),
      ylim = y_center + c(-zoom_factor, zoom_factor) * diff(y_range)
    )
  } else {
    message("Correlation below threshold: No zoom applied.")
  }

  return(p)
}

