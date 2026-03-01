#!/bin/bash

# ============================================================================
# UNIX Shell Script Assignment Solutions
# ============================================================================

# ----------------------------------------------------------------------------
# Q1. Odd or Even Number
# ----------------------------------------------------------------------------

q1_odd_even() {
    echo -n "Enter an integer: "
    read num
    if [ $((num % 2)) -eq 0 ]; then
        echo "$num is even"
    else
        echo "$num is odd"
    fi
}

# ----------------------------------------------------------------------------
# Q2. Leap Year Checker
# ----------------------------------------------------------------------------

q2_leap_year() {
    year=$1
    if [ -z "$year" ]; then
        echo "Usage: q2_leap_year <year>"
        return 1
    fi
    if [ $((year % 400)) -eq 0 ]; then
        echo "$year is a leap year"
    elif [ $((year % 100)) -eq 0 ]; then
        echo "$year is not a leap year"
    elif [ $((year % 4)) -eq 0 ]; then
        echo "$year is a leap year"
    else
        echo "$year is not a leap year"
    fi
}

# ----------------------------------------------------------------------------
# Q3. Profit or Loss Calculator
# ----------------------------------------------------------------------------

q3_profit_loss() {
    echo -n "Enter cost price: "
    read cp
    echo -n "Enter selling price: "
    read sp
    if [ "$sp" -gt "$cp" ]; then
        profit=$((sp - cp))
        echo "Profit of Rs.$profit"
    elif [ "$cp" -gt "$sp" ]; then
        loss=$((cp - sp))
        echo "Loss of Rs.$loss"
    else
        echo "No profit, no loss"
    fi
}

# ----------------------------------------------------------------------------
# Q4. Compare Two Files and Delete Second if Same
# ----------------------------------------------------------------------------

q4_compare_files() {
    if [ $# -ne 2 ]; then
        echo "Usage: q4_compare_files <file1> <file2>"
        return 1
    fi
    if [ ! -f "$1" ] || [ ! -f "$2" ]; then
        echo "Both arguments must be valid files"
        return 1
    fi
    if cmp -s "$1" "$2"; then
        echo "Files are identical. Deleting $2"
        rm "$2"
    else
        echo "Files are different"
    fi
}

# ----------------------------------------------------------------------------
# Q5. Menu Driven Program
# ----------------------------------------------------------------------------

q5_menu() {
    while true; do
        echo "1) Contents of /etc/passwd"
        echo "2) List of currently logged in users"
        echo "3) Present working directory"
        echo "4) Exit"
        echo -n "Enter choice: "
        read choice
        case $choice in
            1) cat /etc/passwd ;;
            2) who ;;
            3) pwd ;;
            4) break ;;
            *) echo "Invalid choice" ;;
        esac
        echo
    done
}

# ----------------------------------------------------------------------------
# Q6. Sum of Digits of a Five-Digit Number
# ----------------------------------------------------------------------------

q6_sum_of_digits() {
    echo -n "Enter a five-digit number: "
    read num
    sum=0
    temp=$num
    while [ $temp -gt 0 ]; do
        digit=$((temp % 10))
        sum=$((sum + digit))
        temp=$((temp / 10))
    done
    echo "Sum of digits of $num = $sum"
}

# ----------------------------------------------------------------------------
# Q7. Rectangle and Circle Calculations
# ----------------------------------------------------------------------------

q7_rect_circle() {
    echo -n "Enter length of rectangle: "
    read length
    echo -n "Enter breadth of rectangle: "
    read breadth
    echo -n "Enter radius of circle: "
    read radius

    rect_area=$((length * breadth))
    rect_peri=$((2 * (length + breadth)))

    echo "Rectangle area = $rect_area"
    echo "Rectangle perimeter = $rect_peri"

    # Use bc for floating-point circle calculations
    circle_area=$(echo "scale=2; 3.14159 * $radius * $radius" | bc)
    circle_circum=$(echo "scale=2; 2 * 3.14159 * $radius" | bc)

    echo "Circle area = $circle_area"
    echo "Circle circumference = $circle_circum"
}

# ----------------------------------------------------------------------------
# Q8. Gross Salary Calculator
# ----------------------------------------------------------------------------

q8_salary() {
    echo -n "Enter basic salary: "
    read basic

    da=$(echo "scale=2; $basic * 0.40" | bc)
    hra=$(echo "scale=2; $basic * 0.20" | bc)
    gross=$(echo "scale=2; $basic + $da + $hra" | bc)

    echo "Basic Salary: $basic"
    echo "Dearness Allowance (40%): $da"
    echo "House Rent Allowance (20%): $hra"
    echo "Gross Salary: $gross"
}

# ----------------------------------------------------------------------------
# Q9. Check if Friend Has Logged In (until loop)
# ----------------------------------------------------------------------------

q9_friend_login() {
    if [ -z "$1" ]; then
        echo "Usage: q9_friend_login <logname>"
        return 1
    fi
    logname=$1
    until who | grep -q "$logname"; do
        echo "$logname is not logged in. Checking again in 60 seconds..."
        sleep 60
    done
    echo "$logname has logged in!"
}

# ----------------------------------------------------------------------------
# Q10. Prime Numbers from 1 to 300
# ----------------------------------------------------------------------------

q10_primes() {
    echo "Prime numbers from 1 to 300:"
    for ((num = 2; num <= 300; num++)); do
        is_prime=1
        for ((i = 2; i * i <= num; i++)); do
            if [ $((num % i)) -eq 0 ]; then
                is_prime=0
                break
            fi
        done
        if [ $is_prime -eq 1 ]; then
            echo -n "$num "
        fi
    done
    echo
}

# ----------------------------------------------------------------------------
# Q11. All Combinations of 1, 2, and 3
# ----------------------------------------------------------------------------

q11_combinations() {
    echo "All combinations of 1, 2, and 3:"
    for i in 1 2 3; do
        for j in 1 2 3; do
            for k in 1 2 3; do
                echo "$i $j $k"
            done
        done
    done
}

# ----------------------------------------------------------------------------
# Q12. Delete Lines Containing "unix"
# ----------------------------------------------------------------------------

q12_delete_unix_lines() {
    if [ $# -eq 0 ]; then
        echo "Usage: q12_delete_unix_lines <file1> [file2] ..."
        return 1
    fi
    for file in "$@"; do
        if [ -f "$file" ]; then
            sed -i '/unix/d' "$file"
            echo "Removed lines containing 'unix' from $file"
        else
            echo "$file: not a valid file"
        fi
    done
}

# ----------------------------------------------------------------------------
# Q13. List Files with Read, Write, and Execute Permissions
# ----------------------------------------------------------------------------

q13_file_permissions() {
    echo "Files with read, write, and execute permissions:"
    for file in *; do
        if [ -r "$file" ] && [ -w "$file" ] && [ -x "$file" ]; then
            echo "$file"
        fi
    done
}

# ----------------------------------------------------------------------------
# Q14. Check if Arguments are Files or Directories
# ----------------------------------------------------------------------------

q14_file_or_dir() {
    if [ $# -eq 0 ]; then
        echo "Usage: q14_file_or_dir <name1> [name2] ..."
        return 1
    fi
    for arg in "$@"; do
        if [ -d "$arg" ]; then
            echo "$arg: directory"
        elif [ -f "$arg" ]; then
            lines=$(wc -l < "$arg")
            echo "$arg: file ($lines lines)"
        else
            echo "$arg: not found"
        fi
    done
}

# ----------------------------------------------------------------------------
# Q15. Overtime Pay Calculator (10 employees, Rs.12/hr above 40hrs)
# ----------------------------------------------------------------------------

q15_overtime() {
    for ((emp = 1; emp <= 10; emp++)); do
        echo -n "Employee $emp - Enter hours worked: "
        read hours
        if [ "$hours" -gt 40 ]; then
            overtime=$((hours - 40))
            pay=$((overtime * 12))
            echo "  Overtime: $overtime hrs, Pay: Rs.$pay"
        else
            echo "  No overtime"
        fi
    done
}

# ----------------------------------------------------------------------------
# Q16. Factorial
# ----------------------------------------------------------------------------

q16_factorial() {
    echo -n "Enter a number: "
    read num
    fact=1
    for ((i = 1; i <= num; i++)); do
        fact=$((fact * i))
    done
    echo "Factorial of $num = $fact"
}

# ----------------------------------------------------------------------------
# Q17. Power of a Number
# ----------------------------------------------------------------------------

q17_power() {
    echo -n "Enter base: "
    read base
    echo -n "Enter exponent: "
    read exp
    result=1
    for ((i = 0; i < exp; i++)); do
        result=$((result * base))
    done
    echo "$base ^ $exp = $result"
}

# ----------------------------------------------------------------------------
# Q18. Desktop Calculator (+, -, *, /)
# ----------------------------------------------------------------------------

q18_calculator() {
    echo -n "Enter first number: "
    read a
    echo -n "Enter operator (+, -, *, /): "
    read op
    echo -n "Enter second number: "
    read b
    case $op in
        +) result=$((a + b)) ;;
        -) result=$((a - b)) ;;
        \*) result=$((a * b)) ;;
        /) 
            if [ "$b" -eq 0 ]; then
                echo "Error: division by zero"
                return 1
            fi
            result=$(echo "scale=2; $a / $b" | bc)
            ;;
        *) echo "Invalid operator"; return 1 ;;
    esac
    echo "$a $op $b = $result"
}

# ----------------------------------------------------------------------------
# Q19. Age-Based Status
# ----------------------------------------------------------------------------

q19_age_status() {
    echo -n "Enter age: "
    read age
    if [ "$age" -lt 6 ]; then
        echo "Status: infant"
    elif [ "$age" -ge 6 ] && [ "$age" -lt 12 ]; then
        echo "Status: child"
    elif [ "$age" -ge 12 ] && [ "$age" -lt 18 ]; then
        echo "Status: adolescent"
    elif [ "$age" -ge 18 ] && [ "$age" -lt 38 ]; then
        echo "Status: youth"
    elif [ "$age" -ge 38 ] && [ "$age" -lt 58 ]; then
        echo "Status: grown up"
    else
        echo "Status: old"
    fi
}

# ----------------------------------------------------------------------------
# Q20. Edit, Compile, and Execute a C Program
# ----------------------------------------------------------------------------

q20_c_program() {
    echo -n "Enter C filename (without .c): "
    read fname
    vi "${fname}.c"
    echo "Compiling ${fname}.c ..."
    gcc "${fname}.c" -o "$fname"
    if [ $? -eq 0 ]; then
        echo "Compilation successful. Running..."
        ./"$fname"
    else
        echo "Compilation failed"
    fi
}

# ----------------------------------------------------------------------------
# Q21. Bubble Sort and Selection Sort
# ----------------------------------------------------------------------------

q21_sorts() {
    echo -n "Enter numbers separated by spaces: "
    read -a arr

    # Bubble Sort
    bubble=("${arr[@]}")
    n=${#bubble[@]}
    for ((i = 0; i < n - 1; i++)); do
        for ((j = 0; j < n - i - 1; j++)); do
            if [ "${bubble[$j]}" -gt "${bubble[$((j + 1))]}" ]; then
                temp=${bubble[$j]}
                bubble[$j]=${bubble[$((j + 1))]}
                bubble[$((j + 1))]=$temp
            fi
        done
    done
    echo "Bubble Sort: ${bubble[*]}"

    # Selection Sort
    sel=("${arr[@]}")
    n=${#sel[@]}
    for ((i = 0; i < n - 1; i++)); do
        min=$i
        for ((j = i + 1; j < n; j++)); do
            if [ "${sel[$j]}" -lt "${sel[$min]}" ]; then
                min=$j
            fi
        done
        temp=${sel[$i]}
        sel[$i]=${sel[$min]}
        sel[$min]=$temp
    done
    echo "Selection Sort: ${sel[*]}"
}

# ----------------------------------------------------------------------------
# Q22. Fibonacci Sequence
# ----------------------------------------------------------------------------

q22_fibonacci() {
    echo -n "Enter number of terms: "
    read n
    a=0
    b=1
    echo -n "Fibonacci: $a"
    for ((i = 1; i < n; i++)); do
        echo -n " $b"
        temp=$((a + b))
        a=$b
        b=$temp
    done
    echo
}