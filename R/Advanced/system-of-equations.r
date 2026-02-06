# ============================================================================
# R Equation Solving: Systems of Linear Equations
# ============================================================================
# Comprehensive guide to solving systems of equations in R

# ----------------------------------------------------------------------------
# 1. SOLVING LINEAR SYSTEMS USING solve()
# ----------------------------------------------------------------------------

cat("\n========== METHOD 1: solve() Function ==========\n")

# System: 2x + 3y = 8
#         4x - y = 2
# Matrix form: Ax = b

A <- matrix(c(2, 4, 3, -1), nrow = 2, ncol = 2, byrow = FALSE)
b <- c(8, 2)

cat("Coefficient matrix A:\n")
print(A)
cat("\nConstant vector b:\n")
print(b)

# Solve the system
solution <- solve(A, b)
cat("\nSolution:\n")
cat("x =", solution[1], "\n")
cat("y =", solution[2], "\n")

# Verify solution
cat("\nVerification: A %*% solution =\n")
print(A %*% solution)
cat("Expected b =\n")
print(b)

# ----------------------------------------------------------------------------
# 2. SOLVING 3x3 SYSTEMS
# ----------------------------------------------------------------------------

cat("\n========== METHOD 2: 3x3 System ==========\n")

# System: x + 2y + 3z = 14
#         2x - y + z = 5
#         3x + y - 2z = -1

A3 <- matrix(c(
    1, 2, 3,
    2, -1, 1,
    3, 1, -2
), nrow = 3, ncol = 3, byrow = TRUE)

b3 <- c(14, 5, -1)

cat("3x3 System:\n")
print(A3)
cat("\nb vector:\n")
print(b3)

sol3 <- solve(A3, b3)
cat("\nSolution:\n")
cat("x =", sol3[1], "\n")
cat("y =", sol3[2], "\n")
cat("z =", sol3[3], "\n")

# Verify
cat("\nVerification (should equal b):\n")
print(A3 %*% sol3)

# ----------------------------------------------------------------------------
# 3. MATRIX INVERSE METHOD
# ----------------------------------------------------------------------------

cat("\n========== METHOD 3: Matrix Inverse ==========\n")

# If Ax = b, then x = A^(-1) * b

A_inv <- solve(A)
cat("Inverse of A:\n")
print(A_inv)

solution_inv <- A_inv %*% b
cat("\nSolution using inverse:\n")
print(solution_inv)

# Check that A * A_inv = I
cat("\nIdentity check (A * A_inv):\n")
print(A %*% A_inv)

# ----------------------------------------------------------------------------
# 4. CHECKING SYSTEM PROPERTIES
# ----------------------------------------------------------------------------

cat("\n========== SYSTEM PROPERTIES ==========\n")

# Determinant
det_A <- det(A)
cat("Determinant of A:", det_A, "\n")

if (abs(det_A) < 1e-10) {
    cat("Matrix is SINGULAR (no unique solution)\n")
} else {
    cat("Matrix is NON-SINGULAR (unique solution exists)\n")
}

# Rank
rank_A <- qr(A)$rank
cat("Rank of A:", rank_A, "\n")

# Condition number
cond_A <- kappa(A)
cat("Condition number:", cond_A, "\n")
if (cond_A > 1000) {
    cat("WARNING: Matrix is ILL-CONDITIONED\n")
}

# ----------------------------------------------------------------------------
# 5. OVERDETERMINED SYSTEMS (More equations than unknowns)
# ----------------------------------------------------------------------------

cat("\n========== OVERDETERMINED SYSTEM (Least Squares) ==========\n")

# 4 equations, 2 unknowns - find best fit
A_over <- matrix(c(
    1, 1,
    2, 1,
    3, 2,
    4, 3
), nrow = 4, ncol = 2, byrow = TRUE)

b_over <- c(2, 3, 5, 7)

cat("Overdetermined system (4 equations, 2 unknowns):\n")
print(A_over)
cat("\nb =\n")
print(b_over)

# Least squares solution: (A^T A)^(-1) A^T b
AtA <- t(A_over) %*% A_over
Atb <- t(A_over) %*% b_over
sol_ls <- solve(AtA, Atb)

cat("\nLeast squares solution:\n")
print(sol_ls)

# Residuals
residuals <- b_over - A_over %*% sol_ls
cat("\nResiduals:\n")
print(residuals)
cat("Sum of squared residuals:", sum(residuals^2), "\n")

# Using lm() for least squares
model <- lm(b_over ~ A_over - 1) # -1 removes intercept
cat("\nUsing lm() function:\n")
print(coef(model))

# ----------------------------------------------------------------------------
# 6. UNDERDETERMINED SYSTEMS (More unknowns than equations)
# ----------------------------------------------------------------------------

cat("\n========== UNDERDETERMINED SYSTEM ==========\n")

# 2 equations, 3 unknowns - infinite solutions
A_under <- matrix(c(
    1, 2, 3,
    2, 4, 7
), nrow = 2, ncol = 3, byrow = TRUE)

b_under <- c(10, 21)

cat("Underdetermined system (2 equations, 3 unknowns):\n")
print(A_under)
cat("\nb =\n")
print(b_under)

# Find minimum norm solution using Moore-Penrose pseudoinverse
library(MASS) # For ginv()
A_pinv <- ginv(A_under)
sol_under <- A_pinv %*% b_under

cat("\nMinimum norm solution (using pseudoinverse):\n")
print(sol_under)

# Verify
cat("\nVerification:\n")
print(A_under %*% sol_under)

# ----------------------------------------------------------------------------
# 7. HOMOGENEOUS SYSTEMS (b = 0)
# ----------------------------------------------------------------------------

cat("\n========== HOMOGENEOUS SYSTEM ==========\n")

# Ax = 0
A_homo <- matrix(c(
    1, 2, 3,
    2, 4, 6,
    1, 1, 2
), nrow = 3, ncol = 3, byrow = TRUE)

cat("Homogeneous system Ax = 0:\n")
print(A_homo)

cat("Determinant:", det(A_homo), "\n")

# Find null space
null_space <- eigen(A_homo)
cat("\nEigenvalues:\n")
print(null_space$values)

# Non-trivial solution exists if determinant is 0
if (abs(det(A_homo)) < 1e-10) {
    cat("Non-trivial solutions exist (det = 0)\n")
} else {
    cat("Only trivial solution x = 0 exists\n")
}

# ----------------------------------------------------------------------------
# 8. ITERATIVE METHODS - Gauss-Seidel
# ----------------------------------------------------------------------------

cat("\n========== GAUSS-SEIDEL ITERATIVE METHOD ==========\n")

gauss_seidel <- function(A, b, x0 = NULL, tol = 1e-6, max_iter = 100) {
    n <- nrow(A)
    if (is.null(x0)) x0 <- rep(0, n)

    x <- x0
    for (iter in seq_len(max_iter)) {
        x_old <- x
        for (i in seq_len(n)) {
            sum_val <- sum(A[i, ] * x) - A[i, i] * x[i]
            x[i] <- (b[i] - sum_val) / A[i, i]
        }

        # Check convergence
        if (max(abs(x - x_old)) < tol) {
            cat("Converged in", iter, "iterations\n")
            return(x)
        }
    }
    cat("WARNING: Did not converge\n")
    return(x)
}

# Example: Diagonally dominant matrix for convergence
A_gs <- matrix(c(
    10, 1, 2,
    2, 10, 1,
    1, 2, 10
), nrow = 3, ncol = 3, byrow = TRUE)

b_gs <- c(13, 13, 13)

cat("System for Gauss-Seidel:\n")
print(A_gs)
cat("\nb =\n")
print(b_gs)

sol_gs <- gauss_seidel(A_gs, b_gs)
cat("\nGauss-Seidel solution:\n")
print(sol_gs)

cat("\nDirect solution (for comparison):\n")
print(solve(A_gs, b_gs))

# ----------------------------------------------------------------------------
# 9. TRIDIAGONAL SYSTEMS (Efficient solver)
# ----------------------------------------------------------------------------

cat("\n========== TRIDIAGONAL SYSTEM ==========\n")

# Thomas algorithm for tridiagonal matrices
thomas_algorithm <- function(a, b, c, d) {
    n <- length(d)
    c_star <- rep(0, n)
    d_star <- rep(0, n)
    x <- rep(0, n)

    c_star[1] <- c[1] / b[1]
    d_star[1] <- d[1] / b[1]

    for (i in 2:n) {
        denom <- b[i] - a[i] * c_star[i - 1]
        if (i < n) c_star[i] <- c[i] / denom
        d_star[i] <- (d[i] - a[i] * d_star[i - 1]) / denom
    }

    x[n] <- d_star[n]
    for (i in (n - 1):1) {
        x[i] <- d_star[i] - c_star[i] * x[i + 1]
    }

    return(x)
}

# Example tridiagonal system
n <- 5
a_tri <- rep(1, n) # Lower diagonal
b_tri <- rep(4, n) # Main diagonal
c_tri <- rep(1, n) # Upper diagonal
d_tri <- seq_len(n) * 2

cat("Tridiagonal system (n =", n, "):\n")
cat("Lower diagonal (a):", a_tri, "\n")
cat("Main diagonal (b):", b_tri, "\n")
cat("Upper diagonal (c):", c_tri, "\n")
cat("Right side (d):", d_tri, "\n")

sol_tri <- thomas_algorithm(a_tri, b_tri, c_tri, d_tri)
cat("\nSolution:\n")
print(sol_tri)

# ----------------------------------------------------------------------------
# 10. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

cat("\n========== PRACTICAL EXAMPLE: Circuit Analysis ==========\n")

# Kirchhoff's laws for circuit with 3 loops
# Loop 1: 10i1 - 5i2 = 12 (Voltage source)
# Loop 2: -5i1 + 15i2 - 8i3 = 0
# Loop 3: -8i2 + 18i3 = 0

A_circuit <- matrix(c(
    10, -5, 0,
    -5, 15, -8,
    0, -8, 18
), nrow = 3, ncol = 3, byrow = TRUE)

V_circuit <- c(12, 0, 0)

currents <- solve(A_circuit, V_circuit)
cat("\nCircuit currents (Amperes):\n")
cat("i1 =", currents[1], "A\n")
cat("i2 =", currents[2], "A\n")
cat("i3 =", currents[3], "A\n")

cat("\n========== PRACTICAL EXAMPLE: Chemical Equations ==========\n")

# Balancing: C2H6 + O2 -> CO2 + H2O
# Variables: a*C2H6 + b*O2 -> c*CO2 + d*H2O
# C: 2a = c
# H: 6a = 2d
# O: 2b = 2c + d
# Set a = 1

A_chem <- matrix(c(
    2, 0, -1, 0,
    6, 0, 0, -2,
    0, 2, -2, -1,
    1, 0, 0, 0
), nrow = 4, ncol = 4, byrow = TRUE)

b_chem <- c(0, 0, 0, 1)

coeffs <- solve(A_chem, b_chem)
# Scale to integers
coeffs_int <- coeffs / min(coeffs[coeffs > 0])
coeffs_int <- round(coeffs_int * 2) # Double all

cat("\nBalanced equation coefficients:\n")
cat(
    coeffs_int[1], "C2H6 +", coeffs_int[2], "O2 ->",
    coeffs_int[3], "CO2 +", coeffs_int[4], "H2O\n"
)

cat("\n========== ALL EXAMPLES COMPLETED ==========\n")
