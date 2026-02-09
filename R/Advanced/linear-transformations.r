# ============================================================================
# R Linear Transformations
# ============================================================================
# Matrix representations, kernel, image, rank-nullity, composition

cat("\n========== LINEAR TRANSFORMATION BASICS ==========\n")

# A linear transformation T: R^n -> R^m is represented by a matrix A
# T(v) = A * v

# Example: Rotation by 90 degrees in R^2
theta <- pi / 2 # 90 degrees
rotation_matrix <- matrix(c(
    cos(theta), sin(theta),
    -sin(theta), cos(theta)
), nrow = 2, byrow = TRUE)

cat("Rotation matrix (90 degrees):\n")
print(round(rotation_matrix, 10))

v <- c(1, 0)
Tv <- rotation_matrix %*% v
cat("\nOriginal vector:", v, "\n")
cat("After rotation:", as.vector(Tv), "\n")
cat("Expected:", c(0, 1), "\n")

# ----------------------------------------------------------------------------
# MATRIX OF A LINEAR TRANSFORMATION
# ----------------------------------------------------------------------------

cat("\n========== FINDING MATRIX REPRESENTATION ==========\n")

# To find the matrix of a transformation, apply it to basis vectors
# The columns of the matrix are T(e1), T(e2), ..., T(en)

# Example: Projection onto x-axis in R^2
proj_x <- function(v) {
    return(c(v[1], 0))
}

e1 <- c(1, 0)
e2 <- c(0, 1)

T_e1 <- proj_x(e1)
T_e2 <- proj_x(e2)

proj_matrix <- cbind(T_e1, T_e2)
cat("Projection onto x-axis matrix:\n")
print(proj_matrix)

v <- c(3, 4)
cat("\nVector v:", v, "\n")
cat("T(v) using function:", proj_x(v), "\n")
cat("T(v) using matrix:", as.vector(proj_matrix %*% v), "\n")

# ----------------------------------------------------------------------------
# KERNEL (NULL SPACE)
# ----------------------------------------------------------------------------

cat("\n========== KERNEL (NULL SPACE) ==========\n")

A <- matrix(c(
    1, 2, 3,
    2, 4, 6
), nrow = 2, ncol = 3, byrow = FALSE)

cat("Transformation matrix A:\n")
print(A)

svd_result <- svd(A)
rank_A <- qr(A)$rank
nullity <- ncol(A) - rank_A

cat("\nRank:", rank_A, "\n")
cat("Nullity:", nullity, "\n")

if (nullity > 0) {
    kernel_basis <- svd_result$v[, (rank_A + 1):ncol(A), drop = FALSE]
    cat("\nBasis for kernel:\n")
    print(kernel_basis)
    cat("\nVerification (should be near zero):\n")
    print(A %*% kernel_basis)
} else {
    cat("\nKernel is trivial (only zero vector)\n")
}

# ----------------------------------------------------------------------------
# IMAGE (COLUMN SPACE / RANGE)
# ----------------------------------------------------------------------------

cat("\n========== IMAGE (RANGE) ==========\n")

A <- matrix(c(
    1, 2, 3,
    2, 4, 6,
    3, 6, 9
), nrow = 3, ncol = 3, byrow = FALSE)

cat("Transformation matrix A:\n")
print(A)

qr_decomp <- qr(A)
rank_A <- qr_decomp$rank
pivot_cols <- qr_decomp$pivot[1:rank_A]

image_basis <- A[, pivot_cols, drop = FALSE]
cat("\nBasis for image (column space):\n")
print(image_basis)
cat("Dimension of image:", ncol(image_basis), "\n")

# ----------------------------------------------------------------------------
# RANK-NULLITY THEOREM
# ----------------------------------------------------------------------------

cat("\n========== RANK-NULLITY THEOREM ==========\n")

A <- matrix(c(
    1, 0, 1,
    0, 1, 1,
    0, 0, 0
), nrow = 3, ncol = 3, byrow = FALSE)

cat("Transformation matrix A:\n")
print(A)

n <- ncol(A)
rank_A <- qr(A)$rank
nullity_A <- n - rank_A

cat("\nDimension of domain (n):", n, "\n")
cat("Rank (dim of image):", rank_A, "\n")
cat("Nullity (dim of kernel):", nullity_A, "\n")
cat("Rank + Nullity:", rank_A + nullity_A, "\n")
cat("Theorem verified:", rank_A + nullity_A == n, "\n")

# ----------------------------------------------------------------------------
# ONE-TO-ONE (INJECTIVE)
# ----------------------------------------------------------------------------

cat("\n========== ONE-TO-ONE (INJECTIVE) ==========\n")

is_one_to_one <- function(A) {
    return(qr(A)$rank == ncol(A))
}

A1 <- matrix(c(
    1, 0,
    0, 1,
    1, 1
), nrow = 3, ncol = 2, byrow = FALSE)

cat("Matrix A1:\n")
print(A1)
cat("One-to-one?", is_one_to_one(A1), "\n")
cat("Kernel dimension:", ncol(A1) - qr(A1)$rank, "\n")

# ----------------------------------------------------------------------------
# ONTO (SURJECTIVE)
# ----------------------------------------------------------------------------

cat("\n========== ONTO (SURJECTIVE) ==========\n")

is_onto <- function(A) {
    return(qr(A)$rank == nrow(A))
}

A1 <- matrix(c(
    1, 0,
    0, 1
), nrow = 2, ncol = 2, byrow = FALSE)

cat("Matrix A1 (2x2):\n")
print(A1)
cat("Onto?", is_onto(A1), "\n")
cat("Rank:", qr(A1)$rank, "\n")

# ----------------------------------------------------------------------------
# COMPOSITION OF TRANSFORMATIONS
# ----------------------------------------------------------------------------

cat("\n========== COMPOSITION OF TRANSFORMATIONS ==========\n")

theta1 <- pi / 4
T <- matrix(c(
    cos(theta1), sin(theta1),
    -sin(theta1), cos(theta1)
), nrow = 2, byrow = TRUE)

S <- matrix(c(
    2, 0,
    0, 2
), nrow = 2, byrow = TRUE)

cat("Transformation T (rotation 45°):\n")
print(round(T, 4))

cat("\nTransformation S (scaling by 2):\n")
print(S)

composition <- S %*% T

cat("\nComposition S ∘ T:\n")
print(round(composition, 4))

v <- c(1, 0)
cat("\nOriginal vector:", v, "\n")
cat("T(v):", as.vector(round(T %*% v, 4)), "\n")
cat("S(T(v)):", as.vector(round(S %*% (T %*% v), 4)), "\n")
cat("(S∘T)(v):", as.vector(round(composition %*% v, 4)), "\n")

# ----------------------------------------------------------------------------
# INVERSE TRANSFORMATION
# ----------------------------------------------------------------------------

cat("\n========== INVERSE TRANSFORMATION ==========\n")

A <- matrix(c(
    1, 2,
    3, 4
), nrow = 2, byrow = TRUE)

cat("Transformation matrix A:\n")
print(A)
cat("Determinant:", det(A), "\n")

if (abs(det(A)) > 1e-10) {
    A_inv <- solve(A)
    cat("Invertible: TRUE\n")
    cat("\nInverse matrix:\n")
    print(A_inv)
    cat("\nA * A^(-1):\n")
    print(round(A %*% A_inv, 10))
} else {
    cat("Invertible: FALSE\n")
}

# ----------------------------------------------------------------------------
# CHANGE OF BASIS FOR TRANSFORMATIONS
# ----------------------------------------------------------------------------

cat("\n========== CHANGE OF BASIS FOR TRANSFORMATIONS ==========\n")

A <- matrix(c(
    2, 1,
    0, 3
), nrow = 2, byrow = TRUE)

B <- matrix(c(
    1, 1,
    1, -1
), nrow = 2, byrow = FALSE)

cat("Transformation A in standard basis:\n")
print(A)

cat("\nNew basis B:\n")
print(B)

A_in_B <- solve(B) %*% A %*% B
cat("\nA in basis B:\n")
print(round(A_in_B, 4))

# ----------------------------------------------------------------------------
# CUSTOM PROBLEM: T(x,y,z) = (x+2y-z, x+y, x+z) in basis B
# ----------------------------------------------------------------------------

cat("\n========== CUSTOM PROBLEM ==========\n")

# Function to find coordinates in basis B
find_T_coords <- function(x, y, z, show_eqn = FALSE) {
    T_result <- c(x + 2 * y - z, x + y, x + z)
    B <- matrix(c(1, 1, 0, 1, 0, 1, 0, 1, 1), nrow = 3, byrow = FALSE)

    if (show_eqn && requireNamespace("matlib", quietly = TRUE)) {
        cat("\nT(", x, ",", y, ",", z, ") =", T_result, "\n", sep = "")
        matlib::showEqn(B, T_result)
    }

    return(solve(B, T_result))
}

# Matrix in standard basis
A_standard <- matrix(c(1, 1, 1, 2, 1, 0, -1, 0, 1), nrow = 3, byrow = FALSE)
cat("Matrix in standard basis:\n")
print(A_standard)

# Matrix in custom basis B = {(1,1,0), (1,0,1), (0,1,1)}
cat("\nMatrix in basis B:\n")
T_matrix_B <- cbind(
    find_T_coords(1, 1, 0, show_eqn = TRUE),
    find_T_coords(1, 0, 1, show_eqn = TRUE),
    find_T_coords(0, 1, 1, show_eqn = TRUE)
)
print(T_matrix_B)

# Verify: B^(-1) * A * B
B <- matrix(c(1, 1, 0, 1, 0, 1, 0, 1, 1), nrow = 3, byrow = FALSE)
cat("\nVerification B^(-1) * A * B:\n")
print(round(solve(B) %*% A_standard %*% B, 10))


