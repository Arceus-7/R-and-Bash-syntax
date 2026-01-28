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

# System: 2x + y = 5, x + 3y = 8
A_sys <- matrix(c(2, 1, 1, 3), nrow = 2, byrow = TRUE)
b_sys <- c(5, 8)
print(A_sys)
cat("b:", b_sys, "\n")
solution <- solve(A_sys, b_sys)
cat("Solution:", solution, "\n")
cat("Verification:", as.vector(A_sys %*% solution), "\n")

# ----------------------------------------------------------------------------
# 13. ADVANCED OPERATIONS
# ----------------------------------------------------------------------------

H <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
print(H)
cat("Rank:", qr(H)$rank, "\n")
cat("Trace:", sum(diag(H)), "\n")
cat("Frobenius norm:", norm(H, "F"), "\n")
