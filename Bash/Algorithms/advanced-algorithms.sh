#!/bin/bash

# ============================================================================
# Advanced Algorithm Implementations
# ============================================================================

# ----------------------------------------------------------------------------
# 1. MERGE SORT
# ----------------------------------------------------------------------------

merge_sort() {
    local -a arr=("$@")
    local n=${#arr[@]}

    if [ $n -le 1 ]; then
        echo "${arr[@]}"
        return
    fi

    local mid=$((n / 2))
    local -a left=("${arr[@]:0:$mid}")
    local -a right=("${arr[@]:$mid}")

    local -a sorted_left=($(merge_sort "${left[@]}"))
    local -a sorted_right=($(merge_sort "${right[@]}"))

    # Merge
    local i=0 j=0
    local -a result=()
    while [ $i -lt ${#sorted_left[@]} ] && [ $j -lt ${#sorted_right[@]} ]; do
        if [ "${sorted_left[$i]}" -le "${sorted_right[$j]}" ]; then
            result+=("${sorted_left[$i]}")
            ((i++))
        else
            result+=("${sorted_right[$j]}")
            ((j++))
        fi
    done

    while [ $i -lt ${#sorted_left[@]} ]; do
        result+=("${sorted_left[$i]}")
        ((i++))
    done
    while [ $j -lt ${#sorted_right[@]} ]; do
        result+=("${sorted_right[$j]}")
        ((j++))
    done

    echo "${result[@]}"
}

merge_sort_demo() {
    echo -n "Enter numbers separated by spaces: "
    read -a nums
    echo "Original: ${nums[*]}"
    sorted=$(merge_sort "${nums[@]}")
    echo "Merge Sort: $sorted"
}

# ----------------------------------------------------------------------------
# 2. BINARY SEARCH
# ----------------------------------------------------------------------------

binary_search() {
    local -a arr=("$@")
    local target=${arr[-1]}
    unset 'arr[-1]'
    local low=0
    local high=$((${#arr[@]} - 1))

    while [ $low -le $high ]; do
        local mid=$(((low + high) / 2))
        if [ "${arr[$mid]}" -eq "$target" ]; then
            echo "Found $target at index $mid"
            return 0
        elif [ "${arr[$mid]}" -lt "$target" ]; then
            low=$((mid + 1))
        else
            high=$((mid - 1))
        fi
    done

    echo "$target not found"
    return 1
}

binary_search_demo() {
    local -a arr=(2 5 8 12 16 23 38 56 72 91)
    echo "Array: ${arr[*]}"
    echo -n "Enter number to search: "
    read target
    binary_search "${arr[@]}" "$target"
}

# ----------------------------------------------------------------------------
# 3. GCD AND LCM (Euclidean Algorithm)
# ----------------------------------------------------------------------------

gcd() {
    local a=$1 b=$2
    while [ $b -ne 0 ]; do
        local temp=$b
        b=$((a % b))
        a=$temp
    done
    echo $a
}

lcm() {
    local a=$1 b=$2
    local g=$(gcd $a $b)
    echo $((a * b / g))
}

gcd_lcm_demo() {
    echo -n "Enter two numbers: "
    read a b
    echo "GCD($a, $b) = $(gcd $a $b)"
    echo "LCM($a, $b) = $(lcm $a $b)"

    # Extended: GCD of multiple numbers
    echo -n "Enter multiple numbers for GCD: "
    read -a nums
    result=${nums[0]}
    for ((i = 1; i < ${#nums[@]}; i++)); do
        result=$(gcd $result ${nums[$i]})
    done
    echo "GCD of [${nums[*]}] = $result"
}

# ----------------------------------------------------------------------------
# 4. SIEVE OF ERATOSTHENES
# ----------------------------------------------------------------------------

sieve_of_eratosthenes() {
    local limit="${1:-100}"
    local -a is_prime=()

    # Initialize all as prime
    for ((i = 0; i <= limit; i++)); do
        is_prime[$i]=1
    done
    is_prime[0]=0
    is_prime[1]=0

    # Sieve
    for ((i = 2; i * i <= limit; i++)); do
        if [ ${is_prime[$i]} -eq 1 ]; then
            for ((j = i * i; j <= limit; j += i)); do
                is_prime[$j]=0
            done
        fi
    done

    # Collect primes
    local count=0
    echo "Primes up to $limit:"
    for ((i = 2; i <= limit; i++)); do
        if [ ${is_prime[$i]} -eq 1 ]; then
            echo -n "$i "
            ((count++))
        fi
    done
    echo ""
    echo "Total: $count primes"
}

# ----------------------------------------------------------------------------
# 5. TOWER OF HANOI
# ----------------------------------------------------------------------------

tower_of_hanoi() {
    local n=$1
    local from="${2:-A}"
    local to="${3:-C}"
    local aux="${4:-B}"

    if [ $n -eq 1 ]; then
        echo "Move disk 1 from $from to $to"
        return
    fi

    tower_of_hanoi $((n - 1)) "$from" "$aux" "$to"
    echo "Move disk $n from $from to $to"
    tower_of_hanoi $((n - 1)) "$aux" "$to" "$from"
}

hanoi_demo() {
    echo -n "Enter number of disks: "
    read n
    echo "Tower of Hanoi with $n disks:"
    tower_of_hanoi "$n"
    echo "Total moves: $(( (1 << n) - 1 ))"
}

# ----------------------------------------------------------------------------
# 6. MATRIX OPERATIONS
# ----------------------------------------------------------------------------

# Matrices stored as "rows cols val1 val2 ..."
matrix_multiply() {
    local r1=$1 c1=$2
    shift 2
    local -a m1=()
    for ((i = 0; i < r1 * c1; i++)); do
        m1+=("$1"); shift
    done

    local r2=$1 c2=$2
    shift 2
    local -a m2=()
    for ((i = 0; i < r2 * c2; i++)); do
        m2+=("$1"); shift
    done

    if [ "$c1" -ne "$r2" ]; then
        echo "Error: incompatible matrix dimensions"
        return 1
    fi

    echo "Result (${r1}x${c2}):"
    for ((i = 0; i < r1; i++)); do
        for ((j = 0; j < c2; j++)); do
            local sum=0
            for ((k = 0; k < c1; k++)); do
                local a=${m1[$((i * c1 + k))]}
                local b=${m2[$((k * c2 + j))]}
                sum=$((sum + a * b))
            done
            printf "%4d " $sum
        done
        echo
    done
}

matrix_demo() {
    echo "Matrix A (2x3):"
    echo "  1 2 3"
    echo "  4 5 6"
    echo "Matrix B (3x2):"
    echo "  7 8"
    echo "  9 10"
    echo "  11 12"
    echo ""
    matrix_multiply 2 3 1 2 3 4 5 6 3 2 7 8 9 10 11 12
}

# ----------------------------------------------------------------------------
# 7. INSERTION SORT WITH STEP TRACE
# ----------------------------------------------------------------------------

insertion_sort() {
    echo -n "Enter numbers separated by spaces: "
    read -a arr
    local n=${#arr[@]}

    echo "Original: ${arr[*]}"
    for ((i = 1; i < n; i++)); do
        key=${arr[$i]}
        j=$((i - 1))
        while [ $j -ge 0 ] && [ "${arr[$j]}" -gt "$key" ]; do
            arr[$((j + 1))]=${arr[$j]}
            ((j--))
        done
        arr[$((j + 1))]=$key
        echo "Step $i:    ${arr[*]}"
    done
    echo "Sorted:   ${arr[*]}"
}

echo "Advanced Algorithms loaded."
echo "Functions: merge_sort_demo, binary_search_demo, gcd_lcm_demo,"
echo "           sieve_of_eratosthenes, hanoi_demo, matrix_demo, insertion_sort"
