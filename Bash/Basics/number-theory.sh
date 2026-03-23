#!/bin/bash

# ============================================================================
# Number Theory and Numeric Operations
# ============================================================================

# ----------------------------------------------------------------------------
# 1. PERFECT NUMBER CHECKER
# ----------------------------------------------------------------------------
# A perfect number equals the sum of its proper divisors (e.g., 6 = 1+2+3)

is_perfect() {
    echo -n "Enter a number: "
    read no
    local div_sum=0
    for ((i = 1; i <= no / 2; i++)); do
        if [ $((no % i)) -eq 0 ]; then
            div_sum=$((div_sum + i))
        fi
    done
    if [ "$div_sum" -eq "$no" ]; then
        echo "$no is a perfect number"
    else
        echo "$no is not a perfect number (sum of divisors = $div_sum)"
    fi
}

# Find all perfect numbers up to a limit
perfect_numbers_upto() {
    local limit="${1:-1000}"
    echo "Perfect numbers up to $limit:"
    for ((n = 2; n <= limit; n++)); do
        local s=0
        for ((i = 1; i <= n / 2; i++)); do
            [ $((n % i)) -eq 0 ] && s=$((s + i))
        done
        [ "$s" -eq "$n" ] && echo -n "$n "
    done
    echo
}

# ----------------------------------------------------------------------------
# 2. REVERSE A NUMBER
# ----------------------------------------------------------------------------

reverse_number() {
    echo -n "Enter a number: "
    read n
    local original=$n
    local rev=0
    while [ "$n" -gt 0 ]; do
        local digit=$((n % 10))
        rev=$((rev * 10 + digit))
        n=$((n / 10))
    done
    echo "Reverse of $original = $rev"
    [ "$original" -eq "$rev" ] && echo "$original is a palindrome"
}

# ----------------------------------------------------------------------------
# 3. LARGEST AND SMALLEST FROM A FILE
# ----------------------------------------------------------------------------

largest_smallest_from_file() {
    local file="$1"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: largest_smallest_from_file <filename>"
        echo "(file should contain one number per line)"
        return 1
    fi
    local sorted
    sorted=$(sort -n "$file")
    local smallest
    smallest=$(echo "$sorted" | head -1)
    local largest
    largest=$(echo "$sorted" | tail -1)
    echo "Smallest: $smallest"
    echo "Largest: $largest"
}

# Interactive version
largest_smallest_interactive() {
    echo -n "How many numbers: "
    read count
    local -a nums=()
    for ((i = 1; i <= count; i++)); do
        echo -n "Enter number $i: "
        read val
        nums+=("$val")
    done

    local min=${nums[0]}
    local max=${nums[0]}
    for num in "${nums[@]}"; do
        [ "$num" -lt "$min" ] && min=$num
        [ "$num" -gt "$max" ] && max=$num
    done

    echo "Smallest: $min"
    echo "Largest: $max"
}

# ----------------------------------------------------------------------------
# 4. PRIME FACTORIZATION
# ----------------------------------------------------------------------------

prime_factors() {
    echo -n "Enter a number: "
    read n
    local original=$n
    echo -n "Prime factors of $n: "
    for ((i = 2; i * i <= n; i++)); do
        while [ $((n % i)) -eq 0 ]; do
            echo -n "$i "
            n=$((n / i))
        done
    done
    [ "$n" -gt 1 ] && echo -n "$n"
    echo
}

# ----------------------------------------------------------------------------
# 5. ARMSTRONG NUMBER CHECKER
# ----------------------------------------------------------------------------
# An Armstrong number equals the sum of its digits each raised to the power
# of the number of digits (e.g., 153 = 1^3 + 5^3 + 3^3)

is_armstrong() {
    echo -n "Enter a number: "
    read num
    local digits=${#num}
    local sum=0
    local temp=$num
    while [ "$temp" -gt 0 ]; do
        local digit=$((temp % 10))
        local power=1
        for ((i = 0; i < digits; i++)); do
            power=$((power * digit))
        done
        sum=$((sum + power))
        temp=$((temp / 10))
    done
    if [ "$sum" -eq "$num" ]; then
        echo "$num is an Armstrong number"
    else
        echo "$num is not an Armstrong number"
    fi
}

# List Armstrong numbers up to a limit
armstrong_upto() {
    local limit="${1:-1000}"
    echo "Armstrong numbers up to $limit:"
    for ((n = 1; n <= limit; n++)); do
        local digits=${#n}
        local sum=0
        local temp=$n
        while [ "$temp" -gt 0 ]; do
            local d=$((temp % 10))
            local p=1
            for ((i = 0; i < digits; i++)); do p=$((p * d)); done
            sum=$((sum + p))
            temp=$((temp / 10))
        done
        [ "$sum" -eq "$n" ] && echo -n "$n "
    done
    echo
}

# ----------------------------------------------------------------------------
# 6. DIGITAL ROOT
# ----------------------------------------------------------------------------
# Repeatedly sum digits until single digit (e.g., 9875 -> 29 -> 11 -> 2)

digital_root() {
    echo -n "Enter a number: "
    read num
    local original=$num
    local steps=0
    while [ ${#num} -gt 1 ]; do
        local sum=0
        local temp=$num
        while [ "$temp" -gt 0 ]; do
            sum=$((sum + temp % 10))
            temp=$((temp / 10))
        done
        num=$sum
        ((steps++))
    done
    echo "Digital root of $original = $num (in $steps step(s))"
}

# ----------------------------------------------------------------------------
# 7. NEON NUMBER CHECKER
# ----------------------------------------------------------------------------
# A neon number: square's digit sum equals the number (e.g., 9: 9^2=81, 8+1=9)

is_neon() {
    echo -n "Enter a number: "
    read num
    local sq=$((num * num))
    local sum=0
    local temp=$sq
    while [ "$temp" -gt 0 ]; do
        sum=$((sum + temp % 10))
        temp=$((temp / 10))
    done
    echo "$num squared = $sq, digit sum = $sum"
    if [ "$sum" -eq "$num" ]; then
        echo "$num is a neon number"
    else
        echo "$num is not a neon number"
    fi
}

echo "Number Theory Examples loaded."
echo "Functions: is_perfect, perfect_numbers_upto, reverse_number,"
echo "           largest_smallest_from_file, largest_smallest_interactive,"
echo "           prime_factors, is_armstrong, armstrong_upto,"
echo "           digital_root, is_neon"
