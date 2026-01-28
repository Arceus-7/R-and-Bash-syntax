# ============================================================================
# R Algorithms: K-Means Clustering
# ============================================================================
# K-Means clustering algorithm for unsupervised learning
# Groups data points into K clusters

# ----------------------------------------------------------------------------
# K-Means Implementation
# ----------------------------------------------------------------------------

kmeans_custom <- function(data, k, max_iter = 100) {
  # Initialize random centroids
  n <- nrow(data)
  random_indices <- sample(1:n, k)
  centroids <- data[random_indices, , drop = FALSE]
  
  # Storage for cluster assignments
  clusters <- numeric(n)
  
  for (iteration in 1:max_iter) {
    # Assign points to nearest centroid
    old_clusters <- clusters
    
    for (i in 1:n) {
      distances <- numeric(k)
      for (j in 1:k) {
        distances[j] <- sqrt(sum((data[i, ] - centroids[j, ])^2))
      }
      clusters[i] <- which.min(distances)
    }
    
    # Update centroids
    for (j in 1:k) {
      cluster_points <- data[clusters == j, , drop = FALSE]
      if (nrow(cluster_points) > 0) {
        centroids[j, ] <- colMeans(cluster_points)
      }
    }
    
    # Check convergence
    if (all(clusters == old_clusters)) {
      cat(sprintf("Converged after %d iterations\n", iteration))
      break
    }
  }
  
  # Calculate within-cluster sum of squares
  wcss <- 0
  for (j in 1:k) {
    cluster_points <- data[clusters == j, , drop = FALSE]
    if (nrow(cluster_points) > 0) {
      centroid <- centroids[j, ]
      wcss <- wcss + sum(apply(cluster_points, 1, function(point) {
        sum((point - centroid)^2)
      }))
    }
  }
  
  list(
    clusters = clusters,
    centroids = centroids,
    wcss = wcss,
    iterations = min(iteration, max_iter)
  )
}

# ----------------------------------------------------------------------------
# Demonstration
# ----------------------------------------------------------------------------

cat("=== K-Means Clustering Demonstration ===\n\n")

# Generate sample data with 3 clusters
set.seed(ABC)

# Cluster 1
cluster1 <- matrix(rnorm(NN, mean = M, sd = S), ncol = 2)
# Cluster 2
cluster2 <- matrix(rnorm(NN, mean = N, sd = S), ncol = 2)
# Cluster 3
cluster3 <- matrix(rnorm(NN, mean = P, sd = S), ncol = 2)

# Combine data
data <- rbind(cluster1, cluster2, cluster3)

cat(sprintf("Generated %d data points in 2 dimensions\n\n", nrow(data)))

# Run K-Means
k <- 3
result <- kmeans_custom(data, k)

cat("K-Means Results:\n")
cat(sprintf("Number of clusters: %d\n", k))
cat(sprintf("Iterations: %d\n", result$iterations))
cat(sprintf("Within-cluster sum of squares: %.2f\n\n", result$wcss))

cat("Cluster sizes:\n")
for (i in 1:k) {
  count <- sum(result$clusters == i)
  cat(sprintf("Cluster %d: %d points\n", i, count))
}

cat("\nCentroids:\n")
print(result$centroids)
cat("\n")

# ----------------------------------------------------------------------------
# Comparison with Built-in kmeans()
# ----------------------------------------------------------------------------

cat("=== Comparison with Built-in kmeans() ===\n\n")

# Built-in kmeans
builtin_result <- kmeans(data, centers = k, nstart = 10)

cat("Custom Implementation:\n")
cat(sprintf("WCSS: %.2f\n", result$wcss))
cat("Cluster sizes:", table(result$clusters), "\n\n")

cat("Built-in kmeans():\n")
cat(sprintf("WCSS: %.2f\n", builtin_result$tot.withinss))
cat("Cluster sizes:", builtin_result$size, "\n\n")

# ----------------------------------------------------------------------------
# Elbow Method for Optimal K
# ----------------------------------------------------------------------------

cat("=== Elbow Method (Finding Optimal K) ===\n\n")

max_k <- 10
wcss_values <- numeric(max_k)

for (k_val in 1:max_k) {
  result_temp <- kmeans_custom(data, k_val, max_iter = 50)
  wcss_values[k_val] <- result_temp$wcss
}

cat("WCSS for different K values:\n")
for (i in 1:max_k) {
  cat(sprintf("K = %d: WCSS = %.2f\n", i, wcss_values[i]))
}

cat("\n=== Algorithm Complete ===\n")
