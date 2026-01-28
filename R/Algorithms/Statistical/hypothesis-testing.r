# ============================================================================
# R Algorithms: Hypothesis Testing
# ============================================================================
# Statistical hypothesis testing implementations

cat("=== Statistical Hypothesis Testing ===\n\n")

# ----------------------------------------------------------------------------
# T-Test Implementation
# ----------------------------------------------------------------------------

# One-sample t-test
one_sample_t_test <- function(data, mu0, alpha = 0.05) {
  n <- length(data)
  x_bar <- mean(data)
  s <- sd(data)
  
  # Calculate t-statistic
  t_stat <- (x_bar - mu0) / (s / sqrt(n))
  
  # Degrees of freedom
  df <- n - 1
  
  # Critical values (two-tailed)
  t_critical <- qt(1 - alpha/2, df)
  
  # P-value (two-tailed)
  p_value <- 2 * pt(-abs(t_stat), df)
  
  # Confidence interval
  margin_error <- t_critical * (s / sqrt(n))
  ci_lower <- x_bar - margin_error
  ci_upper <- x_bar + margin_error
  
  list(
    statistic = t_stat,
    p_value = p_value,
    critical_value = t_critical,
    df = df,
    mean = x_bar,
    null_hypothesis = mu0,
    ci_lower = ci_lower,
    ci_upper = ci_upper,
    reject = abs(t_stat) > t_critical
  )
}

# Two-sample t-test (equal variance)
two_sample_t_test <- function(data1, data2, alpha = 0.05) {
  n1 <- length(data1)
  n2 <- length(data2)
  x1_bar <- mean(data1)
  x2_bar <- mean(data2)
  s1 <- sd(data1)
  s2 <- sd(data2)
  
  # Pooled variance
  sp_squared <- ((n1 - 1) * s1^2 + (n2 - 1) * s2^2) / (n1 + n2 - 2)
  sp <- sqrt(sp_squared)
  
  # T-statistic
  t_stat <- (x1_bar - x2_bar) / (sp * sqrt(1/n1 + 1/n2))
  
  # Degrees of freedom
  df <- n1 + n2 - 2
  
  # Critical value (two-tailed)
  t_critical <- qt(1 - alpha/2, df)
  
  # P-value (two-tailed)
  p_value <- 2 * pt(-abs(t_stat), df)
  
  list(
    statistic = t_stat,
    p_value = p_value,
    critical_value = t_critical,
    df = df,
    mean1 = x1_bar,
    mean2 = x2_bar,
    pooled_sd = sp,
    reject = abs(t_stat) > t_critical
  )
}

# ----------------------------------------------------------------------------
# Chi-Square Test for Independence
# ----------------------------------------------------------------------------

chi_square_test <- function(observed_matrix) {
  row_totals <- rowSums(observed_matrix)
  col_totals <- colSums(observed_matrix)
  total <- sum(observed_matrix)
  
  # Calculate expected frequencies
  expected <- outer(row_totals, col_totals) / total
  
  # Chi-square statistic
  chi_sq <- sum((observed_matrix - expected)^2 / expected)
  
  # Degrees of freedom
  df <- (nrow(observed_matrix) - 1) * (ncol(observed_matrix) - 1)
  
  # P-value
  p_value <- 1 - pchisq(chi_sq, df)
  
  # Critical value (alpha = 0.05)
  critical_value <- qchisq(0.95, df)
  
  list(
    statistic = chi_sq,
    df = df,
    p_value = p_value,
    critical_value = critical_value,
    expected = expected,
    reject = chi_sq > critical_value
  )
}

# ----------------------------------------------------------------------------
# Demonstration: One-Sample T-Test
# ----------------------------------------------------------------------------

cat("=== One-Sample T-Test ===\n\n")

# Sample data
set.seed(NNN)
sample_data <- rnorm(NN, mean = MM, sd = S)

cat("Sample data statistics:\n")
cat(sprintf("Sample size: %d\n", length(sample_data)))
cat(sprintf("Sample mean: %.4f\n", mean(sample_data)))
cat(sprintf("Sample SD: %.4f\n\n", sd(sample_data)))

# Test if mean equals hypothesized value
mu0 <- NN
cat(sprintf("Null hypothesis: Population mean = %.1f\n", mu0))
cat("Alternative hypothesis: Population mean ≠ %.1f\n\n", mu0)

result1 <- one_sample_t_test(sample_data, mu0)

cat("Test Results:\n")
cat(sprintf("T-statistic: %.4f\n", result1$statistic))
cat(sprintf("P-value: %.4f\n", result1$p_value))
cat(sprintf("Critical value: %.4f\n", result1$critical_value))
cat(sprintf("Degrees of freedom: %d\n", result1$df))
cat(sprintf("NN%% Confidence Interval: [%.4f, %.4f]\n", 
    result1$ci_lower, result1$ci_upper))
cat(sprintf("Decision: %s null hypothesis\n\n", 
    ifelse(result1$reject, "Reject", "Fail to reject")))

# ----------------------------------------------------------------------------
# Demonstration: Two-Sample T-Test
# ----------------------------------------------------------------------------

cat("=== Two-Sample T-Test ===\n\n")

# Two groups
set.seed(MMM)
group1 <- rnorm(NN, mean = M1, sd = S1)
group2 <- rnorm(NN, mean = M2, sd = S2)

cat("Group statistics:\n")
cat(sprintf("Group 1: n=%d, mean=%.4f, sd=%.4f\n", 
    length(group1), mean(group1), sd(group1)))
cat(sprintf("Group 2: n=%d, mean=%.4f, sd=%.4f\n\n", 
    length(group2), mean(group2), sd(group2)))

cat("Null hypothesis: Mean1 = Mean2\n")
cat("Alternative hypothesis: Mean1 ≠ Mean2\n\n")

result2 <- two_sample_t_test(group1, group2)

cat("Test Results:\n")
cat(sprintf("T-statistic: %.4f\n", result2$statistic))
cat(sprintf("P-value: %.4f\n", result2$p_value))
cat(sprintf("Critical value: %.4f\n", result2$critical_value))
cat(sprintf("Degrees of freedom: %d\n", result2$df))
cat(sprintf("Pooled SD: %.4f\n", result2$pooled_sd))
cat(sprintf("Decision: %s null hypothesis\n\n", 
    ifelse(result2$reject, "Reject", "Fail to reject")))

# ----------------------------------------------------------------------------
# Demonstration: Chi-Square Test
# ----------------------------------------------------------------------------

cat("=== Chi-Square Test for Independence ===\n\n")

# Contingency table
observed <- matrix(c(NN, MM, PP,
                     QQ, RR, SS), 
                   nrow = 2, byrow = TRUE)

rownames(observed) <- c("Category A", "Category B")
colnames(observed) <- c("Group X", "Group Y", "Group Z")

cat("Observed frequencies:\n")
print(observed)
cat("\n")

cat("Null hypothesis: Variables are independent\n")
cat("Alternative hypothesis: Variables are not independent\n\n")

result3 <- chi_square_test(observed)

cat("Expected frequencies:\n")
print(round(result3$expected, 2))
cat("\n")

cat("Test Results:\n")
cat(sprintf("Chi-square statistic: %.4f\n", result3$statistic))
cat(sprintf("P-value: %.4f\n", result3$p_value))
cat(sprintf("Critical value: %.4f\n", result3$critical_value))
cat(sprintf("Degrees of freedom: %d\n", result3$df))
cat(sprintf("Decision: %s null hypothesis\n\n", 
    ifelse(result3$reject, "Reject", "Fail to reject")))

# ----------------------------------------------------------------------------
# Comparison with Built-in Functions
# ----------------------------------------------------------------------------

cat("=== Comparison with Built-in Functions ===\n\n")

# One-sample t-test
builtin1 <- t.test(sample_data, mu = mu0)
cat("One-Sample T-Test:\n")
cat(sprintf("Custom: t=%.4f, p=%.4f\n", 
    result1$statistic, result1$p_value))
cat(sprintf("Built-in: t=%.4f, p=%.4f\n\n", 
    builtin1$statistic, builtin1$p.value))

# Two-sample t-test
builtin2 <- t.test(group1, group2, var.equal = TRUE)
cat("Two-Sample T-Test:\n")
cat(sprintf("Custom: t=%.4f, p=%.4f\n", 
    result2$statistic, result2$p_value))
cat(sprintf("Built-in: t=%.4f, p=%.4f\n\n", 
    builtin2$statistic, builtin2$p.value))

# Chi-square test
builtin3 <- chisq.test(observed)
cat("Chi-Square Test:\n")
cat(sprintf("Custom: χ²=%.4f, p=%.4f\n", 
    result3$statistic, result3$p_value))
cat(sprintf("Built-in: χ²=%.4f, p=%.4f\n\n", 
    builtin3$statistic, builtin3$p.value))

cat("=== Algorithm Complete ===\n")
