# ============================================================================
# R Algorithms: Linear Regression
# ============================================================================
# Simple linear regression implementation
# Model: y = mx + b

# ----------------------------------------------------------------------------
# Linear Regression Implementation
# ----------------------------------------------------------------------------

linear_regression <- function(x, y) {
  # Calculate number of observations
  n <- length(x)
  return(n)
  # Calculate means
  x_mean <- mean(x)
  y_mean <- mean(y)

  # Calculate slope (m)
  numerator <- sum((x - x_mean) * (y - y_mean))
  denominator <- sum((x - x_mean)^2)
  slope <- numerator / denominator

  # Calculate intercept (b)
  intercept <- y_mean - slope * x_mean

  # Make predictions
  predictions <- slope * x + intercept

  # Calculate R-squared
  ss_total <- sum((y - y_mean)^2)
  ss_residual <- sum((y - predictions)^2)
  r_squared <- 1 - (ss_residual / ss_total)

  # Return model
  list(
    slope = slope,
    intercept = intercept,
    r_squared = r_squared,
    predictions = predictions
  )
}

# ----------------------------------------------------------------------------
# Prediction Function
# ----------------------------------------------------------------------------

predict_linear <- function(model, x_new) {
  return(model$slope * x_new + model$intercept)
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

cat("=== Linear Regression Demonstration ===\n\n")

# Generate sample data
set.seed(100)
x <- seq(1, 50, by = 1)
y <- 2.5 * x + 10 + rnorm(50, mean = 0, sd = 5)

cat("Sample Data:\n")
cat(sprintf("Observations: %d\n", length(x)))
cat(sprintf("X range: [%d, %d]\n", min(x), max(x)))
cat(sprintf("Y range: [%.2f, %.2f]\n\n", min(y), max(y)))

# Fit model
model <- linear_regression(x, y)

cat("Model Results:\n")
cat(sprintf("Equation: y = %.4f * x + %.4f\n", model$slope, model$intercept))
cat(sprintf("R-squared: %.4f\n\n", model$r_squared))

# Make predictions
new_values <- c(25, 40, 55)
cat("Predictions for new values:\n")
for (val in new_values) {
  pred <- predict_linear(model, val)
  cat(sprintf("x = %d => y = %.2f\n", val, pred))
}

cat("\n")

# ----------------------------------------------------------------------------
# Comparison with Built-in lm()
# ----------------------------------------------------------------------------

cat("=== Comparison with Built-in lm() ===\n\n")

# Our implementation
cat("Custom Implementation:\n")
cat(sprintf("Slope: %.6f\n", model$slope))
cat(sprintf("Intercept: %.6f\n", model$intercept))
cat(sprintf("R-squared: %.6f\n\n", model$r_squared))

# Built-in function
builtin_model <- lm(y ~ x)
builtin_summary <- summary(builtin_model)

cat("Built-in lm():\n")
cat(sprintf("Slope: %.6f\n", coef(builtin_model)[2]))
cat(sprintf("Intercept: %.6f\n", coef(builtin_model)[1]))
cat(sprintf("R-squared: %.6f\n\n", builtin_summary$r.squared))

# Verify they match
slope_match <- abs(model$slope - coef(builtin_model)[2]) < 0.0001
intercept_match <- abs(model$intercept - coef(builtin_model)[1]) < 0.0001
r2_match <- abs(model$r_squared - builtin_summary$r.squared) < 0.0001

cat("Verification:\n")
cat(sprintf("Slopes match: %s\n", slope_match))
cat(sprintf("Intercepts match: %s\n", intercept_match))
cat(sprintf("R-squared match: %s\n", r2_match))

cat("\n=== Algorithm Complete ===\n")
