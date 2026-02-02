# ============================================================================
# R Statistics: Analysis of Variance (ANOVA)
# ============================================================================
# One-way, two-way ANOVA, and post-hoc tests

# ----------------------------------------------------------------------------
# 1. ONE-WAY ANOVA
# ----------------------------------------------------------------------------

# Create sample data - test scores from three teaching methods
method_a <- c(85, 88, 90, 92, 87, 89)
method_b <- c(78, 82, 80, 85, 83, 81)
method_c <- c(92, 95, 93, 96, 94, 97)

# Combine into data frame
scores <- c(method_a, method_b, method_c)
methods <- factor(rep(c("A", "B", "C"), each = 6))
data_df <- data.frame(scores, methods)

# Perform one-way ANOVA
anova_result <- aov(scores ~ methods, data = data_df)
summary(anova_result)

# Extract F-statistic and p-value
anova_summary <- summary(anova_result)
f_stat <- anova_summary[[1]]$"F value"[1]
p_value <- anova_summary[[1]]$"Pr(>F)"[1]

cat("F-statistic:", f_stat, "\n")
cat("P-value:", p_value, "\n")
cat("Significant difference:", p_value < 0.05, "\n")

# Group means
cat("\nGroup means:\n")
print(tapply(scores, methods, mean))

# Group standard deviations
cat("\nGroup SDs:\n")
print(tapply(scores, methods, sd))

# ----------------------------------------------------------------------------
# 2. ASSUMPTIONS CHECKING
# ----------------------------------------------------------------------------

# Assumption 1: Normality (Shapiro-Wilk test for residuals)
residuals_anova <- residuals(anova_result)
shapiro_test <- shapiro.test(residuals_anova)
cat("\nNormality test p-value:", shapiro_test$p.value, "\n")
cat("Residuals are normal:", shapiro_test$p.value > 0.05, "\n")

# Assumption 2: Homogeneity of variances (Levene's test equivalent)
# Bartlett's test
bartlett_test <- bartlett.test(scores ~ methods, data = data_df)
cat("\nBartlett's test p-value:", bartlett_test$p.value, "\n")
cat("Equal variances:", bartlett_test$p.value > 0.05, "\n")

# Fligner-Killeen test (non-parametric alternative)
fligner_test <- fligner.test(scores ~ methods, data = data_df)
cat("Fligner test p-value:", fligner_test$p.value, "\n")

# ----------------------------------------------------------------------------
# 3. POST-HOC TESTS
# ----------------------------------------------------------------------------

# Tukey HSD (Honest Significant Difference)
tukey_result <- TukeyHSD(anova_result)
print(tukey_result)

# Pairwise t-tests with Bonferroni correction
pairwise_result <- pairwise.t.test(scores, methods, p.adjust.method = "bonferroni")
cat("\nPairwise comparisons (Bonferroni):\n")
print(pairwise_result)

# Effect size (eta-squared)
ss_between <- anova_summary[[1]]$"Sum Sq"[1]
ss_total <- sum(anova_summary[[1]]$"Sum Sq")
eta_squared <- ss_between / ss_total
cat("\nEta-squared (effect size):", eta_squared, "\n")

# ----------------------------------------------------------------------------
# 4. TWO-WAY ANOVA
# ----------------------------------------------------------------------------

# Create data with two factors
# Factor 1: Teaching method (A, B)
# Factor 2: Study time (Low, High)

scores_2way <- c(
    75, 78, 80, 82, 85, 88,
    80, 83, 85, 90, 92, 95
)
method_2way <- factor(rep(c("A", "B"), each = 6))
study_time <- factor(rep(rep(c("Low", "High"), each = 3), 2))

data_2way <- data.frame(
    scores = scores_2way,
    method = method_2way,
    study = study_time
)

# Perform two-way ANOVA
anova_2way <- aov(scores ~ method + study + method:study, data = data_2way)
summary(anova_2way)

# Interaction plot
interaction.plot(data_2way$study, data_2way$method, data_2way$scores,
    xlab = "Study Time", ylab = "Mean Score",
    trace.label = "Method"
)

# Main effects
cat("\nMain effect of method:\n")
print(tapply(scores_2way, method_2way, mean))

cat("\nMain effect of study time:\n")
print(tapply(scores_2way, study_time, mean))

# Cell means
cat("\nCell means:\n")
print(tapply(scores_2way, list(method_2way, study_time), mean))

# ----------------------------------------------------------------------------
# 5. REPEATED MEASURES ANOVA
# ----------------------------------------------------------------------------

# Create repeated measures data
subjects <- factor(rep(1:5, each = 3))
time_points <- factor(rep(c("T1", "T2", "T3"), 5))
measurements <- c(
    20, 22, 25, # Subject 1
    18, 20, 23, # Subject 2
    22, 24, 27, # Subject 3
    19, 21, 24, # Subject 4
    21, 23, 26
) # Subject 5

rm_data <- data.frame(
    subject = subjects,
    time = time_points,
    value = measurements
)

# Perform repeated measures ANOVA
rm_anova <- aov(value ~ time + Error(subject / time), data = rm_data)
summary(rm_anova)

# ----------------------------------------------------------------------------
# 6. KRUSKAL-WALLIS TEST (Non-parametric Alternative)
# ----------------------------------------------------------------------------

# When assumptions are violated
kruskal_result <- kruskal.test(scores ~ methods, data = data_df)
print(kruskal_result)

cat("Kruskal-Wallis p-value:", kruskal_result$p.value, "\n")

# Post-hoc for Kruskal-Wallis (pairwise Wilcoxon tests)
pairwise_wilcox <- pairwise.wilcox.test(scores, methods, p.adjust.method = "bonferroni")
print(pairwise_wilcox)

# ----------------------------------------------------------------------------
# 7. ANOVA TABLE INTERPRETATION
# ----------------------------------------------------------------------------

cat("\n=== ANOVA Table Components ===\n")
cat("df: Degrees of freedom\n")
cat("Sum Sq: Sum of squares\n")
cat("Mean Sq: Mean square (Sum Sq / df)\n")
cat("F value: F-statistic (MS between / MS within)\n")
cat("Pr(>F): P-value\n\n")

# Calculate components manually
k <- length(unique(methods)) # number of groups
n <- length(scores) # total observations

# Between-group variance
grand_mean <- mean(scores)
ss_between <- sum(tapply(scores, methods, function(x) {
    length(x) * (mean(x) - grand_mean)^2
}))

# Within-group variance
ss_within <- sum(tapply(scores, methods, function(x) {
    sum((x - mean(x))^2)
}))

# Total variance
ss_total <- sum((scores - grand_mean)^2)

df_between <- k - 1
df_within <- n - k
df_total <- n - 1

ms_between <- ss_between / df_between
ms_within <- ss_within / df_within

f_manual <- ms_between / ms_within
p_manual <- 1 - pf(f_manual, df_between, df_within)

cat("Manual calculation:\n")
cat("SS Between:", ss_between, "\n")
cat("SS Within:", ss_within, "\n")
cat("SS Total:", ss_total, "\n")
cat("F-statistic:", f_manual, "\n")
cat("P-value:", p_manual, "\n")

# ----------------------------------------------------------------------------
# 8. PRACTICAL EXAMPLES
# ----------------------------------------------------------------------------

# Example 1: Compare diet effectiveness
diet_a <- c(2.5, 3.0, 2.8, 3.2, 2.9, 3.1)
diet_b <- c(1.8, 2.0, 1.9, 2.2, 2.1, 2.3)
diet_c <- c(3.5, 3.8, 3.6, 4.0, 3.7, 3.9)

weight_loss <- c(diet_a, diet_b, diet_c)
diet <- factor(rep(c("Diet A", "Diet B", "Diet C"), each = 6))

diet_df <- data.frame(weight_loss, diet)
diet_anova <- aov(weight_loss ~ diet, data = diet_df)

cat("\n=== Diet Effectiveness Study ===\n")
print(summary(diet_anova))
cat("\nMean weight loss by diet:\n")
print(tapply(weight_loss, diet, mean))

diet_tukey <- TukeyHSD(diet_anova)
print(diet_tukey)

# Example 2: Training program comparison
control <- c(70, 72, 75, 73, 74)
training1 <- c(78, 80, 82, 79, 81)
training2 <- c(85, 87, 89, 86, 88)

performance <- c(control, training1, training2)
program <- factor(rep(c("Control", "Training1", "Training2"), each = 5))

training_df <- data.frame(performance, program)
training_anova <- aov(performance ~ program, data = training_df)

cat("\n=== Training Program Evaluation ===\n")
print(summary(training_anova))
cat("\nMean performance by program:\n")
print(tapply(performance, program, mean))

# Calculate effect size
anova_summ <- summary(training_anova)
eta_sq <- anova_summ[[1]]$"Sum Sq"[1] / sum(anova_summ[[1]]$"Sum Sq")
cat("Effect size (eta-squared):", eta_sq, "\n")

# Example 3: Two-way factorial design
# Factors: Gender (M/F) and Treatment (A/B)
scores_factorial <- c(75, 78, 80, 82, 85, 88, 92, 95)
gender <- factor(rep(c("M", "F"), each = 4))
treatment <- factor(rep(c("A", "B"), 4))

factorial_df <- data.frame(
    scores = scores_factorial,
    gender = gender,
    treatment = treatment
)

factorial_anova <- aov(scores ~ gender + treatment + gender:treatment,
    data = factorial_df
)

cat("\n=== Factorial ANOVA ===\n")
print(summary(factorial_anova))

cat("\nInteraction effects:\n")
print(tapply(scores_factorial, list(gender, treatment), mean))
