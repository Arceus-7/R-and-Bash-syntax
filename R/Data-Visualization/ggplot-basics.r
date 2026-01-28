# ============================================================================
# R Data Visualization: ggplot2 Basics
# ============================================================================

# Install ggplot2 if needed
if (!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)
} else {
  library(ggplot2)
}

# ----------------------------------------------------------------------------
# 1. SCATTER PLOT
# ----------------------------------------------------------------------------

data(mtcars)

# Basic scatter plot
p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(
    title = "Car Weight vs MPG",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon"
  ) +
  theme_minimal()
print(p1)

# With color by category
p2 <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(
    title = "Car Weight vs MPG by Cylinder",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon",
    color = "Cylinders"
  ) +
  theme_minimal()
print(p2)

# ----------------------------------------------------------------------------
# 2. BAR PLOT
# ----------------------------------------------------------------------------

cyl_counts <- as.data.frame(table(mtcars$cyl))
names(cyl_counts) <- c("Cylinders", "Count")

p3 <- ggplot(cyl_counts, aes(x = Cylinders, y = Count, fill = Cylinders)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Number of Cars by Cylinder",
    x = "Number of Cylinders",
    y = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
print(p3)

# ----------------------------------------------------------------------------
# 3. LINE PLOT
# ----------------------------------------------------------------------------

time_data <- data.frame(
  time = 1:100,
  value = cumsum(rnorm(100))
)

p4 <- ggplot(time_data, aes(x = time, y = value)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  labs(
    title = "Random Walk Time Series",
    x = "Time",
    y = "Value"
  ) +
  theme_minimal()
print(p4)

# ----------------------------------------------------------------------------
# 4. HISTOGRAM
# ----------------------------------------------------------------------------

p5 <- ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(bins = 10, fill = "skyblue", color = "black") +
  labs(
    title = "Distribution of MPG",
    x = "Miles per Gallon",
    y = "Frequency"
  ) +
  theme_minimal()
print(p5)

# ----------------------------------------------------------------------------
# 5. BOX PLOT
# ----------------------------------------------------------------------------

p6 <- ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(
    title = "MPG Distribution by Cylinder",
    x = "Number of Cylinders",
    y = "Miles per Gallon",
    fill = "Cylinders"
  ) +
  theme_minimal()
print(p6)
