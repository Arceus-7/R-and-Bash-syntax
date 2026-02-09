# ============================================================================
# R Basis and Dimension
# ============================================================================
# Linear independence, basis verification, dimension, change of basis

cat("\n========== LINEAR INDEPENDENCE ==========\n")

# Function to check linear independence using rank
is_linearly_independent <- function(vectors) {
    # vectors should be a matrix where each column is a vector
    rank <- qr(vectors)$rank
    num_vectors <- ncol(vectors)

    return(rank == num_vectors)
}

# Example 1: Linearly independent vectors in R^3
v1 <- c(1, 0, 0)
v2 <- c(0, 1, 0)
v3 <- c(0, 0, 1)
V <- cbind(v1, v2, v3)

cat("Vectors:\n")
print(V)
cat("Rank:", qr(V)$rank, "\n")
cat("Number of vectors:", ncol(V), "\n")
cat("Linearly independent?", is_linearly_independent(V), "\n")

# Example 2: Linearly dependent vectors
cat("\nLinearly dependent example:\n")
v1 <- c(1, 2, 3)
v2 <- c(2, 4, 6) # 2 * v1
v3 <- c(1, 1, 1)
V <- cbind(v1, v2, v3)

cat("Vectors:\n")
print(V)
cat("Rank:", qr(V)$rank, "\n")
cat("Number of vectors:", ncol(V), "\n")
cat("Linearly independent?", is_linearly_independent(V), "\n")

# ----------------------------------------------------------------------------
# BASIS VERIFICATION
# ----------------------------------------------------------------------------

cat("\n========== BASIS VERIFICATION ==========\n")

# Function to check if vectors form a basis for R^n
is_basis <- function(vectors) {
    n <- nrow(vectors)
    m <- ncol(vectors)

    # Must have n vectors for R^n
    if (m != n) {
        return(FALSE)
    }

    # Must be linearly independent
    return(is_linearly_independent(vectors))
}

# Example: Standard basis for R^3
cat("Standard basis for R^3:\n")
e1 <- c(1, 0, 0)
e2 <- c(0, 1, 0)
e3 <- c(0, 0, 1)
standard_basis <- cbind(e1, e2, e3)
print(standard_basis)
cat("Is this a basis for R^3?", is_basis(standard_basis), "\n")

# Example: Another basis for R^3
cat("\nAnother basis for R^3:\n")
v1 <- c(1, 1, 0)
v2 <- c(1, 0, 1)
v3 <- c(0, 1, 1)
B <- cbind(v1, v2, v3)
print(B)
cat("Is this a basis for R^3?", is_basis(B), "\n")
cat("Determinant (non-zero means basis):", det(B), "\n")

# Example: Not a basis (linearly dependent)
cat("\nNot a basis (linearly dependent):\n")
v1 <- c(1, 2, 3)
v2 <- c(2, 4, 6)
v3 <- c(3, 6, 9)
B <- cbind(v1, v2, v3)
print(B)
cat("Is this a basis for R^3?", is_basis(B), "\n")
cat("Determinant:", det(B), "\n")

# ----------------------------------------------------------------------------
# DIMENSION
# ----------------------------------------------------------------------------

cat("\n========== DIMENSION OF VECTOR SPACE ==========\n")

# Dimension = number of vectors in a basis = rank of matrix
A <- matrix(c(
    1, 2, 3,
    2, 4, 6,
    1, 1, 1,
    0, 1, 2
), nrow = 4, ncol = 3, byrow = FALSE)

cat("Matrix A:\n")
print(A)
cat("Dimension of column space (rank):", qr(A)$rank, "\n")

# Row space dimension
cat("Dimension of row space:", qr(t(A))$rank, "\n")

# ----------------------------------------------------------------------------
# FINDING A BASIS FOR COLUMN SPACE
# ----------------------------------------------------------------------------

cat("\n========== BASIS FOR COLUMN SPACE ==========\n")

find_column_basis <- function(A) {
    qr_decomp <- qr(A)
    pivot_cols <- qr_decomp$pivot[1:qr_decomp$rank]
    return(A[, pivot_cols, drop = FALSE])
}

A <- matrix(c(
    1, 2, 3,
    2, 4, 6,
    3, 6, 9,
    1, 1, 1
), nrow = 4, ncol = 3, byrow = FALSE)

cat("Matrix A:\n")
print(A)

basis <- find_column_basis(A)
cat("\nBasis for column space:\n")
print(basis)
cat("Dimension:", ncol(basis), "\n")

# ----------------------------------------------------------------------------
# COORDINATE VECTORS
# ----------------------------------------------------------------------------

cat("\n========== COORDINATE VECTORS ==========\n")

# Express vector v in terms of basis B
find_coordinates <- function(v, B) {
    # Solve B * x = v
    coords <- solve(B, v)
    return(coords)
}

# Standard basis
v <- c(2, 3, 4)
B_standard <- diag(3)

cat("Vector v:", v, "\n")
cat("Standard basis:\n")
print(B_standard)
coords_standard <- find_coordinates(v, B_standard)
cat("Coordinates in standard basis:", coords_standard, "\n")

# Different basis
B <- matrix(c(
    1, 1, 0,
    1, 0, 1,
    0, 1, 1
), nrow = 3, ncol = 3, byrow = FALSE)
cat("\nBasis B:\n")
print(B)
coords_B <- find_coordinates(v, B)
cat("Coordinates in basis B:", coords_B, "\n")

# Verify: B * coords should equal v
verification <- B %*% coords_B
cat("Verification B*coords:", as.vector(verification), "\n")

# ----------------------------------------------------------------------------
# CHANGE OF BASIS
# ----------------------------------------------------------------------------

cat("\n========== CHANGE OF BASIS ==========\n")

# Change coordinates from basis B to basis C
change_of_basis_matrix <- function(B, C) {
    # P = C^(-1) * B
    P <- solve(C) %*% B
    return(P)
}

# Basis B
B <- matrix(c(
    1, 1, 0,
    1, 0, 1,
    0, 1, 1
), nrow = 3, ncol = 3, byrow = FALSE)

# Basis C (standard basis)
C <- diag(3)

cat("Basis B:\n")
print(B)
cat("\nBasis C (standard):\n")
print(C)

P <- change_of_basis_matrix(B, C)
cat("\nChange of basis matrix P (B to C):\n")
print(P)

# Convert coordinates
coords_in_B <- c(1, 2, 3)
coords_in_C <- P %*% coords_in_B
cat("\nCoordinates in B:", coords_in_B, "\n")
cat("Coordinates in C:", as.vector(coords_in_C), "\n")

# ----------------------------------------------------------------------------
# EXTENDING TO A BASIS
# ----------------------------------------------------------------------------

cat("\n========== EXTENDING TO A BASIS ==========\n")

# Given linearly independent vectors, extend to a basis
extend_to_basis <- function(vectors, n) {
    # Start with given vectors
    current <- vectors

    # Try adding standard basis vectors
    for (i in 1:n) {
        ei <- numeric(n)
        ei[i] <- 1
        test <- cbind(current, ei)

        # Check if still independent
        if (qr(test)$rank > ncol(current)) {
            current <- test
        }

        # Stop when we have n vectors
        if (ncol(current) == n) {
            break
        }
    }

    return(current)
}

# Start with two vectors in R^3
v1 <- c(1, 0, 0)
v2 <- c(0, 1, 0)
V <- cbind(v1, v2)

cat("Starting vectors:\n")
print(V)

basis <- extend_to_basis(V, 3)
cat("\nExtended to basis:\n")
print(basis)
cat("Is basis?", is_basis(basis), "\n")

# ----------------------------------------------------------------------------
# BASIS FOR NULL SPACE (KERNEL)
# ----------------------------------------------------------------------------

cat("\n========== BASIS FOR NULL SPACE ==========\n")

# Find basis for null space of A (solutions to Ax = 0)
A <- matrix(c(
    1, 2, 3,
    2, 4, 6
), nrow = 2, ncol = 3, byrow = FALSE)

cat("Matrix A:\n")
print(A)

# Use SVD to find null space
svd_result <- svd(A)
null_space_dim <- ncol(A) - qr(A)$rank

if (null_space_dim > 0) {
    null_basis <- svd_result$v[, (qr(A)$rank + 1):ncol(A), drop = FALSE]
    cat("\nBasis for null space:\n")
    print(null_basis)
    cat("Dimension of null space:", null_space_dim, "\n")

    # Verify: A * null_basis should be approximately zero
    cat("\nVerification A * null_basis:\n")
    print(A %*% null_basis)
} else {
    cat("\nNull space is {0} (trivial)\n")
}

# ----------------------------------------------------------------------------
# RANK-NULLITY THEOREM
# ----------------------------------------------------------------------------

cat("\n========== RANK-NULLITY THEOREM ==========\n")

A <- matrix(c(
    1, 2, 3, 4,
    5, 6, 7, 8,
    9, 10, 11, 12
), nrow = 3, ncol = 4, byrow = FALSE)

cat("Matrix A (3x4):\n")
print(A)

rank_A <- qr(A)$rank
nullity_A <- ncol(A) - rank_A

cat("\nRank:", rank_A, "\n")
cat("Nullity:", nullity_A, "\n")
cat("Number of columns:", ncol(A), "\n")
cat("Rank + Nullity =", rank_A + nullity_A, "\n")
cat("Rank-Nullity Theorem verified:", rank_A + nullity_A == ncol(A), "\n")

