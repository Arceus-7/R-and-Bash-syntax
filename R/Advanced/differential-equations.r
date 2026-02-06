# ============================================================================
# R Differential Equations Solving
# ============================================================================
# Comprehensive guide to solving ODEs and PDEs in R using deSolve package

# Load required package
if (!require(deSolve)) install.packages("deSolve")
library(deSolve)

# ----------------------------------------------------------------------------
# 1. FIRST-ORDER ODE: dy/dt = f(t, y)
# ----------------------------------------------------------------------------

cat("\n========== SIMPLE FIRST-ORDER ODE ==========\n")

# Example: dy/dt = -0.5*y, y(0) = 10 (exponential decay)

simple_ode <- function(t, y, parms) {
    list(-0.5 * y)
}

times <- seq(0, 10, by = 0.1)
y0 <- 10

cat("Solving: dy/dt = -0.5*y with y(0) = 10\n")
solution <- ode(y = y0, times = times, func = simple_ode, parms = NULL)

cat("\nFirst few values:\n")
print(head(solution))

cat("\nAnalytical solution at t=5:", 10 * exp(-0.5 * 5), "\n")
cat("Numerical solution at t=5:", solution[solution[, 1] == 5, 2], "\n")

# ----------------------------------------------------------------------------
# 2. FIRST-ORDER ODE WITH PARAMETERS
# ----------------------------------------------------------------------------

cat("\n========== ODE WITH PARAMETERS ==========\n")

# dy/dt = r*y*(1 - y/K) - Logistic growth

logistic <- function(t, y, parms) {
    with(as.list(parms), {
        dydt <- r * y * (1 - y / K)
        list(dydt)
    })
}

parms <- c(r = 0.5, K = 100)
y0 <- 5
times <- seq(0, 50, by = 0.5)

cat("Logistic equation: dy/dt = r*y*(1 - y/K)\n")
cat("Parameters: r =", parms["r"], ", K =", parms["K"], "\n")
cat("Initial condition: y(0) =", y0, "\n")

sol_logistic <- ode(y = y0, times = times, func = logistic, parms = parms)

cat("\nPopulation at t = 50:", tail(sol_logistic, 1)[2], "\n")
cat("Carrying capacity K =", parms["K"], "\n")

# ----------------------------------------------------------------------------
# 3. SYSTEM OF ODEs (Lotka-Volterra Predator-Prey)
# ----------------------------------------------------------------------------

cat("\n========== LOTKA-VOLTERRA PREDATOR-PREY ==========\n")

# dx/dt = alpha*x - beta*x*y (Prey)
# dy/dt = delta*x*y - gamma*y (Predator)

lotka_volterra <- function(t, state, parms) {
    with(as.list(c(state, parms)), {
        dx <- alpha * x - beta * x * y
        dy <- delta * x * y - gamma * y
        list(c(dx, dy))
    })
}

parms_lv <- c(alpha = 1.0, beta = 0.1, delta = 0.075, gamma = 1.5)
state <- c(x = 10, y = 5) # Initial populations
times <- seq(0, 50, by = 0.1)

cat("Predator-Prey model\n")
cat(
    "Parameters: alpha =", parms_lv["alpha"], ", beta =", parms_lv["beta"],
    ", delta =", parms_lv["delta"], ", gamma =", parms_lv["gamma"], "\n"
)
cat("Initial: Prey =", state["x"], ", Predator =", state["y"], "\n")

sol_lv <- ode(y = state, times = times, func = lotka_volterra, parms = parms_lv)

cat("\nFinal populations at t = 50:\n")
cat("Prey:", tail(sol_lv, 1)[2], "\n")
cat("Predator:", tail(sol_lv, 1)[3], "\n")

# Summary statistics
cat("\nPrey - Min:", min(sol_lv[, 2]), "Max:", max(sol_lv[, 2]), "\n")
cat("Predator - Min:", min(sol_lv[, 3]), "Max:", max(sol_lv[, 3]), "\n")

# ----------------------------------------------------------------------------
# 4. SECOND-ORDER ODE (Convert to system of first-order)
# ----------------------------------------------------------------------------

cat("\n========== SECOND-ORDER ODE: HARMONIC OSCILLATOR ==========\n")

# d2x/dt2 + 2*zeta*omega*dx/dt + omega^2*x = 0
# Convert: Let y1 = x, y2 = dx/dt
# dy1/dt = y2
# dy2/dt = -2*zeta*omega*y2 - omega^2*y1

harmonic <- function(t, state, parms) {
    with(as.list(c(state, parms)), {
        dy1 <- y2
        dy2 <- -2 * zeta * omega * y2 - omega^2 * y1
        list(c(dy1, dy2))
    })
}

parms_harm <- c(omega = 2, zeta = 0.1) # omega = frequency, zeta = damping
state_harm <- c(y1 = 1, y2 = 0) # x(0) = 1, dx/dt(0) = 0
times <- seq(0, 20, by = 0.05)

cat("Damped harmonic oscillator\n")
cat("omega =", parms_harm["omega"], "(natural frequency)\n")
cat("zeta =", parms_harm["zeta"], "(damping ratio)\n")
cat("Initial: x(0) =", state_harm["y1"], ", v(0) =", state_harm["y2"], "\n")

sol_harm <- ode(y = state_harm, times = times, func = harmonic, parms = parms_harm)

cat("\nPosition at t = 10:", sol_harm[sol_harm[, 1] == 10, 2], "\n")
cat("Velocity at t = 10:", sol_harm[sol_harm[, 1] == 10, 3], "\n")

# ----------------------------------------------------------------------------
# 5. SIR EPIDEMIC MODEL
# ----------------------------------------------------------------------------

cat("\n========== SIR EPIDEMIC MODEL ==========\n")

# dS/dt = -beta*S*I/N
# dI/dt = beta*S*I/N - gamma*I
# dR/dt = gamma*I

sir_model <- function(t, state, parms) {
    with(as.list(c(state, parms)), {
        N <- S + I + R
        dS <- -beta * S * I / N
        dI <- beta * S * I / N - gamma * I
        dR <- gamma * I
        list(c(dS, dI, dR))
    })
}

parms_sir <- c(beta = 0.5, gamma = 0.1) # infection rate, recovery rate
state_sir <- c(S = 999, I = 1, R = 0) # Initial population
times <- seq(0, 200, by = 1)

cat("SIR Epidemic Model\n")
cat("beta (infection rate) =", parms_sir["beta"], "\n")
cat("gamma (recovery rate) =", parms_sir["gamma"], "\n")
cat("R0 (basic reproduction number) =", parms_sir["beta"] / parms_sir["gamma"], "\n")
cat("Initial: S =", state_sir["S"], ", I =", state_sir["I"], ", R =", state_sir["R"], "\n")

sol_sir <- ode(y = state_sir, times = times, func = sir_model, parms = parms_sir)

# Find peak infection
peak_idx <- which.max(sol_sir[, 3])
cat("\nPeak infection:\n")
cat("Time:", sol_sir[peak_idx, 1], "days\n")
cat("Infected:", sol_sir[peak_idx, 3], "individuals\n")

cat("\nFinal state (t = 200):\n")
cat("Susceptible:", tail(sol_sir, 1)[2], "\n")
cat("Infected:", tail(sol_sir, 1)[3], "\n")
cat("Recovered:", tail(sol_sir, 1)[4], "\n")

# ----------------------------------------------------------------------------
# 6. VAN DER POL OSCILLATOR (Stiff ODE)
# ----------------------------------------------------------------------------

cat("\n========== VAN DER POL OSCILLATOR ==========\n")

van_der_pol <- function(t, state, parms) {
    with(as.list(c(state, parms)), {
        dx <- y
        dy <- mu * (1 - x^2) * y - x
        list(c(dx, dy))
    })
}

parms_vdp <- c(mu = 10) # Stiffness parameter
state_vdp <- c(x = 2, y = 0)
times <- seq(0, 100, by = 0.1)

cat("Van der Pol oscillator (stiff ODE)\n")
cat("mu =", parms_vdp["mu"], "\n")

# Use stiff solver
sol_vdp <- ode(
    y = state_vdp, times = times, func = van_der_pol,
    parms = parms_vdp, method = "lsoda"
)

cat("\nSolution computed using LSODA (automatic stiffness detection)\n")
cat("Final state: x =", tail(sol_vdp, 1)[2], ", y =", tail(sol_vdp, 1)[3], "\n")

# ----------------------------------------------------------------------------
# 7. LORENZ SYSTEM (Chaotic dynamics)
# ----------------------------------------------------------------------------

cat("\n========== LORENZ SYSTEM (CHAOS) ==========\n")

lorenz <- function(t, state, parms) {
    with(as.list(c(state, parms)), {
        dx <- sigma * (y - x)
        dy <- x * (rho - z) - y
        dz <- x * y - beta * z
        list(c(dx, dy, dz))
    })
}

parms_lorenz <- c(sigma = 10, rho = 28, beta = 8 / 3)
state_lorenz <- c(x = 1, y = 1, z = 1)
times <- seq(0, 50, by = 0.01)

cat("Lorenz attractor (chaotic system)\n")
cat(
    "Parameters: sigma =", parms_lorenz["sigma"], ", rho =", parms_lorenz["rho"],
    ", beta =", parms_lorenz["beta"], "\n"
)

sol_lorenz <- ode(y = state_lorenz, times = times, func = lorenz, parms = parms_lorenz)

cat("\nFinal state at t = 50:\n")
cat("x =", tail(sol_lorenz, 1)[2], "\n")
cat("y =", tail(sol_lorenz, 1)[3], "\n")
cat("z =", tail(sol_lorenz, 1)[4], "\n")

# ----------------------------------------------------------------------------
# 8. DELAY DIFFERENTIAL EQUATIONS (DDE)
# ----------------------------------------------------------------------------

cat("\n========== DELAY DIFFERENTIAL EQUATION ==========\n")

# Example: dy/dt = -y(t-tau)
# Note: deSolve has limited DDE support, use dede() for simple cases

dde_func <- function(t, y, parms) {
    if (t < parms["tau"]) {
        lag_y <- parms["y0"]
    } else {
        lag_y <- lagvalue(t - parms["tau"])
    }
    list(-lag_y)
}

parms_dde <- c(tau = 1, y0 = 1)
y0_dde <- 1
times <- seq(0, 20, by = 0.1)

cat("Delay Differential Equation: dy/dt = -y(t-tau)\n")
cat("Time delay tau =", parms_dde["tau"], "\n")

sol_dde <- dede(y = y0_dde, times = times, func = dde_func, parms = parms_dde)

cat("\nSolution at t = 10:", sol_dde[sol_dde[, 1] == 10, 2], "\n")

# ----------------------------------------------------------------------------
# 9. BOUNDARY VALUE PROBLEMS (BVP)
# ----------------------------------------------------------------------------

cat("\n========== BOUNDARY VALUE PROBLEM ==========\n")

# Use bvpSolve package for BVPs
if (!require(bvpSolve)) install.packages("bvpSolve")
library(bvpSolve)

# Example: d2y/dx2 = -y, y(0) = 0, y(pi) = 0
# Rewrite as: dy1/dx = y2, dy2/dx = -y1
bvp_func <- function(x, y, parms) {
    list(c(y[2], -y[1]))
}

x <- seq(0, pi, length.out = 100)
y_init <- matrix(nrow = length(x), ncol = 2, 0)
y_init[, 1] <- sin(x) # Initial guess

cat("BVP: d2y/dx2 = -y, y(0) = 0, y(pi) = 0\n")

sol_bvp <- bvpshoot(
    yini = c(0, NA), yend = c(0, NA),
    x = x, func = bvp_func, guess = 1
)

cat("\nSolution computed using shooting method\n")
cat("y(pi/2) =", sol_bvp[length(x) / 2, 2], "(should be ~1)\n")

# ----------------------------------------------------------------------------
# 10. PARTIAL DIFFERENTIAL EQUATIONS (Heat Equation)
# ----------------------------------------------------------------------------

cat("\n========== HEAT EQUATION (1D PDE) ==========\n")

# du/dt = alpha * d2u/dx2
# Use method of lines (MOL)

heat_eq <- function(t, u, parms) {
    with(as.list(parms), {
        n <- length(u)
        du <- numeric(n)

        # Boundary conditions: u[1] = u[n] = 0
        du[1] <- 0
        du[n] <- 0

        # Interior points: central difference for d2u/dx2
        for (i in 2:(n - 1)) {
            du[i] <- alpha * (u[i + 1] - 2 * u[i] + u[i - 1]) / dx^2
        }

        list(du)
    })
}

nx <- 50 # Number of spatial points
L <- 1 # Length of domain
dx <- L / (nx - 1)

# Initial condition: u(x, 0) = sin(pi*x)
x_grid <- seq(0, L, length.out = nx)
u0 <- sin(pi * x_grid)
u0[1] <- 0
u0[nx] <- 0

parms_heat <- list(alpha = 0.01, dx = dx)
times <- seq(0, 1, by = 0.01)

cat("1D Heat Equation: du/dt = alpha * d2u/dx2\n")
cat("Domain: [0, 1], nx =", nx, "points\n")
cat("Thermal diffusivity alpha =", parms_heat$alpha, "\n")

sol_heat <- ode(y = u0, times = times, func = heat_eq, parms = parms_heat)

cat("\nSolution computed using method of lines\n")
cat("Temperature at x = 0.5, t = 1:", sol_heat[nrow(sol_heat), nx / 2 + 1], "\n")
cat("Analytical:", exp(-pi^2 * parms_heat$alpha * 1) * sin(pi * 0.5), "\n")

# ----------------------------------------------------------------------------
# 11. NUMERICAL METHODS COMPARISON
# ----------------------------------------------------------------------------

cat("\n========== COMPARING ODE SOLVERS ==========\n")

test_ode <- function(t, y, parms) {
    list(-y)
}

y0 <- 1
times <- seq(0, 10, by = 0.1)

# Different methods
methods <- c("euler", "rk4", "lsoda", "adams")
results <- list()

for (method in methods) {
    sol <- ode(y = y0, times = times, func = test_ode, parms = NULL, method = method)
    results[[method]] <- sol[nrow(sol), 2]
}

cat("dy/dt = -y, y(0) = 1\n")
cat("Analytical solution at t = 10:", exp(-10), "\n\n")

cat("Numerical solutions:\n")
for (method in methods) {
    error <- abs(results[[method]] - exp(-10))
    cat(sprintf("%-10s: %.8f  (error: %.2e)\n", method, results[[method]], error))
}

# ----------------------------------------------------------------------------
# 12. PRACTICAL EXAMPLE: RC Circuit
# ----------------------------------------------------------------------------

cat("\n========== RC CIRCUIT CHARGING ==========\n")

# V = V0*(1 - exp(-t/(R*C)))
# dV/dt = (Vs - V)/(R*C)

rc_circuit <- function(t, V, parms) {
    with(as.list(parms), {
        dV <- (Vs - V) / (R * C)
        list(dV)
    })
}

parms_rc <- c(R = 1000, C = 0.001, Vs = 5) # Ohms, Farads, Volts
V0 <- 0
times <- seq(0, 10, by = 0.1)

tau <- parms_rc["R"] * parms_rc["C"]

cat("RC Circuit charging\n")
cat("R =", parms_rc["R"], "Ohm, C =", parms_rc["C"], "F, Vs =", parms_rc["Vs"], "V\n")
cat("Time constant tau = R*C =", tau, "seconds\n")

sol_rc <- ode(y = V0, times = times, func = rc_circuit, parms = parms_rc)

cat("\nVoltage at t = tau:", sol_rc[sol_rc[, 1] == tau, 2], "V\n")
cat("Expected (63.2% of Vs):", 0.632 * parms_rc["Vs"], "V\n")

cat("\nVoltage at t = 5*tau:", sol_rc[nrow(sol_rc), 2], "V\n")
cat("Expected (~99% of Vs):", 0.99 * parms_rc["Vs"], "V\n")

cat("\n========== ALL DIFFERENTIAL EQUATIONS EXAMPLES COMPLETED ==========\n")
