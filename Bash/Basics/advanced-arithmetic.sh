#!/bin/bash

# ============================================================================
# Advanced Arithmetic and Math Operations
# ============================================================================

# ----------------------------------------------------------------------------
# 1. COMPOUND INTEREST CALCULATOR
# ----------------------------------------------------------------------------
# Formula: A = P * (1 + r/n)^(n*t)

compound_interest() {
    echo -n "Principal amount: "
    read principal
    echo -n "Annual interest rate (%): "
    read rate
    echo -n "Number of times compounded per year: "
    read n
    echo -n "Number of years: "
    read time

    amount=$(echo "scale=2; $principal * (1 + $rate / (100 * $n)) ^ ($n * $time)" | bc -l)
    interest=$(echo "scale=2; $amount - $principal" | bc)

    echo "Amount: Rs.$amount"
    echo "Interest earned: Rs.$interest"
}

# ----------------------------------------------------------------------------
# 2. QUADRATIC EQUATION SOLVER (ax^2 + bx + c = 0)
# ----------------------------------------------------------------------------

quadratic_solver() {
    echo -n "Enter coefficient a: "
    read a
    echo -n "Enter coefficient b: "
    read b
    echo -n "Enter coefficient c: "
    read c

    if [ "$a" -eq 0 ]; then
        echo "Not a quadratic equation (a=0)"
        return 1
    fi

    discriminant=$(echo "scale=4; $b * $b - 4 * $a * $c" | bc)
    check=$(echo "$discriminant >= 0" | bc)

    if [ "$check" -eq 1 ]; then
        sqrt_d=$(echo "scale=4; sqrt($discriminant)" | bc -l)
        x1=$(echo "scale=4; (-$b + $sqrt_d) / (2 * $a)" | bc)
        x2=$(echo "scale=4; (-$b - $sqrt_d) / (2 * $a)" | bc)
        echo "Root 1: $x1"
        echo "Root 2: $x2"
    else
        real=$(echo "scale=4; -$b / (2 * $a)" | bc)
        imag=$(echo "scale=4; sqrt(-1 * $discriminant) / (2 * $a)" | bc -l)
        echo "Root 1: $real + ${imag}i"
        echo "Root 2: $real - ${imag}i"
    fi
}

# ----------------------------------------------------------------------------
# 3. UNIT CONVERTER
# ----------------------------------------------------------------------------

unit_converter() {
    echo "1) Celsius to Fahrenheit"
    echo "2) Fahrenheit to Celsius"
    echo "3) Kilometers to Miles"
    echo "4) Miles to Kilometers"
    echo "5) Kilograms to Pounds"
    echo "6) Pounds to Kilograms"
    echo -n "Choice: "
    read choice
    echo -n "Enter value: "
    read val

    case $choice in
        1) result=$(echo "scale=2; ($val * 9/5) + 32" | bc); echo "$val°C = ${result}°F" ;;
        2) result=$(echo "scale=2; ($val - 32) * 5/9" | bc); echo "$val°F = ${result}°C" ;;
        3) result=$(echo "scale=2; $val * 0.621371" | bc); echo "$val km = $result miles" ;;
        4) result=$(echo "scale=2; $val * 1.60934" | bc); echo "$val miles = $result km" ;;
        5) result=$(echo "scale=2; $val * 2.20462" | bc); echo "$val kg = $result lbs" ;;
        6) result=$(echo "scale=2; $val * 0.453592" | bc); echo "$val lbs = $result kg" ;;
        *) echo "Invalid choice" ;;
    esac
}

# ----------------------------------------------------------------------------
# 4. STATISTICAL CALCULATOR (mean, median, std dev)
# ----------------------------------------------------------------------------

statistics_calc() {
    echo -n "Enter numbers separated by spaces: "
    read -a nums
    n=${#nums[@]}

    if [ $n -eq 0 ]; then
        echo "No numbers provided"
        return 1
    fi

    # Mean
    sum=0
    for num in "${nums[@]}"; do
        sum=$(echo "$sum + $num" | bc)
    done
    mean=$(echo "scale=4; $sum / $n" | bc)
    echo "Mean: $mean"

    # Sort for median
    sorted=($(printf '%s\n' "${nums[@]}" | sort -n))
    if [ $((n % 2)) -eq 1 ]; then
        median=${sorted[$((n / 2))]}
    else
        mid1=${sorted[$((n / 2 - 1))]}
        mid2=${sorted[$((n / 2))]}
        median=$(echo "scale=4; ($mid1 + $mid2) / 2" | bc)
    fi
    echo "Median: $median"

    # Standard deviation
    sq_sum=0
    for num in "${nums[@]}"; do
        diff=$(echo "$num - $mean" | bc)
        sq_sum=$(echo "$sq_sum + $diff * $diff" | bc)
    done
    std_dev=$(echo "scale=4; sqrt($sq_sum / $n)" | bc -l)
    echo "Std Dev: $std_dev"
    echo "Min: ${sorted[0]}"
    echo "Max: ${sorted[$((n - 1))]}"
}

# ----------------------------------------------------------------------------
# 5. NUMBER BASE CONVERTER
# ----------------------------------------------------------------------------

base_converter() {
    echo -n "Enter a decimal number: "
    read num

    echo "Binary:  $(echo "obase=2; $num" | bc)"
    echo "Octal:   $(echo "obase=8; $num" | bc)"
    echo "Hex:     $(echo "obase=16; $num" | bc)"
}

# ----------------------------------------------------------------------------
# 6. LOAN EMI CALCULATOR
# ----------------------------------------------------------------------------
# EMI = P * r * (1+r)^n / ((1+r)^n - 1)

emi_calculator() {
    echo -n "Loan amount: "
    read principal
    echo -n "Annual interest rate (%): "
    read annual_rate
    echo -n "Loan tenure (months): "
    read months

    r=$(echo "scale=10; $annual_rate / (12 * 100)" | bc)
    power=$(echo "scale=10; (1 + $r) ^ $months" | bc -l)
    emi=$(echo "scale=2; $principal * $r * $power / ($power - 1)" | bc)
    total=$(echo "scale=2; $emi * $months" | bc)
    interest=$(echo "scale=2; $total - $principal" | bc)

    echo "Monthly EMI: Rs.$emi"
    echo "Total payment: Rs.$total"
    echo "Total interest: Rs.$interest"
}

echo "Advanced Arithmetic Examples loaded."
echo "Functions: compound_interest, quadratic_solver, unit_converter,"
echo "           statistics_calc, base_converter, emi_calculator"
