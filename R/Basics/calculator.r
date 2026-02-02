# ============================================================================
# R Basics: R as a Calculator
# ============================================================================
# Using R for mathematical calculations

# ----------------------------------------------------------------------------
# 1. BASIC ARITHMETIC OPERATIONS
# ----------------------------------------------------------------------------

# Addition
cat("10 + 5 =", 10 + 5, "\n")

# Subtraction
cat("20 - 7 =", 20 - 7, "\n")

# Multiplication
cat("6 * 8 =", 6 * 8, "\n")

# Division
cat("50 / 4 =", 50 / 4, "\n")

# Integer division
cat("50 %/% 4 =", 50 %/% 4, "\n")

# Modulo (remainder)
cat("17 %% 5 =", 17 %% 5, "\n")

# Exponentiation
cat("2^10 =", 2^10, "\n")
cat("5^3 =", 5^3, "\n")

# ----------------------------------------------------------------------------
# 2. OPERATOR PRECEDENCE
# ----------------------------------------------------------------------------

# Follows PEMDAS/BODMAS
cat("2 + 3 * 4 =", 2 + 3 * 4, "\n")
cat("(2 + 3) * 4 =", (2 + 3) * 4, "\n")
cat("10 - 2^3 =", 10 - 2^3, "\n")
cat("100 / 5 * 2 =", 100 / 5 * 2, "\n")

# Complex expression
result <- ((10 + 5) * 2 - 8) / 4
cat("((10 + 5) * 2 - 8) / 4 =", result, "\n")

# ----------------------------------------------------------------------------
# 3. MATHEMATICAL FUNCTIONS
# ----------------------------------------------------------------------------

# Absolute value
cat("abs(-15) =", abs(-15), "\n")

# Square root
cat("sqrt(144) =", sqrt(144), "\n")

# Power
cat("10^2 =", 10^2, "\n")
cat("pow(2, 8) with ^:", 2^8, "\n")

# Logarithms
cat("log(100) =", log(100), "(natural log)\n")
cat("log10(100) =", log10(100), "(base 10)\n")
cat("log2(1024) =", log2(1024), "(base 2)\n")
cat("log(8, base=2) =", log(8, base = 2), "\n")

# Exponential
cat("exp(1) =", exp(1), "(e)\n")
cat("exp(2) =", exp(2), "\n")

# ----------------------------------------------------------------------------
# 4. TRIGONOMETRIC FUNCTIONS
# ----------------------------------------------------------------------------

# Sine, cosine, tangent (in radians)
cat("sin(pi/2) =", sin(pi / 2), "\n")
cat("cos(0) =", cos(0), "\n")
cat("tan(pi/4) =", tan(pi / 4), "\n")

# Convert degrees to radians
degrees <- 45
radians <- degrees * pi / 180
cat("sin(45°) =", sin(radians), "\n")

# Inverse trigonometric
cat("asin(1) =", asin(1), "\n")
cat("acos(0) =", acos(0), "\n")
cat("atan(1) =", atan(1), "\n")

# ----------------------------------------------------------------------------
# 5. ROUNDING FUNCTIONS
# ----------------------------------------------------------------------------

x <- 3.7859

# Round to nearest integer
cat("round(3.7859) =", round(x), "\n")

# Round to specific decimal places
cat("round(3.7859, 2) =", round(x, 2), "\n")

# Floor (round down)
cat("floor(3.7859) =", floor(x), "\n")

# Ceiling (round up)
cat("ceiling(3.7859) =", ceiling(x), "\n")

# Truncate (remove decimals)
cat("trunc(3.7859) =", trunc(x), "\n")

# ----------------------------------------------------------------------------
# 6. SPECIAL NUMBERS
# ----------------------------------------------------------------------------

# Pi
cat("pi =", pi, "\n")

# Euler's number
cat("e = exp(1) =", exp(1), "\n")

# Infinity
cat("Inf + 10 =", Inf + 10, "\n")
cat("1 / 0 =", 1 / 0, "\n")

# NaN (Not a Number)
cat("0 / 0 =", 0 / 0, "\n")
cat("Inf - Inf =", Inf - Inf, "\n")

# ----------------------------------------------------------------------------
# 7. VECTOR ARITHMETIC
# ----------------------------------------------------------------------------

# Element-wise operations
v1 <- c(10, 20, 30, 40, 50)
v2 <- c(1, 2, 3, 4, 5)

cat("v1 + v2:", v1 + v2, "\n")
cat("v1 - v2:", v1 - v2, "\n")
cat("v1 * v2:", v1 * v2, "\n")
cat("v1 / v2:", v1 / v2, "\n")
cat("v1^2:", v1^2, "\n")

# Scalar operations
cat("v1 + 10:", v1 + 10, "\n")
cat("v1 * 2:", v1 * 2, "\n")

# ----------------------------------------------------------------------------
# 8. STATISTICAL CALCULATIONS
# ----------------------------------------------------------------------------

data <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

# Mean
cat("Mean:", mean(data), "\n")

# Median
cat("Median:", median(data), "\n")

# Standard deviation
cat("SD:", sd(data), "\n")

# Variance
cat("Variance:", var(data), "\n")

# Min and max
cat("Min:", min(data), "Max:", max(data), "\n")

# Range
cat("Range:", range(data), "\n")

# Sum
cat("Sum:", sum(data), "\n")

# Product
cat("Product:", prod(c(2, 3, 4, 5)), "\n")

# Quantiles
cat("Quantiles:", quantile(data, c(0.25, 0.5, 0.75)), "\n")

# ----------------------------------------------------------------------------
# 9. COMBINATORICS
# ----------------------------------------------------------------------------

# Factorial
cat("5! =", factorial(5), "\n")

# Combinations: choose(n, k) = n! / (k!(n-k)!)
cat("Choose 5 from 10:", choose(10, 5), "\n")

# ----------------------------------------------------------------------------
# 10. SEQUENCES AND SERIES
# ----------------------------------------------------------------------------

# Arithmetic sequence
seq1 <- seq(1, 10, by = 2)
cat("Sequence 1 to 10 by 2:", seq1, "\n")

# Sum of sequence
cat("Sum of 1:100:", sum(1:100), "\n")

# Cumulative sum
cat("Cumulative sum of 1:5:", cumsum(1:5), "\n")

# Product series
cat("Cumulative product of 1:5:", cumprod(1:5), "\n")

# ----------------------------------------------------------------------------
# 11. PRACTICAL CALCULATIONS
# ----------------------------------------------------------------------------

# Circle calculations
radius <- 5
area <- pi * radius^2
circumference <- 2 * pi * radius
cat("Radius:", radius, "\n")
cat("Area:", area, "\n")
cat("Circumference:", circumference, "\n")

# Compound interest: A = P(1 + r/n)^(nt)
principal <- 1000
rate <- 0.05
time <- 10
n <- 12 # monthly compounding
amount <- principal * (1 + rate / n)^(n * time)
cat("Principal:", principal, "\n")
cat("Final amount:", round(amount, 2), "\n")

# Distance formula
x1 <- 0
y1 <- 0
x2 <- 3
y2 <- 4
distance <- sqrt((x2 - x1)^2 + (y2 - y1)^2)
cat("Distance between points:", distance, "\n")

# Quadratic formula: (-b ± sqrt(b^2 - 4ac)) / 2a
a <- 1
b <- -5
c <- 6
discriminant <- b^2 - 4 * a * c
root1 <- (-b + sqrt(discriminant)) / (2 * a)
root2 <- (-b - sqrt(discriminant)) / (2 * a)
cat("Roots:", root1, root2, "\n")

# Temperature conversion
celsius <- 25
fahrenheit <- celsius * 9 / 5 + 32
kelvin <- celsius + 273.15
cat("Celsius:", celsius, "\n")
cat("Fahrenheit:", fahrenheit, "\n")
cat("Kelvin:", kelvin, "\n")

# ----------------------------------------------------------------------------
# 12. COMPLEX NUMBERS
# ----------------------------------------------------------------------------

# Creating complex numbers
z1 <- 3 + 4i
z2 <- 1 - 2i

cat("z1 =", z1, "\n")
cat("z2 =", z2, "\n")

# Complex arithmetic
cat("z1 + z2 =", z1 + z2, "\n")
cat("z1 * z2 =", z1 * z2, "\n")

# Complex functions
cat("Magnitude |z1| =", Mod(z1), "\n")
cat("Argument =", Arg(z1), "\n")
cat("Conjugate =", Conj(z1), "\n")
cat("Real part =", Re(z1), "\n")
cat("Imaginary part =", Im(z1), "\n")
