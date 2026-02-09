# ============================================================================
# R Eigenvalues and Eigenvectors
# ============================================================================
# Eigenvalues, eigenvectors, diagonalization, matrix powers

cat("\n========== EIGENVALUES AND EIGENVECTORS ==========\n")

# Definition: Av = λv where v ≠ 0
# A is the matrix, λ is eigenvalue, v is eigenvector

A <- matrix(c(
    4, 1,
    2, 3
), nrow = 2, byrow = TRUE)

cat("Matrix A:\n")
print(A)

# Compute eigenvalues and eigenvectors
eigen_result <- eigen(A)

cat("\nEigenvalues:\n")
print(eigen_result$values)

cat("\nEigenvectors:\n")
print(eigen_result$vectors)

# Verify: Av = λv for first eigenvalue/eigenvector
lambda1 <- eigen_result$values[1]
v1 <- eigen_result$vectors[, 1]

cat("\nVerification for first eigenvalue:\n")
cat("λ₁:", lambda1, "\n")
cat("v₁:", v1, "\n")
cat("Av₁:", as.vector(A %*% v1), "\n")
cat("λ₁v₁:", lambda1 * v1, "\n")
cat("Equal?", all(abs(A %*% v1 - lambda1 * v1) < 1e-10), "\n")

# ----------------------------------------------------------------------------
# CHARACTERISTIC POLYNOMIAL
# ----------------------------------------------------------------------------

cat("\n========== CHARACTERISTIC POLYNOMIAL ==========\n")

# det(A - λI) = 0

A <- matrix(c(
    2, 1,
    1, 2
), nrow = 2, byrow = TRUE)

cat("Matrix A:\n")
print(A)

# Eigenvalues are roots of characteristic polynomial
eigenvalues <- eigen(A)$values
cat("\nEigenvalues (roots of det(A - λI) = 0):\n")
print(eigenvalues)

# For 2x2 matrix: det(A - λI) = (a-λ)(d-λ) - bc
# Characteristic polynomial coefficients
trace_A <- sum(diag(A))
det_A <- det(A)

cat("\nTrace(A):", trace_A, "\n")
cat("Det(A):", det_A, "\n")
cat("Characteristic poly: λ² -", trace_A, "λ +", det_A, "\n")

# Verify: sum of eigenvalues = trace
cat("Sum of eigenvalues:", sum(eigenvalues), "\n")
cat("Equals trace?", abs(sum(eigenvalues) - trace_A) < 1e-10, "\n")

# Verify: product of eigenvalues = determinant
cat("Product of eigenvalues:", prod(eigenvalues), "\n")
cat("Equals det?", abs(prod(eigenvalues) - det_A) < 1e-10, "\n")

# ----------------------------------------------------------------------------
# DIAGONALIZATION
# ----------------------------------------------------------------------------

cat("\n========== DIAGONALIZATION ==========\n")

# A = PDP^(-1) where D is diagonal matrix of eigenvalues
# P is matrix of eigenvectors

A <- matrix(c(
    1, 2,
    2, 1
), nrow = 2, byrow = TRUE)

cat("Matrix A:\n")
print(A)

eigen_result <- eigen(A)
P <- eigen_result$vectors
D <- diag(eigen_result$values)

cat("\nEigenvalues:\n")
print(eigen_result$values)

cat("\nEigenvector matrix P:\n")
print(P)

cat("\nDiagonal matrix D:\n")
print(D)

# Verify: A = PDP^(-1)
reconstructed <- P %*% D %*% solve(P)
cat("\nPDP⁻¹:\n")
print(round(reconstructed, 10))

cat("\nEquals A?", all(abs(reconstructed - A) < 1e-10), "\n")

# ----------------------------------------------------------------------------
# MATRIX POWERS USING DIAGONALIZATION
# ----------------------------------------------------------------------------

cat("\n========== MATRIX POWERS ==========\n")

# A^n = P D^n P^(-1)
# Much faster for large n

A <- matrix(c(
    1, 2,
    2, 1
), nrow = 2, byrow = TRUE)

cat("Computing A^10:\n")

# Method 1: Direct multiplication (slow for large powers)
A_10_direct <- A
for (i in 1:9) {
    A_10_direct <- A_10_direct %*% A
}

cat("\nA^10 (direct):\n")
print(A_10_direct)

# Method 2: Using diagonalization (faster)
eigen_result <- eigen(A)
P <- eigen_result$vectors
D <- diag(eigen_result$values)
D_10 <- diag(eigen_result$values^10)

A_10_diag <- P %*% D_10 %*% solve(P)

cat("\nA^10 (diagonalization):\n")
print(round(A_10_diag, 2))

cat("\nMethods agree?", all(abs(A_10_direct - A_10_diag) < 1e-8), "\n")

# ----------------------------------------------------------------------------
# ALGEBRAIC AND GEOMETRIC MULTIPLICITY
# ----------------------------------------------------------------------------

cat("\n========== MULTIPLICITY ==========\n")

# Algebraic multiplicity: number of times eigenvalue appears
# Geometric multiplicity: dimension of eigenspace

A <- matrix(c(
    5, 0, 0,
    0, 5, 0,
    0, 0, 2
), nrow = 3, byrow = TRUE)

cat("Matrix A:\n")
print(A)

eigenvalues <- eigen(A)$values
eigenvectors <- eigen(A)$vectors

cat("\nEigenvalues:\n")
print(eigenvalues)

# Count multiplicities
unique_eval <- unique(round(eigenvalues, 10))
cat("\nUnique eigenvalues:", unique_eval, "\n")

for (val in unique_eval) {
    alg_mult <- sum(abs(eigenvalues - val) < 1e-10)
    cat("Eigenvalue", val, "- Algebraic multiplicity:", alg_mult, "\n")
}

# ----------------------------------------------------------------------------
# SYMMETRIC MATRICES
# ----------------------------------------------------------------------------

cat("\n========== SYMMETRIC MATRICES ==========\n")

# Symmetric matrices have real eigenvalues and orthogonal eigenvectors

A <- matrix(c(
    2, 1, 0,
    1, 2, 1,
    0, 1, 2
), nrow = 3, byrow = TRUE)

cat("Symmetric matrix A:\n")
print(A)

cat("Is symmetric?", isSymmetric(A), "\n")

eigen_result <- eigen(A)

cat("\nEigenvalues (all real for symmetric):\n")
print(eigen_result$values)

cat("\nEigenvectors:\n")
print(eigen_result$vectors)

# Verify orthogonality of eigenvectors
P <- eigen_result$vectors
cat("\nP'P (should be identity for orthogonal eigenvectors):\n")
print(round(t(P) %*% P, 10))

# ----------------------------------------------------------------------------
# POSITIVE DEFINITE MATRICES
# ----------------------------------------------------------------------------

cat("\n========== POSITIVE DEFINITE MATRICES ==========\n")

# A matrix is positive definite if all eigenvalues > 0

A <- matrix(c(
    2, 1,
    1, 2
), nrow = 2, byrow = TRUE)

cat("Matrix A:\n")
print(A)

eigenvalues <- eigen(A)$values
cat("\nEigenvalues:", eigenvalues, "\n")

is_pos_def <- all(eigenvalues > 0)
cat("Positive definite?", is_pos_def, "\n")

# Also check via quadratic form: x'Ax > 0 for all x ≠ 0
# Test with a random vector
x <- c(1, 2)
quadratic_form <- t(x) %*% A %*% x
cat("\nQuadratic form x'Ax with x =", x, ":", as.numeric(quadratic_form), "\n")

# ----------------------------------------------------------------------------
# SPECTRAL DECOMPOSITION
# ----------------------------------------------------------------------------

cat("\n========== SPECTRAL DECOMPOSITION ==========\n")

# For symmetric matrices: A = Q Λ Q' where Q is orthogonal

A <- matrix(c(
    3, 1,
    1, 3
), nrow = 2, byrow = TRUE)

cat("Symmetric matrix A:\n")
print(A)

eigen_result <- eigen(A)
Q <- eigen_result$vectors
Lambda <- diag(eigen_result$values)

cat("\nOrthogonal matrix Q:\n")
print(round(Q, 4))

cat("\nDiagonal matrix Λ:\n")
print(Lambda)

# Reconstruct: A = Q Λ Q'
reconstructed <- Q %*% Lambda %*% t(Q)
cat("\nQ Λ Q':\n")
print(round(reconstructed, 10))

# ----------------------------------------------------------------------------
# TRACE AND DETERMINANT VIA EIGENVALUES
# ----------------------------------------------------------------------------

cat("\n========== TRACE AND DETERMINANT ==========\n")

A <- matrix(c(
    1, 2, 3,
    4, 5, 6,
    7, 8, 10
), nrow = 3, byrow = TRUE)

cat("Matrix A:\n")
print(A)

eigenvalues <- eigen(A)$values

cat("\nEigenvalues:", eigenvalues, "\n")
cat("\nTrace(A) =", sum(diag(A)), "\n")
cat("Sum of eigenvalues =", sum(eigenvalues), "\n")

cat("\nDet(A) =", det(A), "\n")
cat("Product of eigenvalues =", prod(eigenvalues), "\n")

# ----------------------------------------------------------------------------
# EIGENVECTORS FOR REPEATED EIGENVALUES
# ----------------------------------------------------------------------------

cat("\n========== NON-DIAGONALIZABLE MATRIX ==========\n")

# Some matrices cannot be diagonalized (defective matrices)
A <- matrix(c(
    1, 1,
    0, 1
), nrow = 2, byrow = TRUE)

cat("Matrix A:\n")
print(A)

eigenvalues <- eigen(A)$values
eigenvectors <- eigen(A)$vectors

cat("\nEigenvalues:", eigenvalues, "\n")
cat("Both eigenvalues are 1 (repeated)\n")

cat("\nEigenvectors:\n")
print(eigenvectors)

# Check if diagonalizable (rank of eigenvector matrix)
cat("\nRank of eigenvector matrix:", qr(eigenvectors)$rank, "\n")
cat("Diagonalizable?", qr(eigenvectors)$rank == ncol(A), "\n")

