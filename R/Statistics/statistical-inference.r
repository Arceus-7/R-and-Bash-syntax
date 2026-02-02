# ============================================================================
# R Statistics: Statistical Inference
# ============================================================================
# Confidence intervals, hypothesis testing, and statistical conclusions

# ----------------------------------------------------------------------------
# 1. CONFIDENCE INTERVALS
# ----------------------------------------------------------------------------

# Sample data
sample_data <- c(23, 25, 27, 29, 31, 33, 35, 37, 39, 41)

# Confidence interval for mean (t-distribution)
conf_level <- 0.95
n <- length(sample_data)
mean_val <- mean(sample_data)
se <- sd(sample_data) / sqrt(n)
t_val <- qt((1 + conf_level) / 2, df = n - 1)

ci_lower <- mean_val - t_val * se
ci_upper <- mean_val + t_val * se

cat("95% CI for mean: [", ci_lower, ",", ci_upper, "]\n")

# Using built-in t.test for CI
ci_result <- t.test(sample_data)$conf.int
cat("CI using t.test():", ci_result, "\n")

# Confidence interval for proportion
successes <- 65
trials <- 100
prop <- successes / trials

# Normal approximation
z_val <- qnorm((1 + conf_level) / 2)
se_prop <- sqrt(prop * (1 - prop) / trials)
ci_prop_lower <- prop - z_val * se_prop
ci_prop_upper <- prop + z_val * se_prop

cat("95% CI for proportion: [", ci_prop_lower, ",", ci_prop_upper, "]\n")

# ----------------------------------------------------------------------------
# 2. ONE-SAMPLE T-TEST
# ----------------------------------------------------------------------------

# Test if mean equals hypothesized value
data <- c(25, 28, 30, 32, 35, 38, 40, 42, 45, 48)
mu_0 <- 35 # Hypothesized mean

# Perform t-test
result <- t.test(data, mu = mu_0)
print(result)

cat("t-statistic:", result$statistic, "\n")
cat("p-value:", result$p.value, "\n")
cat("Conclusion:", ifelse(result$p.value < 0.05,
    "Reject null hypothesis",
    "Fail to reject null hypothesis"
), "\n")

# One-sided test (greater)
result_greater <- t.test(data, mu = mu_0, alternative = "greater")
cat("One-sided (greater) p-value:", result_greater$p.value, "\n")

# One-sided test (less)
result_less <- t.test(data, mu = mu_0, alternative = "less")
cat("One-sided (less) p-value:", result_less$p.value, "\n")

# ----------------------------------------------------------------------------
# 3. TWO-SAMPLE T-TEST
# ----------------------------------------------------------------------------

# Two independent samples
group1 <- c(23, 25, 27, 29, 31, 33)
group2 <- c(30, 32, 35, 38, 40, 42)

# Two-sample t-test (Welch's test - unequal variances)
result_two_sample <- t.test(group1, group2)
print(result_two_sample)

# Equal variance t-test
result_pooled <- t.test(group1, group2, var.equal = TRUE)
print(result_pooled)

# Paired t-test
before <- c(120, 125, 130, 128, 135, 140)
after <- c(115, 120, 125, 122, 130, 135)

result_paired <- t.test(before, after, paired = TRUE)
print(result_paired)

cat("Mean difference:", mean(before - after), "\n")
cat("Paired t-test p-value:", result_paired$p.value, "\n")

# ----------------------------------------------------------------------------
# 4. Z-TEST (Large Sample)
# ----------------------------------------------------------------------------

# Manual z-test for known population SD
sample_mean <- 52
pop_mean <- 50
pop_sd <- 10
n <- 100

z_stat <- (sample_mean - pop_mean) / (pop_sd / sqrt(n))
p_value <- 2 * (1 - pnorm(abs(z_stat)))

cat("Z-statistic:", z_stat, "\n")
cat("P-value:", p_value, "\n")

# ----------------------------------------------------------------------------
# 5. CHI-SQUARE TEST
# ----------------------------------------------------------------------------

# Chi-square goodness of fit
observed <- c(25, 30, 20, 25)
expected_prop <- c(0.25, 0.25, 0.25, 0.25)

chisq_result <- chisq.test(observed, p = expected_prop)
print(chisq_result)

# Chi-square test of independence
data_matrix <- matrix(c(20, 30, 25, 15, 30, 20), nrow = 2)
rownames(data_matrix) <- c("Group A", "Group B")
colnames(data_matrix) <- c("Cat1", "Cat2", "Cat3")

chisq_indep <- chisq.test(data_matrix)
print(chisq_indep)
cat("Expected frequencies:\n")
print(chisq_indep$expected)

# ----------------------------------------------------------------------------
# 6. PROPORTION TESTS
# ----------------------------------------------------------------------------

# One-sample proportion test
prop.test(x = 65, n = 100, p = 0.5)

# Two-sample proportion test
group1_success <- 45
group1_total <- 100
group2_success <- 60
group2_total <- 120

prop_test_result <- prop.test(
    c(group1_success, group2_success),
    c(group1_total, group2_total)
)
print(prop_test_result)

# ----------------------------------------------------------------------------
# 7. F-TEST (Variance Comparison)
# ----------------------------------------------------------------------------

# Test equality of variances
sample1 <- c(10, 12, 15, 18, 20)
sample2 <- c(8, 10, 12, 14, 16, 18, 20)

var_test <- var.test(sample1, sample2)
print(var_test)

cat("F-statistic:", var_test$statistic, "\n")
cat("P-value:", var_test$p.value, "\n")

# ----------------------------------------------------------------------------
# 8. POWER ANALYSIS
# ----------------------------------------------------------------------------

# Calculate required sample size for t-test
effect_size <- 0.5 # Cohen's d
alpha <- 0.05
power <- 0.80

# Manual calculation for two-sample t-test
z_alpha <- qnorm(1 - alpha / 2)
z_beta <- qnorm(power)
n_required <- 2 * ((z_alpha + z_beta) / effect_size)^2

cat("Required sample size per group:", ceiling(n_required), "\n")

# Calculate power for given sample size
n_actual <- 30
ncp <- effect_size * sqrt(n_actual / 2)
power_actual <- 1 - pt(qt(1 - alpha / 2, df = 2 * n_actual - 2),
    df = 2 * n_actual - 2, ncp = ncp
)
cat("Power with n=30:", power_actual, "\n")

# ----------------------------------------------------------------------------
# 9. TYPE I AND TYPE II ERRORS
# ----------------------------------------------------------------------------

cat("\n=== Error Types ===\n")
cat("Type I error (α): Rejecting true null hypothesis\n")
cat("Type II error (β): Failing to reject false null hypothesis\n")
cat("Power (1-β): Probability of correctly rejecting false null\n\n")

# Simulation of Type I error
set.seed(42)
simulations <- 1000
alpha <- 0.05
type_i_count <- 0

for (i in 1:simulations) {
    # Sample from null distribution (H0 is true)
    sample <- rnorm(30, mean = 0, sd = 1)
    p_value <- t.test(sample, mu = 0)$p.value
    if (p_value < alpha) {
        type_i_count <- type_i_count + 1
    }
}

cat("Type I error rate (should be ~0.05):", type_i_count / simulations, "\n")

# ----------------------------------------------------------------------------
# 10. NON-PARAMETRIC TESTS
# ----------------------------------------------------------------------------

# Wilcoxon signed-rank test (paired samples)
before <- c(5.2, 5.5, 5.8, 6.0, 6.2)
after <- c(4.8, 5.0, 5.2, 5.5, 5.8)

wilcox_result <- wilcox.test(before, after, paired = TRUE)
print(wilcox_result)

# Mann-Whitney U test (two independent samples)
group_x <- c(12, 15, 18, 20, 22)
group_y <- c(8, 10, 12, 14, 16)

mann_whitney <- wilcox.test(group_x, group_y)
print(mann_whitney)

# Kruskal-Wallis test (multiple groups)
values <- c(10, 12, 14, 15, 18, 20, 22, 25, 28, 30)
groups <- factor(c(1, 1, 1, 2, 2, 2, 3, 3, 3, 3))

kruskal_result <- kruskal.test(values ~ groups)
print(kruskal_result)

# ----------------------------------------------------------------------------
# 11. NORMALITY TESTS
# ----------------------------------------------------------------------------

# Shapiro-Wilk test
test_data <- rnorm(50, mean = 100, sd = 15)

shapiro_result <- shapiro.test(test_data)
cat("Shapiro-Wilk p-value:", shapiro_result$p.value, "\n")
cat("Data is normal:", shapiro_result$p.value > 0.05, "\n")

# Kolmogorov-Smirnov test
ks_result <- ks.test(test_data, "pnorm", mean(test_data), sd(test_data))
cat("KS test p-value:", ks_result$p.value, "\n")

# ----------------------------------------------------------------------------
# 12. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Quality control
# Test if product weight differs from specification
weights <- c(100.2, 99.8, 100.5, 99.9, 100.1, 100.3, 99.7, 100.4)
spec_weight <- 100

qc_test <- t.test(weights, mu = spec_weight)
cat("\n=== Quality Control Test ===\n")
cat("Mean weight:", mean(weights), "\n")
cat("P-value:", qc_test$p.value, "\n")
cat("Conclusion:", ifelse(qc_test$p.value < 0.05,
    "Weight differs from spec",
    "Weight meets spec"
), "\n")

# Example 2: A/B testing
# Compare conversion rates
variant_a_conversions <- 120
variant_a_visitors <- 1000
variant_b_conversions <- 150
variant_b_visitors <- 1000

ab_test <- prop.test(
    c(variant_a_conversions, variant_b_conversions),
    c(variant_a_visitors, variant_b_visitors)
)
cat("\n=== A/B Test Results ===\n")
cat("Variant A rate:", variant_a_conversions / variant_a_visitors, "\n")
cat("Variant B rate:", variant_b_conversions / variant_b_visitors, "\n")
cat("P-value:", ab_test$p.value, "\n")
cat("Significant difference:", ab_test$p.value < 0.05, "\n")

# Example 3: Before-after study
scores_before <- c(65, 70, 72, 75, 78, 80)
scores_after <- c(70, 75, 78, 80, 82, 85)

improvement_test <- t.test(scores_after, scores_before,
    paired = TRUE,
    alternative = "greater"
)
cat("\n=== Training Effectiveness ===\n")
cat("Mean before:", mean(scores_before), "\n")
cat("Mean after:", mean(scores_after), "\n")
cat("Mean improvement:", mean(scores_after - scores_before), "\n")
cat("P-value:", improvement_test$p.value, "\n")
cat("Training effective:", improvement_test$p.value < 0.05, "\n")
