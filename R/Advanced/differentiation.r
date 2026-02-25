# Numerical & Symbolic Differentiation in R
# Packages: numDeriv, pracma, deSolve

if (!require(numDeriv)) install.packages("numDeriv")
if (!require(pracma)) install.packages("pracma")
library(numDeriv)
library(pracma)

# ============================================================================
# 1. FINITE DIFFERENCES (Manual)
# ============================================================================

f <- function(x) sin(x)
x0 <- pi / 4
h <- 1e-6

# Forward difference: f'(x) ≈ (f(x+h) - f(x)) / h
forward <- (f(x0 + h) - f(x0)) / h

# Backward difference: f'(x) ≈ (f(x) - f(x-h)) / h
backward <- (f(x0) - f(x0 - h)) / h

# Central difference: f'(x) ≈ (f(x+h) - f(x-h)) / (2h)
central <- (f(x0 + h) - f(x0 - h)) / (2 * h)

exact <- cos(x0)
data.frame(
    method = c("forward", "backward", "central", "exact"),
    value = c(forward, backward, central, exact),
    error = c(abs(forward - exact), abs(backward - exact), abs(central - exact), 0)
)

# ============================================================================
# 2. NUMERICAL FIRST DERIVATIVE (numDeriv)
# ============================================================================

# grad() for scalar-valued functions
f1 <- function(x) x^3 - 2 * x^2 + x - 5
grad(f1, x = 2) # f'(2) = 3(4) - 4(2) + 1 = 5

f2 <- function(x) exp(-x^2)
grad(f2, x = 1) # f'(1) = -2*exp(-1)

# Multiple points
sapply(seq(0, 2, by = 0.5), function(x) grad(f1, x))

# ============================================================================
# 3. HIGHER-ORDER DERIVATIVES
# ============================================================================

# Second derivative via numDeriv::hessian (1D case)
f3 <- function(x) x^4 - 3 * x^2 + 2 * x
hessian(f3, x = 1) # f''(1) = 12(1) - 6 = 6

# pracma::fderiv for nth derivative
fderiv(sin, pi / 4, n = 1) # cos(pi/4) ≈ 0.7071
fderiv(sin, pi / 4, n = 2) # -sin(pi/4) ≈ -0.7071
fderiv(sin, pi / 4, n = 3) # -cos(pi/4) ≈ -0.7071
fderiv(sin, pi / 4, n = 4) # sin(pi/4) ≈ 0.7071

# ============================================================================
# 4. GRADIENT OF MULTIVARIATE FUNCTIONS
# ============================================================================

# f(x, y) = x^2*y + y^3
f_multi <- function(x) x[1]^2 * x[2] + x[2]^3

# Gradient at (1, 2): (2xy, x^2 + 3y^2) = (4, 13)
grad(f_multi, c(1, 2))

# f(x, y, z) = x*y*z + x^2 + z^2
f_3d <- function(x) x[1] * x[2] * x[3] + x[1]^2 + x[3]^2

# Gradient at (1, 1, 1): (yz + 2x, xz, xy + 2z) = (3, 1, 3)
grad(f_3d, c(1, 1, 1))

# ============================================================================
# 5. JACOBIAN MATRIX
# ============================================================================

# Vector-valued function R^2 -> R^2
# f(x,y) = (x^2 + y, x*y^2)
f_vec <- function(x) {
    c(x[1]^2 + x[2], x[1] * x[2]^2)
}

# Jacobian at (1, 2): [[2x, 1], [y^2, 2xy]] = [[2, 1], [4, 4]]
jacobian(f_vec, c(1, 2))

# R^3 -> R^3
f_vec3 <- function(x) {
    c(
        x[1] * x[2] + x[3],
        x[1]^2 - x[3]^2,
        x[2] * x[3]
    )
}
jacobian(f_vec3, c(1, 1, 1))

# ============================================================================
# 6. HESSIAN MATRIX
# ============================================================================

# f(x, y) = x^3 + x*y^2 - 3*x*y
f_hess <- function(x) x[1]^3 + x[1] * x[2]^2 - 3 * x[1] * x[2]

# Hessian at (1, 1): [[6x, 2y-3], [2y-3, 2x]] = [[6, -1], [-1, 2]]
hessian(f_hess, c(1, 1))

# Classify critical point using eigenvalues of Hessian
H <- hessian(f_hess, c(1, 1))
eigen(H)$values # both positive → local min; both negative → local max; mixed → saddle

# ============================================================================
# 7. SYMBOLIC DIFFERENTIATION (Base R)
# ============================================================================

# D() differentiates expressions
expr <- expression(x^3 - 2 * x^2 + sin(x))
D(expr, "x") # 3 * x^2 - 2 * (2 * x) + cos(x)
D(D(expr, "x"), "x") # second derivative

# Evaluate symbolic derivative
f_sym <- deriv(~ x^3 - 2 * x^2 + sin(x), "x", func = TRUE)
f_sym(pi / 4) # returns value + gradient attribute

# Multivariate symbolic derivative
expr_multi <- expression(x^2 * y + y^3)
D(expr_multi, "x") # 2 * x * y
D(expr_multi, "y") # x^2 + 3 * y^2

# deriv() with multiple variables
f_sym_multi <- deriv(~ x^2 * y + y^3, c("x", "y"), func = TRUE)
f_sym_multi(1, 2) # value + gradient for both partials

# ============================================================================
# 8. DERIVATIVE OF DISCRETE DATA
# ============================================================================

# Numerical derivative from sampled data points
x_data <- seq(0, 2 * pi, length.out = 100)
y_data <- sin(x_data)

# Central differences on data
dy <- diff(y_data) / diff(x_data)
x_mid <- (x_data[-1] + x_data[-length(x_data)]) / 2

# Compare with analytical
max(abs(dy - cos(x_mid))) # max error

# pracma::gradient for evenly spaced data
dy_pracma <- gradient(y_data, x_data)
max(abs(dy_pracma - cos(x_data)))

# ============================================================================
# 9. APPLICATION: TAYLOR SERIES APPROXIMATION
# ============================================================================

# Approximate f(x) = exp(x) around x0 = 0 using derivatives
taylor_approx <- function(f, x0, x, n_terms) {
    result <- 0
    for (k in 0:n_terms) {
        dk <- ifelse(k == 0, f(x0), fderiv(f, x0, n = k))
        result <- result + dk * (x - x0)^k / factorial(k)
    }
    result
}

x_eval <- 1.0
orders <- 1:8
approx_vals <- sapply(orders, function(n) taylor_approx(exp, 0, x_eval, n))
data.frame(
    order = orders,
    approx = approx_vals,
    exact = exp(x_eval),
    error = abs(approx_vals - exp(x_eval))
)

# ============================================================================
# 10. APPLICATION: FINDING CRITICAL POINTS
# ============================================================================

# f(x) = x^4 - 4*x^3 + 6*x^2 - 4*x + 1 = (x-1)^4
f_crit <- function(x) x^4 - 4 * x^3 + 6 * x^2 - 4 * x + 1
f_crit_prime <- function(x) fderiv(f_crit, x, n = 1)

# Find roots of f'(x) = 0
critical_pts <- uniroot(f_crit_prime, c(-1, 3))$root
critical_pts # should be x = 1

# Second derivative test
fderiv(f_crit, critical_pts, n = 2) # f''(1) = 0, inconclusive
fderiv(f_crit, critical_pts, n = 4) # f''''(1) = 24, higher-order min

# ============================================================================
# 11. DIFFERENTIATION VIA deSolve (ODE-BASED)
# ============================================================================

if (!require(deSolve)) install.packages("deSolve")
library(deSolve)

# Compute derivative from ODE solution: dy/dt = -0.5*y → y'(t) = -0.5*y(t)
model <- function(t, y, parms) list(-0.5 * y)
times <- seq(0, 10, by = 0.01)
sol <- ode(y = 10, times = times, func = model, parms = NULL)

# Extract numerical derivative from ODE solution via central differences
y_vals <- sol[, 2]
t_vals <- sol[, 1]
dy_dt <- gradient(y_vals, t_vals)

# Compare with analytical: y'(t) = -5*exp(-0.5t)
analytical_deriv <- -5 * exp(-0.5 * t_vals)
max(abs(dy_dt - analytical_deriv)) # max error

# Sensitivity analysis: how does solution depend on parameter?
# dy/dt = -k*y, y(0)=10 → dy/dk at each t
# Analytical: ds/dt = -y - k*s, s(0)=0, where s = dy/dk
sensitivity_model <- function(t, state, parms) {
    y <- state[1]
    s <- state[2] # sensitivity ds/dk
    k <- parms[["k"]]
    list(c(
        -k * y, # dy/dt
        -y - k * s # ds/dt (sensitivity equation)
    ))
}

parms <- list(k = 0.5)
sol_sens <- ode(
    y = c(y = 10, s = 0), times = times,
    func = sensitivity_model, parms = parms
)

# Sensitivity at t=5: how much y(5) changes per unit change in k
sol_sens[sol_sens[, 1] == 5, 3]

# Analytical: s(t) = -t * y(t) = -t * 10 * exp(-kt)
analytical_sens <- -times * 10 * exp(-0.5 * times)
max(abs(sol_sens[, 3] - analytical_sens)) # max error

# Lotka-Volterra: sensitivity of prey population to alpha
lv_sensitivity <- function(t, state, parms) {
    x <- state[1]
    y <- state[2]
    sx <- state[3] # dx/dalpha
    sy <- state[4] # dy/dalpha
    with(as.list(parms), {
        dx <- alpha * x - beta * x * y
        dy <- delta * x * y - gamma * y
        # Sensitivity equations (chain rule)
        dsx <- x + alpha * sx - beta * (sx * y + x * sy)
        dsy <- delta * (sx * y + x * sy) - gamma * sy
        list(c(dx, dy, dsx, dsy))
    })
}

parms_lv <- c(alpha = 1.0, beta = 0.1, delta = 0.075, gamma = 1.5)
sol_lv <- ode(
    y = c(x = 10, y = 5, sx = 0, sy = 0),
    times = seq(0, 30, by = 0.1),
    func = lv_sensitivity, parms = parms_lv
)

# Sensitivity of prey (x) to alpha at t=30
tail(sol_lv[, c(1, 4)], 1)
