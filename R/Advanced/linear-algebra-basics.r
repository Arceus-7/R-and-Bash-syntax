# ============================================================================
# R Linear Algebra Basics
# ============================================================================
# Vector spaces, subspaces, span, orthogonality, Gram-Schmidt

cat("\n========== VECTOR OPERATIONS ==========\n")

# Vector addition and scalar multiplication
v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)

cat("Vector v1:", v1, "\n")
cat("Vector v2:", v2, "\n")
cat("v1 + v2:", v1 + v2, "\n")
cat("3 * v1:", 3 * v1, "\n")

# Dot product
dot_product <- sum(v1 * v2)
cat("v1 · v2:", dot_product, "\n")

# Vector norm (length)
norm_v1 <- sqrt(sum(v1^2))
cat("||v1||:", norm_v1, "\n")

# ----------------------------------------------------------------------------
# SUBSPACE CHECKING
# ----------------------------------------------------------------------------

cat("\n========== SUBSPACE VERIFICATION ==========\n")

# Function to check if set of vectors forms a subspace
# A subspace must be closed under addition and scalar multiplication
check_subspace <- function(vectors) {
    # Check if zero vector is included
    has_zero <- any(apply(vectors, 2, function(v) all(v == 0)))

    # For demonstration, check closure under addition (first two vectors)
    if (ncol(vectors) >= 2) {
        v1 <- vectors[, 1]
        v2 <- vectors[, 2]
        sum_vec <- v1 + v2

        # Check if sum is in the span
        # This is a simplified check
        cat("Testing closure under addition\n")
        cat("v1 + v2 =", sum_vec, "\n")
    }

    return(TRUE)
}

# Example: Column space of a matrix forms a subspace
A <- matrix(c(
    1, 2, 3,
    2, 4, 6
), nrow = 3, ncol = 2, byrow = FALSE)
cat("Matrix A:\n")
print(A)

# ----------------------------------------------------------------------------
# SPAN AND LINEAR COMBINATIONS
# ----------------------------------------------------------------------------

cat("\n========== SPAN AND LINEAR COMBINATIONS ==========\n")

# Check if vector b is in span of columns of A
A <- matrix(c(
    1, 2, 3,
    2, 1, 4
), nrow = 3, ncol = 2, byrow = FALSE)
b <- c(5, 5, 11)

cat("Can we express b as a linear combination of A's columns?\n")
cat("A:\n")
print(A)
cat("b:", b, "\n")

# Solve Ax = b
result <- tryCatch(
    {
        x <- solve(t(A) %*% A, t(A) %*% b)
        verification <- A %*% x
        cat("Solution x:", x, "\n")
        cat("A * x:", as.vector(verification), "\n")
        cat("Is b in span(A)?", all(abs(verification - b) < 1e-10), "\n")
    },
    error = function(e) {
        cat("b is NOT in the span of A's columns\n")
    }
)

# Linear combination example
cat("\nLinear combination: 2*v1 + 3*v2\n")
v1 <- c(1, 0, 0)
v2 <- c(0, 1, 0)
lin_comb <- 2 * v1 + 3 * v2
cat("Result:", lin_comb, "\n")

# ----------------------------------------------------------------------------
# ORTHOGONALITY
# ----------------------------------------------------------------------------

cat("\n========== ORTHOGONALITY ==========\n")

# Two vectors are orthogonal if their dot product is 0
v1 <- c(1, 0, 0)
v2 <- c(0, 1, 0)
v3 <- c(1, 1, 0)

cat("v1:", v1, "\n")
cat("v2:", v2, "\n")
cat("v1 · v2:", sum(v1 * v2), "\n")
cat("Are v1 and v2 orthogonal?", sum(v1 * v2) == 0, "\n")

cat("\nv3:", v3, "\n")
cat("v1 · v3:", sum(v1 * v3), "\n")
cat("Are v1 and v3 orthogonal?", sum(v1 * v3) == 0, "\n")

# ----------------------------------------------------------------------------
# PROJECTION
# ----------------------------------------------------------------------------

cat("\n========== VECTOR PROJECTION ==========\n")

# Project vector b onto vector a: proj_a(b) = (b·a / a·a) * a
a <- c(1, 0, 0)
b <- c(1, 2, 3)

proj_b_onto_a <- (sum(b * a) / sum(a * a)) * a
cat("Project b onto a\n")
cat("a:", a, "\n")
cat("b:", b, "\n")
cat("proj_a(b):", proj_b_onto_a, "\n")

# Perpendicular component
perp <- b - proj_b_onto_a
cat("Perpendicular component:", perp, "\n")
cat("Verify orthogonality (should be 0):", sum(proj_b_onto_a * perp), "\n")

# ----------------------------------------------------------------------------
# GRAM-SCHMIDT ORTHOGONALIZATION
# ----------------------------------------------------------------------------

cat("\n========== GRAM-SCHMIDT ORTHOGONALIZATION ==========\n")

# Convert a basis to an orthonormal basis
gram_schmidt <- function(V) {
    n <- ncol(V)
    m <- nrow(V)
    U <- matrix(0, nrow = m, ncol = n)

    for (i in 1:n) {
        # Start with current vector
        u <- V[, i]

        # Subtract projections onto previous orthonormal vectors
        if (i > 1) {
            for (j in 1:(i - 1)) {
                proj <- (sum(V[, i] * U[, j]) / sum(U[, j] * U[, j])) * U[, j]
                u <- u - proj
            }
        }

        # Normalize
        U[, i] <- u / sqrt(sum(u^2))
    }

    return(U)
}

# Example: Orthogonalize a set of vectors
V <- matrix(c(
    1, 1, 0,
    1, 0, 1,
    0, 1, 1
), nrow = 3, ncol = 3, byrow = FALSE)

cat("Original vectors V:\n")
print(V)

U <- gram_schmidt(V)
cat("\nOrthonormal basis U:\n")
print(U)

# Verify orthonormality
cat("\nVerification:\n")
cat("U'U (should be identity matrix):\n")
print(round(t(U) %*% U, 10))

# ----------------------------------------------------------------------------
# DISTANCE BETWEEN VECTORS
# ----------------------------------------------------------------------------

cat("\n========== DISTANCE BETWEEN VECTORS ==========\n")

v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)

distance <- sqrt(sum((v1 - v2)^2))
cat("v1:", v1, "\n")
cat("v2:", v2, "\n")
cat("Distance:", distance, "\n")

# ----------------------------------------------------------------------------
# ANGLE BETWEEN VECTORS
# ----------------------------------------------------------------------------

cat("\n========== ANGLE BETWEEN VECTORS ==========\n")

v1 <- c(1, 0, 0)
v2 <- c(1, 1, 0)

cos_theta <- sum(v1 * v2) / (sqrt(sum(v1^2)) * sqrt(sum(v2^2)))
theta_rad <- acos(cos_theta)
theta_deg <- theta_rad * 180 / pi

cat("v1:", v1, "\n")
cat("v2:", v2, "\n")
cat("Angle (radians):", theta_rad, "\n")
cat("Angle (degrees):", theta_deg, "\n")
