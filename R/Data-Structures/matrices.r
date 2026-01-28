# ============================================================================
# R Data Structures: Matrices
# ============================================================================
# Matrices are two-dimensional arrays with elements of the same type

cat("=== R Matrices ===\n\n")

# ----------------------------------------------------------------------------
# 1. CREATING MATRICES
# ----------------------------------------------------------------------------

# Create matrix from vector
mat1 <- matrix(1:12, nrow = 3, ncol = 4)

cat("Basic matrix creation:\n")
cat("Matrix (3x4):\n")
print(mat1)
cat("\n")

# Create matrix by row
mat2 <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)

cat("Matrix filled by row:\n")
print(mat2)
cat("\n")

# Create matrix with specific values
mat3 <- matrix(c(10, 20, 30, 40, 50, 60), nrow = 2, ncol = 3)

cat("Matrix with specific values:\n")
print(mat3)
cat("\n")

# ----------------------------------------------------------------------------
# 2. MATRIX PROPERTIES
# ----------------------------------------------------------------------------

cat("Matrix properties:\n")
cat("Dimensions: dim(mat1) =", dim(mat1), "\n")
cat("Number of rows: nrow(mat1) =", nrow(mat1), "\n")
cat("Number of columns: ncol(mat1) =", ncol(mat1), "\n")
cat("Total elements: length(mat1) =", length(mat1), "\n\n")

# ----------------------------------------------------------------------------
# 3. MATRIX INDEXING
# ----------------------------------------------------------------------------

# Create sample matrix
sample_mat <- matrix(10:21, nrow = 3, ncol = 4)

cat("Sample matrix for indexing:\n")
print(sample_mat)
cat("\n")

cat("Matrix indexing:\n")
cat("Element [2,3]:", sample_mat[2, 3], "\n")
cat("First row:", sample_mat[1, ], "\n")
cat("Second column:", sample_mat[, 2], "\n")
cat("Submatrix [1:2, 2:3]:\n")
print(sample_mat[1:2, 2:3])
cat("\n")

# ----------------------------------------------------------------------------
# 4. MATRIX ARITHMETIC
# ----------------------------------------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2)
B <- matrix(c(5, 6, 7, 8), nrow = 2)

cat("Matrix A:\n")
print(A)
cat("\nMatrix B:\n")
print(B)
cat("\n")

cat("Matrix arithmetic:\n")
cat("A + B:\n")
print(A + B)
cat("\nA - B:\n")
print(A - B)
cat("\nElement-wise multiplication (A * B):\n")
print(A * B)
cat("\nElement-wise division (A / B):\n")
print(A / B)
cat("\n")

# ----------------------------------------------------------------------------
# 5. MATRIX MULTIPLICATION
# ----------------------------------------------------------------------------

# Matrix multiplication
C <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
D <- matrix(c(7, 8, 9, 10, 11, 12), nrow = 3, ncol = 2)

cat("Matrix multiplication:\n")
cat("Matrix C (2x3):\n")
print(C)
cat("\nMatrix D (3x2):\n")
print(D)
cat("\nC %*% D (Matrix multiplication):\n")
print(C %*% D)
cat("\n")

# ----------------------------------------------------------------------------
# 6. TRANSPOSE
# ----------------------------------------------------------------------------

mat <- matrix(1:6, nrow = 2, ncol = 3)

cat("Transpose:\n")
cat("Original matrix:\n")
print(mat)
cat("\nTranspose t(mat):\n")
print(t(mat))
cat("\n")

# ----------------------------------------------------------------------------
# 7. DETERMINANT AND INVERSE
# ----------------------------------------------------------------------------

# Square matrix for determinant and inverse
E <- matrix(c(4, 2, 7, 6), nrow = 2)

cat("Determinant and Inverse:\n")
cat("Matrix E:\n")
print(E)
cat("\nDeterminant: det(E) =", det(E), "\n")
cat("Inverse: solve(E):\n")
print(solve(E))

# Verify: E %*% solve(E) should be identity matrix
cat("\nVerification (E %*% solve(E)):\n")
print(round(E %*% solve(E), 10))
cat("\n")

# ----------------------------------------------------------------------------
# 8. DIAGONAL OPERATIONS
# ----------------------------------------------------------------------------

# Extract diagonal
mat_diag <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)

cat("Diagonal operations:\n")
cat("Matrix:\n")
print(mat_diag)
cat("\nDiagonal elements: diag(mat) =", diag(mat_diag), "\n")

# Create diagonal matrix
diag_mat <- diag(c(5, 10, 15))
cat("\nDiagonal matrix from vector:\n")
print(diag_mat)

# Create identity matrix
identity <- diag(4)
cat("\nIdentity matrix (4x4):\n")
print(identity)
cat("\n")

# ----------------------------------------------------------------------------
# 9. EIGENVALUES AND EIGENVECTORS
# ----------------------------------------------------------------------------

F <- matrix(c(3, -1, 1, 1), nrow = 2)

cat("Eigenvalues and Eigenvectors:\n")
cat("Matrix F:\n")
print(F)

eigen_result <- eigen(F)
cat("\nEigenvalues:\n")
print(eigen_result$values)
cat("\nEigenvectors:\n")
print(eigen_result$vectors)
cat("\n")

# ----------------------------------------------------------------------------
# 10. MATRIX FUNCTIONS
# ----------------------------------------------------------------------------

G <- matrix(c(2, 4, 1, 3, 5, 7, 2, 6, 3), nrow = 3)

cat("Matrix functions:\n")
cat("Original matrix G:\n")
print(G)
cat("\n")

cat("Row sums: rowSums(G) =", rowSums(G), "\n")
cat("Column sums: colSums(G) =", colSums(G), "\n")
cat("Row means: rowMeans(G) =", rowMeans(G), "\n")
cat("Column means: colMeans(G) =", colMeans(G), "\n")
cat("Sum of all elements: sum(G) =", sum(G), "\n")
cat("Mean of all elements: mean(G) =", mean(G), "\n\n")

# ----------------------------------------------------------------------------
# 11. BINDING MATRICES
# ----------------------------------------------------------------------------

mat_a <- matrix(1:6, nrow = 2)
mat_b <- matrix(7:12, nrow = 2)

cat("Binding matrices:\n")
cat("Matrix A:\n")
print(mat_a)
cat("\nMatrix B:\n")
print(mat_b)

cat("\nRow bind (rbind):\n")
print(rbind(mat_a, mat_b))

cat("\nColumn bind (cbind):\n")
print(cbind(mat_a, mat_b))
cat("\n")

# ----------------------------------------------------------------------------
# 12. SOLVING LINEAR SYSTEMS
# ----------------------------------------------------------------------------

# Solve Ax = b
# System: 2x + y = 5
#         x + 3y = 8

A_sys <- matrix(c(2, 1, 1, 3), nrow = 2, byrow = TRUE)
b_sys <- c(5, 8)

cat("Solving linear system Ax = b:\n")
cat("Matrix A:\n")
print(A_sys)
cat("\nb vector:", b_sys, "\n")

solution <- solve(A_sys, b_sys)
cat("Solution x:", solution, "\n")

# Verify
cat("Verification (A %*% x):", as.vector(A_sys %*% solution), "\n\n")

# ----------------------------------------------------------------------------
# 13. ADVANCED OPERATIONS
# ----------------------------------------------------------------------------

H <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)

cat("Advanced matrix operations:\n")
cat("Matrix H:\n")
print(H)
cat("\n")

# Matrix rank
cat("Rank: qr(H)$rank =", qr(H)$rank, "\n")

# Matrix trace (sum of diagonal elements)
cat("Trace: sum(diag(H)) =", sum(diag(H)), "\n")

# Matrix norm
cat("Frobenius norm: norm(H, 'F') =", norm(H, "F"), "\n\n")

# ----------------------------------------------------------------------------
# EXERCISES
# ----------------------------------------------------------------------------

cat("=== EXERCISES ===\n")
cat("1. Create a 4x4 matrix with numbers 1 to 16\n")
cat("2. Calculate the transpose of your matrix\n")
cat("3. Create two 2x2 matrices and multiply them\n")
cat("4. Find the determinant and inverse of a 3x3 matrix\n")
cat("5. Solve the system: 3x + 2y = 7, x - y = 1\n\n")

# Solutions (commented):
# ex1 <- matrix(1:16, nrow=4)
# ex2 <- t(ex1)
# m1 <- matrix(c(1,2,3,4), nrow=2); m2 <- matrix(c(5,6,7,8), nrow=2)
# result <- m1 %*% m2
# m3 <- matrix(c(1,0,2,2,1,0,0,1,1), nrow=3)
# det(m3); solve(m3)
# A <- matrix(c(3,1,2,-1), nrow=2, byrow=TRUE)
# b <- c(7,1)
# solve(A, b)
