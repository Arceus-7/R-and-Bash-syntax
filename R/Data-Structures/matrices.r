# ============================================================================
# R Data Structures: Matrices
# ============================================================================
# Matrices are two-dimensional arrays with elements of the same type

# ----------------------------------------------------------------------------
# 1. CREATING MATRICES
# ----------------------------------------------------------------------------

# Create matrix from vector
mat1 <- matrix(1:12, nrow = 3, ncol = 4)
print(mat1)

# Create matrix by row
mat2 <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)
print(mat2)

# Create matrix with specific values
mat3 <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 2, ncol = 3)
print(mat3)

# ----------------------------------------------------------------------------
# 2. MATRIX PROPERTIES
# ----------------------------------------------------------------------------

cat("Dimensions:", dim(mat1), "\n")
cat("Rows:", nrow(mat1), "Columns:", ncol(mat1), "\n")
cat("Length:", length(mat1), "\n")

# ----------------------------------------------------------------------------
# 3. MATRIX INDEXING
# ----------------------------------------------------------------------------

sample_mat <- matrix(10:21, nrow = 3, ncol = 4)
print(sample_mat)
cat("Element [2,3]:", sample_mat[2, 3], "\n")
cat("First row:", sample_mat[1, ], "\n")
cat("Second column:", sample_mat[, 2], "\n")
print(sample_mat[1:2, 2:3])

# ----------------------------------------------------------------------------
# 4. MATRIX ARITHMETIC
# ----------------------------------------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2)
B <- matrix(c(5, 6, 7, 8), nrow = 2)
print(A)
print(B)
cat("A + B:\n")
print(A + B)
cat("A - B:\n")
print(A - B)
cat("A * B (element-wise):\n")
print(A * B)

# ----------------------------------------------------------------------------
# 5. MATRIX MULTIPLICATION
# ----------------------------------------------------------------------------

C <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
D <- matrix(c(7, 8, 9, 10, 11, 12), nrow = 3, ncol = 2)
print(C)
print(D)
cat("C %*% D:\n")
print(C %*% D)

# ----------------------------------------------------------------------------
# 6. TRANSPOSE
# ----------------------------------------------------------------------------

mat <- matrix(1:6, nrow = 2, ncol = 3)
print(mat)
cat("Transpose:\n")
print(t(mat))

# ----------------------------------------------------------------------------
# 7. DETERMINANT AND INVERSE
# ----------------------------------------------------------------------------

E <- matrix(c(4, 2, 7, 6), nrow = 2)
print(E)
cat("Determinant:", det(E), "\n")
cat("Inverse:\n")
print(solve(E))
cat("Verification (E %*% inv(E)):\n")
print(round(E %*% solve(E), 10))

# ----------------------------------------------------------------------------
# 8. DIAGONAL OPERATIONS
# ----------------------------------------------------------------------------

mat_diag <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
print(mat_diag)
cat("Diagonal:", diag(mat_diag), "\n")

# Create diagonal matrix
diag_mat <- diag(c(5, 10, 15))
print(diag_mat)

# Create identity matrix
identity <- diag(4)
print(identity)

# ----------------------------------------------------------------------------
# 9. EIGENVALUES AND EIGENVECTORS
# ----------------------------------------------------------------------------

F <- matrix(c(3, -1, 1, 1), nrow = 2)
print(F)
eigen_result <- eigen(F)
cat("Eigenvalues:\n")
print(eigen_result$values)
cat("Eigenvectors:\n")
print(eigen_result$vectors)

# ----------------------------------------------------------------------------
# 10. MATRIX FUNCTIONS
# ----------------------------------------------------------------------------

G <- matrix(c(2, 4, 1, 3, 5, 7, 2, 6, 3), nrow = 3)
print(G)
cat("Row sums:", rowSums(G), "\n")
cat("Column sums:", colSums(G), "\n")
cat("Row means:", rowMeans(G), "\n")
cat("Column means:", colMeans(G), "\n")
cat("Total sum:", sum(G), "\n")
cat("Mean:", mean(G), "\n")

# ----------------------------------------------------------------------------
# 11. BINDING MATRICES
# ----------------------------------------------------------------------------

mat_a <- matrix(1:6, nrow = 2)
mat_b <- matrix(7:12, nrow = 2)
print(mat_a)
print(mat_b)
cat("Row bind:\n")
print(rbind(mat_a, mat_b))
cat("Column bind:\n")
print(cbind(mat_a, mat_b))

# ----------------------------------------------------------------------------
# 12. SOLVING LINEAR SYSTEMS
# ----------------------------------------------------------------------------

# Simple 2x2 system: 2x + y = 5, x + 3y = 8
A_sys <- matrix(c(2, 1, 1, 3), nrow = 2, byrow = TRUE)
b_sys <- c(5, 8)
print(A_sys)
cat("b:", b_sys, "\n")
solution <- solve(A_sys, b_sys)
cat("Solution:", solution, "\n")
cat("Verification:", as.vector(A_sys %*% solution), "\n")

# 3x3 system
A3x3 <- matrix(c(2, 1, -1, -3, -1, 2, -2, 1, 2), nrow = 3, byrow = TRUE)
b3x3 <- c(8, -11, -3)
cat("\n3x3 System:\n")
print(A3x3)
cat("b:", b3x3, "\n")
sol_3x3 <- solve(A3x3, b3x3)
cat("Solution:", sol_3x3, "\n")
cat("Verification:", as.vector(A3x3 %*% sol_3x3), "\n")

# Multiple right-hand sides
B_multi <- matrix(c(5, 8, 10, 15), nrow = 2, ncol = 2)
cat("\nSolving for multiple RHS:\n")
print(B_multi)
sol_multi <- solve(A_sys, B_multi)
cat("Solutions:\n")
print(sol_multi)

# ----------------------------------------------------------------------------
# 13. LU DECOMPOSITION
# ----------------------------------------------------------------------------

cat("\n=== LU Decomposition ===\n")
M <- matrix(c(4, 3, 2, 1, 3, 4, 2, 5, 9), nrow = 3, byrow = TRUE)
print(M)

# Using expand() to get L and U
lu_result <- Matrix::lu(M)
cat("LU decomposition completed\n")

# Alternative: Manual LU
library(Matrix)
lu_obj <- expand(lu(M))
cat("L matrix:\n")
print(as.matrix(lu_obj$L))
cat("U matrix:\n")
print(as.matrix(lu_obj$U))

# Verify: L %*% U should equal M
cat("Verification L*U:\n")
print(as.matrix(lu_obj$L %*% lu_obj$U))

# ----------------------------------------------------------------------------
# 14. QR DECOMPOSITION
# ----------------------------------------------------------------------------

cat("\n=== QR Decomposition ===\n")
QR_mat <- matrix(c(12, -51, 4, 6, 167, -68, -4, 24, -41), nrow = 3, byrow = TRUE)
print(QR_mat)

qr_result <- qr(QR_mat)
Q <- qr.Q(qr_result)
R <- qr.R(qr_result)

cat("Q matrix (orthogonal):\n")
print(Q)
cat("R matrix (upper triangular):\n")
print(R)
cat("Verification Q*R:\n")
print(Q %*% R)
cat("Q^T * Q (should be identity):\n")
print(round(t(Q) %*% Q, 10))

# Solving using QR
b_qr <- c(1, 2, 3)
sol_qr <- qr.solve(QR_mat, b_qr)
cat("Solution using QR:", sol_qr, "\n")

# ----------------------------------------------------------------------------
# 15. CHOLESKY DECOMPOSITION
# ----------------------------------------------------------------------------

cat("\n=== Cholesky Decomposition ===\n")
# For symmetric positive definite matrices
SPD <- matrix(c(4, 12, -16, 12, 37, -43, -16, -43, 98), nrow = 3, byrow = TRUE)
cat("Symmetric Positive Definite matrix:\n")
print(SPD)

chol_result <- chol(SPD)
cat("Cholesky factor (upper triangular):\n")
print(chol_result)
cat("Verification t(R) %*% R:\n")
print(t(chol_result) %*% chol_result)

# Solving using Cholesky
b_chol <- c(1, 2, 3)
sol_chol <- chol2inv(chol_result) %*% b_chol
cat("Solution using Cholesky:", as.vector(sol_chol), "\n")

# ----------------------------------------------------------------------------
# 16. SINGULAR VALUE DECOMPOSITION (SVD)
# ----------------------------------------------------------------------------

cat("\n=== Singular Value Decomposition ===\n")
SVD_mat <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), nrow = 3, ncol = 4)
print(SVD_mat)

svd_result <- svd(SVD_mat)
cat("Singular values:\n")
print(svd_result$d)
cat("Left singular vectors (U):\n")
print(svd_result$u)
cat("Right singular vectors (V):\n")
print(svd_result$v)

# Verify: U %*% diag(d) %*% t(V) = A
reconstructed <- svd_result$u %*% diag(svd_result$d) %*% t(svd_result$v)
cat("Reconstruction error:", norm(SVD_mat - reconstructed, "F"), "\n")

# ----------------------------------------------------------------------------
# 17. PSEUDOINVERSE (Moore-Penrose)
# ----------------------------------------------------------------------------

cat("\n=== Pseudoinverse ===\n")
library(MASS)

# Non-square matrix
NS_mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
cat("Non-square matrix:\n")
print(NS_mat)

pinv <- ginv(NS_mat)
cat("Pseudoinverse:\n")
print(pinv)
cat("A * A+ * A (should equal A):\n")
print(NS_mat %*% pinv %*% NS_mat)

# Solving overdetermined system
A_over <- matrix(c(1, 1, 2, 1, 3, 2), nrow = 3, ncol = 2)
b_over <- c(2, 3, 5)
cat("\nOverdetermined system (3 equations, 2 unknowns):\n")
print(A_over)
sol_pinv <- ginv(A_over) %*% b_over
cat("Least squares solution:", as.vector(sol_pinv), "\n")
cat("Residual norm:", norm(A_over %*% sol_pinv - b_over, "2"), "\n")

# ----------------------------------------------------------------------------
# 18. ADVANCED OPERATIONS
# ----------------------------------------------------------------------------

H <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
print(H)
cat("Rank:", qr(H)$rank, "\n")
cat("Trace:", sum(diag(H)), "\n")
cat("Frobenius norm:", norm(H, "F"), "\n")
cat("Condition number:", kappa(H), "\n")
cat("Matrix power (H^3):\n")
print(H %*% H %*% H)

# Matrix exponential
if (!require(expm)) install.packages("expm")
library(expm)
cat("Matrix exponential:\n")
print(expm(matrix(c(0, -1, 1, 0), 2, 2)))
