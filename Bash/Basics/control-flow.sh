#!/bin/bash

# ============================================================================
# Control Flow Examples
# ============================================================================

# ----------------------------------------------------------------------------
# 1. TIME-BASED GREETING
# ----------------------------------------------------------------------------
# Reads the current hour and greets accordingly

time_greeting() {
    local hour
    hour=$(date +%H)

    if [ "$hour" -lt 12 ]; then
        echo "Good morning $LOGNAME, have a nice day!"
    elif [ "$hour" -ge 12 ] && [ "$hour" -le 16 ]; then
        echo "Good afternoon $LOGNAME"
    elif [ "$hour" -gt 16 ] && [ "$hour" -le 18 ]; then
        echo "Good evening $LOGNAME"
    else
        echo "Good night $LOGNAME"
    fi
}

# ----------------------------------------------------------------------------
# 2. STRING COMPARISON
# ----------------------------------------------------------------------------

compare_strings() {
    echo -n "Enter first string: "
    read str1
    echo -n "Enter second string: "
    read str2

    if [ "$str1" = "$str2" ]; then
        echo "Strings are equal"
    else
        echo "Strings are not equal"
        echo "Length of '$str1': ${#str1}"
        echo "Length of '$str2': ${#str2}"
        if [ "${#str1}" -gt "${#str2}" ]; then
            echo "'$str1' is longer"
        elif [ "${#str1}" -lt "${#str2}" ]; then
            echo "'$str2' is longer"
        fi
    fi
}

# ----------------------------------------------------------------------------
# 3. MULTIPLICATION TABLE (from command-line argument)
# ----------------------------------------------------------------------------

multiplication_table() {
    local n="${1}"
    if [ -z "$n" ]; then
        echo -n "Enter number: "
        read n
    fi
    for i in 1 2 3 4 5 6 7 8 9 10; do
        echo "$n x $i = $((n * i))"
    done
}

# ----------------------------------------------------------------------------
# 4. ODD/EVEN IN A LIST OF NUMBERS
# ----------------------------------------------------------------------------

odd_even_list() {
    echo -n "How many numbers: "
    read lim
    local -a nums=()

    for ((i = 1; i <= lim; i++)); do
        echo -n "Enter number $i: "
        read val
        nums+=("$val")
    done

    echo ""
    echo "Classification:"
    for num in "${nums[@]}"; do
        if [ $((num % 2)) -eq 0 ]; then
            echo "  $num - even"
        else
            echo "  $num - odd"
        fi
    done
}

# ----------------------------------------------------------------------------
# 5. CASE STATEMENT DEMO: Day name from number
# ----------------------------------------------------------------------------

day_name() {
    echo -n "Enter day number (1-7): "
    read d
    case $d in
        1) echo "Monday" ;;
        2) echo "Tuesday" ;;
        3) echo "Wednesday" ;;
        4) echo "Thursday" ;;
        5) echo "Friday" ;;
        6) echo "Saturday" ;;
        7) echo "Sunday" ;;
        *) echo "Invalid day number" ;;
    esac
}

# ----------------------------------------------------------------------------
# 6. FOR LOOP PATTERNS
# ----------------------------------------------------------------------------

loop_patterns() {
    echo "C-style for loop:"
    for ((i = 1; i <= 5; i++)); do
        echo -n "$i "
    done
    echo

    echo "Range loop:"
    for i in {1..5}; do
        echo -n "$i "
    done
    echo

    echo "Step loop (even numbers 2-10):"
    for i in {2..10..2}; do
        echo -n "$i "
    done
    echo

    echo "Reverse loop:"
    for ((i = 5; i >= 1; i--)); do
        echo -n "$i "
    done
    echo
}

# ----------------------------------------------------------------------------
# 7. NESTED LOOP: Pattern printing
# ----------------------------------------------------------------------------

print_triangle() {
    echo -n "Enter number of rows: "
    read rows
    for ((i = 1; i <= rows; i++)); do
        for ((j = 1; j <= i; j++)); do
            echo -n "* "
        done
        echo
    done
}

echo "Control Flow Examples loaded."
echo "Functions: time_greeting, compare_strings, multiplication_table,"
echo "           odd_even_list, day_name, loop_patterns, print_triangle"
