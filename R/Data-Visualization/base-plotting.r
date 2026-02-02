# ============================================================================
# R Data Visualization: Base R Plotting
# ============================================================================
# Frequency and non-frequency plots using base R graphics

# ----------------------------------------------------------------------------
# 1. SCATTER PLOTS
# ----------------------------------------------------------------------------

# Basic scatter plot
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
y <- c(2, 4, 5, 4, 5, 7, 8, 9, 10, 11)

plot(x, y)

# Customized scatter plot
plot(x, y,
    main = "Scatter Plot Example",
    xlab = "X values",
    ylab = "Y values",
    col = "blue",
    pch = 19, # Solid circles
    cex = 1.5
) # Point size

# Multiple series
x2 <- 1:10
y2 <- c(3, 5, 6, 5, 7, 8, 9, 10, 11, 12)

plot(x, y, col = "blue", pch = 19, main = "Multiple Series")
points(x2, y2, col = "red", pch = 17)
legend("topleft",
    legend = c("Series 1", "Series 2"),
    col = c("blue", "red"), pch = c(19, 17)
)

# Add regression line
abline(lm(y ~ x), col = "red", lwd = 2)

# ----------------------------------------------------------------------------
# 2. LINE PLOTS
# ----------------------------------------------------------------------------

# Basic line plot
time <- 1:20
values <- cumsum(rnorm(20))

plot(time, values,
    type = "l",
    main = "Time Series Line Plot",
    xlab = "Time",
    ylab = "Values",
    col = "darkgreen",
    lwd = 2
)

# Different line types
plot(time, values,
    type = "b", # Both points and lines
    col = "purple", pch = 16, lwd = 2
)

# Multiple lines
set.seed(42)
line1 <- cumsum(rnorm(20))
line2 <- cumsum(rnorm(20)) + 2
line3 <- cumsum(rnorm(20)) - 2

plot(time, line1,
    type = "l", col = "red", ylim = range(c(line1, line2, line3)),
    main = "Multiple Line Plot", ylab = "Values"
)
lines(time, line2, col = "blue")
lines(time, line3, col = "green")
legend("topleft",
    legend = c("Line 1", "Line 2", "Line 3"),
    col = c("red", "blue", "green"), lty = 1
)

# ----------------------------------------------------------------------------
# 3. BAR PLOTS
# ----------------------------------------------------------------------------

# Simple bar plot
categories <- c("A", "B", "C", "D", "E")
values <- c(25, 40, 30, 55, 45)

barplot(values,
    names.arg = categories,
    main = "Bar Plot Example",
    xlab = "Categories",
    ylab = "Values",
    col = "steelblue"
)

# Horizontal bar plot
barplot(values,
    names.arg = categories,
    horiz = TRUE,
    col = rainbow(5),
    main = "Horizontal Bar Plot"
)

# Grouped bar plot
data_matrix <- matrix(c(20, 25, 30, 22, 28, 32), nrow = 2)
rownames(data_matrix) <- c("Group A", "Group B")
colnames(data_matrix) <- c("Cat1", "Cat2", "Cat3")

barplot(data_matrix,
    beside = TRUE,
    col = c("lightblue", "lightgreen"),
    main = "Grouped Bar Plot",
    legend = rownames(data_matrix)
)

# Stacked bar plot
barplot(data_matrix,
    col = c("lightblue", "lightgreen"),
    main = "Stacked Bar Plot",
    legend = rownames(data_matrix)
)

# ----------------------------------------------------------------------------
# 4. HISTOGRAMS (FREQUENCY PLOTS)
# ----------------------------------------------------------------------------

# Generate sample data
set.seed(42)
data <- rnorm(1000, mean = 100, sd = 15)

# Basic histogram
hist(data,
    main = "Histogram of Normal Distribution",
    xlab = "Values",
    ylab = "Frequency",
    col = "lightblue",
    border = "black"
)

# Histogram with custom breaks
hist(data,
    breaks = 20, col = "coral",
    main = "Histogram with 20 Bins"
)

# Probability density histogram
hist(data,
    freq = FALSE,
    main = "Probability Density Histogram",
    col = "lightgreen"
)
curve(dnorm(x, mean = 100, sd = 15), add = TRUE, col = "red", lwd = 2)

# Multiple histograms
par(mfrow = c(1, 2)) # 1 row, 2 columns
hist(rnorm(1000), col = "lightblue", main = "Normal Distribution")
hist(rexp(1000), col = "lightcoral", main = "Exponential Distribution")
par(mfrow = c(1, 1)) # Reset

# ----------------------------------------------------------------------------
# 5. BOX PLOTS
# ----------------------------------------------------------------------------

# Single box plot
data <- rnorm(100, mean = 50, sd = 10)
boxplot(data,
    main = "Box Plot Example",
    ylab = "Values",
    col = "lightblue"
)

# Multiple box plots
group1 <- rnorm(50, mean = 50, sd = 10)
group2 <- rnorm(50, mean = 55, sd = 12)
group3 <- rnorm(50, mean = 48, sd = 8)

boxplot(list(Group1 = group1, Group2 = group2, Group3 = group3),
    main = "Comparison of Groups",
    ylab = "Values",
    col = c("lightblue", "lightgreen", "lightcoral")
)

# Horizontal box plot
boxplot(list(Group1 = group1, Group2 = group2, Group3 = group3),
    horizontal = TRUE,
    col = rainbow(3),
    main = "Horizontal Box Plot"
)

# Box plot with formula
scores <- c(rnorm(30, 75, 10), rnorm(30, 82, 10), rnorm(30, 68, 10))
classes <- factor(rep(c("Class A", "Class B", "Class C"), each = 30))
df <- data.frame(scores, classes)

boxplot(scores ~ classes,
    data = df,
    main = "Scores by Class",
    col = c("lightblue", "lightgreen", "lightyellow")
)

# ----------------------------------------------------------------------------
# 6. PIE CHARTS
# ----------------------------------------------------------------------------

# Basic pie chart
slices <- c(30, 25, 20, 15, 10)
labels <- c("A", "B", "C", "D", "E")

pie(slices,
    labels = labels,
    main = "Pie Chart Example",
    col = rainbow(5)
)

# Pie chart with percentages
percentages <- round(slices / sum(slices) * 100, 1)
labels_pct <- paste(labels, percentages, "%", sep = " ")

pie(slices,
    labels = labels_pct,
    main = "Pie Chart with Percentages",
    col = c("red", "blue", "green", "yellow", "purple")
)

# 3D pie chart (requires additional setup)
# pie(slices, labels = labels, col = rainbow(5), main = "3D Pie Chart")

# ----------------------------------------------------------------------------
# 7. GRAPHICAL PARAMETERS
# ----------------------------------------------------------------------------

# Point characters (pch)
plot(1:25, 1:25,
    pch = 1:25, cex = 2,
    main = "Point Characters (pch)",
    xlab = "Index", ylab = "Value"
)

# Line types (lty)
plot(1:5, 1:5, type = "n", main = "Line Types (lty)")
for (i in 1:6) {
    lines(c(1, 5), c(i, i), lty = i, lwd = 2)
    text(0.5, i, paste("lty =", i))
}

# Colors
plot(1:10, 1:10,
    col = rainbow(10), pch = 19, cex = 3,
    main = "Rainbow Colors"
)

# Custom colors
colors_custom <- c("red", "blue", "green", "purple", "orange")
barplot(1:5, col = colors_custom, main = "Custom Colors")

# ----------------------------------------------------------------------------
# 8. ADDING ELEMENTS TO PLOTS
# ----------------------------------------------------------------------------

# Base plot
plot(1:10, (1:10)^2,
    type = "p", pch = 19,
    main = "Plot with Additional Elements"
)

# Add lines
abline(h = 50, col = "red", lty = 2, lwd = 2) # Horizontal line
abline(v = 5, col = "blue", lty = 2, lwd = 2) # Vertical line

# Add points
points(c(3, 7), c(25, 75), col = "green", pch = 17, cex = 2)

# Add text
text(5, 90, "Peak area", col = "purple")

# Add arrows
arrows(2, 50, 4, 20, col = "orange", lwd = 2)

# Add grid
grid()

# ----------------------------------------------------------------------------
# 9. MULTIPLE PLOTS LAYOUT
# ----------------------------------------------------------------------------

# 2x2 layout
par(mfrow = c(2, 2))

plot(1:10, 1:10, main = "Plot 1")
plot(1:10, (1:10)^2, main = "Plot 2")
hist(rnorm(100), main = "Plot 3")
boxplot(rnorm(100), main = "Plot 4")

par(mfrow = c(1, 1)) # Reset

# Custom layout
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = TRUE))
plot(1:10, main = "Large Plot")
plot(1:5, main = "Small Plot 1")
plot(5:1, main = "Small Plot 2")
layout(1) # Reset

# ----------------------------------------------------------------------------
# 10. CUSTOMIZING AXES
# ----------------------------------------------------------------------------

# Custom axis limits
plot(1:10, 1:10,
    xlim = c(0, 15),
    ylim = c(0, 15),
    main = "Custom Axis Limits"
)

# Custom axis labels
plot(1:5, c(10, 20, 30, 40, 50),
    xaxt = "n", # Suppress default x-axis
    main = "Custom Axis Labels"
)
axis(1, at = 1:5, labels = c("Mon", "Tue", "Wed", "Thu", "Fri"))

# Log scale
x <- 1:100
y <- exp(x / 10)
plot(x, y, log = "y", main = "Log Scale")

# ----------------------------------------------------------------------------
# 11. DENSITY PLOTS
# ----------------------------------------------------------------------------

# Density estimation
data <- rnorm(500, mean = 100, sd = 15)
density_est <- density(data)

plot(density_est,
    main = "Density Plot",
    xlab = "Values",
    ylab = "Density",
    col = "blue",
    lwd = 2
)

# Filled density plot
plot(density_est, main = "Filled Density Plot")
polygon(density_est, col = "lightblue", border = "blue")

# ----------------------------------------------------------------------------
# 12. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Student performance visualization
scores <- c(
    65, 70, 75, 80, 85, 72, 78, 88, 92, 68,
    75, 82, 87, 73, 79, 84, 89, 94, 71, 76
)

par(mfrow = c(2, 2))

# Histogram
hist(scores,
    col = "lightblue", main = "Score Distribution",
    xlab = "Scores", breaks = 10
)

# Box plot
boxplot(scores,
    col = "lightgreen", main = "Score Summary",
    ylab = "Scores"
)

# Density plot
plot(density(scores),
    main = "Score Density",
    col = "blue", lwd = 2
)
polygon(density(scores), col = rgb(0, 0, 1, 0.3))

# Cumulative plot
plot(sort(scores), seq_along(scores) / length(scores),
    type = "s", main = "Cumulative Distribution",
    xlab = "Scores", ylab = "Cumulative Proportion"
)

par(mfrow = c(1, 1))

# Example 2: Sales trend analysis
months <- 1:12
sales <- c(100, 120, 115, 130, 145, 140, 155, 160, 158, 170, 180, 190)

plot(months, sales,
    type = "b", pch = 19, col = "darkblue",
    main = "Monthly Sales Trend", xlab = "Month", ylab = "Sales ($1000)",
    xaxt = "n"
)
axis(1, at = 1:12, labels = c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
))
abline(lm(sales ~ months), col = "red", lty = 2, lwd = 2)
grid()

# Example 3: Category comparison
categories <- c("Product A", "Product B", "Product C", "Product D")
q1 <- c(50, 60, 45, 70)
q2 <- c(55, 65, 50, 75)
q3 <- c(60, 70, 55, 80)
q4 <- c(65, 75, 60, 85)

data_matrix <- rbind(q1, q2, q3, q4)
colnames(data_matrix) <- categories

barplot(data_matrix,
    beside = TRUE,
    col = c("red", "green", "blue", "yellow"),
    main = "Quarterly Sales by Product",
    ylab = "Sales",
    legend = c("Q1", "Q2", "Q3", "Q4"),
    args.legend = list(x = "topleft")
)
