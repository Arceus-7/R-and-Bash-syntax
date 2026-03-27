# ============================================================================
# Non-Linear Equations Solvers
# ============================================================================

# Load required packages
if (!require(pracma)) install.packages("pracma", repos="http://cran.us.r-project.org")
if (!require(NLRoot)) install.packages("NLRoot", repos="http://cran.us.r-project.org")
if (!require(nleqslv)) install.packages("nleqslv", repos="http://cran.us.r-project.org")

library(pracma)
library(NLRoot)
library(nleqslv)

# ----------------------------------------------------------------------------
# 1. ROOT FINDING FOR SINGLE EQUATIONS
# ----------------------------------------------------------------------------

cat("\n========== ROOT FINDING (SINGLE EQUATION) ==========\n")

# Equation to solve: x^2 - 5*x + 2 = 0
f <- function(x) x^2 - 5 * x + 2
# Derivative for Newton-Raphson: 2x - 5
f_prime <- function(x) 2 * x - 5

# Method A: pracma::fzero (similar to MATLAB fzero)
cat("Using pracma::fzero (initial guess 1.7):\n")
res_fzero <- fzero(f, 1.7)
cat("Root:", res_fzero$x, "(Function value:", res_fzero$fval, ")\n\n")

# Method B: NLRoot::BFfzero (Bisection Method)
cat("Using NLRoot::BFfzero (Bisection method in interval [0, 1]):\n")
# BFfzero(f, a, b) where a and b bracket the root
res_bisection <- BFfzero(f, 0, 1)

# Method C: NLRoot::NIMfzero (Newton-Raphson Method)
cat("\nUsing NLRoot::NIMfzero (Newton-Raphson method with initial guess 0):\n")
# NIMfzero(f, f1, x0) where f1 is the derivative, x0 is initial guess
res_newton <- NIMfzero(f, f_prime, 0)

# Method D: NLRoot::SMfzero (Secant Method)
cat("\nUsing NLRoot::SMfzero (Secant method with interval [0, 1]):\n")
# SMfzero(f, x1, x2) where x1, x2 are initial guesses
res_secant <- SMfzero(f, 0, 1)

# ----------------------------------------------------------------------------
# 2. SYSTEM OF NON-LINEAR EQUATIONS (nleqslv)
# ----------------------------------------------------------------------------

cat("\n========== SOLVING NON-LINEAR SYSTEMS ==========\n")

# Example 1: System of two equations
# y_1: x[1]*x[1] + x[2] - 3 = 0
# y_2: x[1] + x[2]*x[2] - 5 = 0

eq_sys_1 <- function(x) {
    y <- numeric(2)
    y[1] <- x[1] * x[1] + x[2] - 3
    y[2] <- x[1] + x[2] * x[2] - 5
    return(y)
}
cat("\nSystem 1: x^2 + y = 3, x + y^2 = 5\n")
cat("Initial guess (1, 1):\n")
sol_sys_1 <- nleqslv(c(1, 1), eq_sys_1, method = "Newton")
cat("Found roots: x =", sol_sys_1$x[1], ", y =", sol_sys_1$x[2], "\n")
cat("Termination code:", sol_sys_1$termcd, "-", sol_sys_1$message, "\n")


# Example 2: Non-linear equations with mixed terms
# y_1: x*y + x + y + 2.3 = 0
# y_2: x - y + 2*x*y + 1.6 = 0

eq_sys_2 <- function(v) {
    y <- numeric(2)
    x <- v[1]
    y_val <- v[2]
    
    y[1] <- x * y_val + x + y_val + 2.3
    y[2] <- x - y_val + 2 * x * y_val + 1.6
    return(y)
}

cat("\nSystem 2: xy + x + y + 2.3 = 0, x - y + 2xy + 1.6 = 0\n")
sol_sys_2 <- nleqslv(c(1, 1), eq_sys_2, method = "Newton")
cat("Found roots: x =", sol_sys_2$x[1], ", y =", sol_sys_2$x[2], "\n")


# Example 3: System of three non-linear equations
# x + y + z = 6
# x^2 + y^2 + z^2 = 14
# x^3 + y^3 + z^3 = 36
# (Known integer roots for this system are permutations of 1, 2, 3)

eq_sys_3 <- function(x) {
    y <- numeric(3)
    y[1] <- x[1] + x[2] + x[3] - 6
    y[2] <- x[1]^2 + x[2]^2 + x[3]^2 - 14
    y[3] <- x[1]^3 + x[2]^3 + x[3]^3 - 36
    return(y)
}

cat("\nSystem 3 (3 equations, 3 variables)\n")
sol_sys_3 <- nleqslv(c(1.1, 2.1, 2.9), eq_sys_3, method = "Newton")
cat("Found roots: x =", sol_sys_3$x[1], "y =", sol_sys_3$x[2], "z =", sol_sys_3$x[3], "\n")
