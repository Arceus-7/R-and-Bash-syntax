# Numerical Integration in R
# Packages: pracma, cubature, deSolve

if (!require(pracma)) install.packages("pracma")
if (!require(cubature)) install.packages("cubature")
library(pracma)
library(cubature)

# ============================================================================
# 1. BASE R integrate() — Adaptive Quadrature
# ============================================================================

# ∫₀^π sin(x) dx = 2
integrate(sin, 0, pi)

# ∫₀^1 x² dx = 1/3
integrate(function(x) x^2, 0, 1)

# ∫₀^∞ exp(-x²) dx = √π/2
integrate(function(x) exp(-x^2), 0, Inf)

# With parameters
f_param <- function(x, a, b) a * exp(-b * x)
integrate(f_param, 0, Inf, a = 2, b = 3) # 2/3

# ============================================================================
# 2. TRAPEZOIDAL RULE (pracma)
# ============================================================================

# From a formula
x <- seq(0, pi, length.out = 1000)
y <- sin(x)
trapz(x, y) # ≈ 2

# Coarse vs fine grid comparison
ns <- c(10, 50, 100, 500, 1000)
trap_results <- sapply(ns, function(n) {
    x <- seq(0, pi, length.out = n)
    trapz(x, sin(x))
})
data.frame(n = ns, result = trap_results, error = abs(trap_results - 2))

# From discrete measured data (no formula)
time <- c(0, 1, 3, 5, 7, 10)
velocity <- c(0, 5, 12, 18, 22, 25)
distance <- trapz(time, velocity) # total distance traveled

# ============================================================================
# 3. SIMPSON'S RULE (pracma)
# ============================================================================

# simpson(f, a, b, n) takes a function, bounds, and number of subintervals
# ∫₀^π sin(x) dx
simpson(sin, 0, pi, n = 100) # ≈ 2

# Compare accuracy: Simpson vs Trapezoidal
f_test <- function(x) exp(-x^2) * cos(2 * x)
exact_val <- integrate(f_test, 0, 3)$value

x_coarse <- seq(0, 3, length.out = 21)
trap_val <- trapz(x_coarse, f_test(x_coarse))
simp_val <- simpson(f_test, 0, 3, n = 20)
data.frame(
    method = c("trapezoidal", "simpson", "adaptive"),
    value = c(trap_val, simp_val, exact_val),
    error = c(abs(trap_val - exact_val), abs(simp_val - exact_val), 0)
)

# ============================================================================
# 4. GAUSS-LEGENDRE QUADRATURE (pracma)
# ============================================================================

# High-precision integration using Gauss nodes and weights
gl <- gaussLegendre(n = 20, a = 0, b = pi)
sum(gl$w * sin(gl$x)) # ≈ 2

# Higher order for oscillatory function
gl64 <- gaussLegendre(n = 64, a = 0, b = 10)
sum(gl64$w * sin(10 * gl64$x)) # ∫₀^¹⁰ sin(10x) dx

# ============================================================================
# 5. IMPROPER INTEGRALS
# ============================================================================

# Infinite upper limit: ∫₁^∞ 1/x² dx = 1
integrate(function(x) 1 / x^2, 1, Inf)

# Both limits infinite: ∫₋∞^∞ exp(-x²) dx = √π
integrate(function(x) exp(-x^2), -Inf, Inf)

# Singularity at boundary: ∫₀^1 1/√x dx = 2
integrate(function(x) 1 / sqrt(x), 0, 1)

# Cauchy principal value via pracma: ∫₋₁^1 1/x dx (PV = 0)
# Split and use limits
eps <- 1e-10
left <- integrate(function(x) 1 / x, -1, -eps)$value
right <- integrate(function(x) 1 / x, eps, 1)$value
left + right # ≈ 0

# ============================================================================
# 6. MULTIDIMENSIONAL INTEGRATION (pracma and cubature)
# ============================================================================

# Using pracma's integral2 for double integration over regions
# Ex: Volume of sphere x^2 + y^2 + z^2 = 1.
# Upper hemisphere z = sqrt(1 - x^2 - y^2) integrated over circle x^2 + y^2 <= 1
f_sphere <- function(x, y) { sqrt(1 - x^2 - y^2) }
# y limits depend on x: from 0 to sqrt(1-x^2) for positive quadrant
ymax <- function(x) { sqrt(1 - x^2) }
# Integrate over first quadrant, total volume is 8 * integral
V_quad <- integral2(f_sphere, 0, 1, 0, ymax)
cat("\nPracma integral2 (1st quadrant sphere):", V_quad$Q, "\n")
cat("Total Sphere Volume (8 * V_quad):", 8 * V_quad$Q, "\n")
cat("Analytical Volume (4*pi/3):", 4 * pi / 3, "\n\n")

# Using cubature's adaptIntegrate
# Double integral: ∫∫ x*y dA over [0,1]×[0,1] = 1/4
f_2d <- function(x) x[1] * x[2]
adaptIntegrate(f_2d, lowerLimit = c(0, 0), upperLimit = c(1, 1))

# ∫∫ exp(-(x²+y²)) dA over [-∞,∞]×[-∞,∞] → use finite domain
adaptIntegrate(
    function(x) exp(-(x[1]^2 + x[2]^2)),
    lowerLimit = c(-10, -10),
    upperLimit = c(10, 10)
) # ≈ π

# Triple integral: ∫∫∫ x²+y²+z² dV over unit cube = 1
adaptIntegrate(
    function(x) x[1]^2 + x[2]^2 + x[3]^2,
    lowerLimit = c(0, 0, 0),
    upperLimit = c(1, 1, 1)
) # = 1

# Volume of unit sphere: ∫∫∫ 1 dV where x²+y²+z² ≤ 1
adaptIntegrate(
    function(x) ifelse(sum(x^2) <= 1, 1, 0),
    lowerLimit = c(-1, -1, -1),
    upperLimit = c(1, 1, 1),
    maxEval = 1e6
) # ≈ 4π/3

# ============================================================================
# 7. MONTE CARLO INTEGRATION
# ============================================================================

set.seed(42)

# ∫₀^1 x² dx = 1/3
mc_integrate_1d <- function(f, a, b, n) {
    x <- runif(n, a, b)
    (b - a) * mean(f(x))
}

ns <- c(100, 1000, 10000, 100000)
mc_results <- sapply(ns, function(n) mc_integrate_1d(function(x) x^2, 0, 1, n))
data.frame(n = ns, result = mc_results, error = abs(mc_results - 1 / 3))

# 2D Monte Carlo: area of unit circle (π)
mc_circle <- function(n) {
    x <- runif(n, -1, 1)
    y <- runif(n, -1, 1)
    4 * mean(x^2 + y^2 <= 1) # box area = 4
}
mc_circle(1e6) # ≈ π

# High-dimensional MC: ∫ exp(-sum(x²)) over [-3,3]^5
mc_5d <- function(n) {
    samples <- matrix(runif(n * 5, -3, 3), ncol = 5)
    volume <- 6^5
    fvals <- apply(samples, 1, function(x) exp(-sum(x^2)))
    volume * mean(fvals)
}
mc_5d(1e5) # ≈ π^(5/2)

# ============================================================================
# 8. LINE INTEGRALS
# ============================================================================

# ∫_C f ds along parametric curve r(t) = (cos(t), sin(t)), t ∈ [0, 2π]
# f(x, y) = x² + y² = 1 on unit circle
# ds = |r'(t)| dt = 1 dt
# ∫ = 2π
t_vals <- seq(0, 2 * pi, length.out = 1000)
x_t <- cos(t_vals)
y_t <- sin(t_vals)
dx <- -sin(t_vals)
dy <- cos(t_vals)
ds <- sqrt(dx^2 + dy^2)
f_vals <- x_t^2 + y_t^2
trapz(t_vals, f_vals * ds) # ≈ 2π

# Work integral: ∫_C F · dr where F = (y, -x)
# Along circle: F · r' = (sin(t))(-sin(t)) + (-cos(t))(cos(t)) = -1
trapz(t_vals, rep(-1, length(t_vals))) # ≈ -2π

# ============================================================================
# 9. CUMULATIVE INTEGRATION (ODE approach)
# ============================================================================

if (!require(deSolve)) install.packages("deSolve")
library(deSolve)

# Compute F(x) = ∫₀^x sin(t) dt using ODE: dF/dx = sin(x), F(0) = 0
cumul_ode <- function(x, F, parms) list(sin(x))

x_span <- seq(0, 2 * pi, by = 0.01)
sol <- ode(y = 0, times = x_span, func = cumul_ode, parms = NULL)

# Compare with analytical: F(x) = 1 - cos(x)
max(abs(sol[, 2] - (1 - cos(x_span)))) # max error

# Cumulative trapezoidal (pracma)
y_vals <- sin(x_span)
F_cumtrap <- cumtrapz(x_span, y_vals)
max(abs(F_cumtrap - (1 - cos(x_span))))

# ============================================================================
# 10. ROMBERG INTEGRATION (pracma)
# ============================================================================

# High-accuracy via Richardson extrapolation
romberg(sin, 0, pi) # ≈ 2

# Compare methods on a challenging integral: ∫₀^1 sqrt(x)*log(x) dx = -4/9
f_hard <- function(x) ifelse(x == 0, 0, sqrt(x) * log(x))
exact <- -4 / 9

results <- data.frame(
    method = c("integrate", "romberg", "simpson", "gauss-32"),
    value = c(
        integrate(f_hard, 0, 1)$value,
        romberg(f_hard, 0, 1)$value,
        simpson(f_hard, 0, 1, n = 1000),
        sum(gaussLegendre(32, 0, 1)$w * f_hard(gaussLegendre(32, 0, 1)$x))
    )
)
results$error <- abs(results$value - exact)
results
