#!/bin/bash

# ============================================================================
# Advanced Text Processing
# ============================================================================

# ----------------------------------------------------------------------------
# 1. CSV PARSER AND FORMATTER
# ----------------------------------------------------------------------------

csv_to_table() {
    local file="$1"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: csv_to_table <csvfile>"
        return 1
    fi
    column -t -s',' "$file"
}

csv_extract_column() {
    local file="$1"
    local col="$2"
    if [ -z "$file" ] || [ -z "$col" ]; then
        echo "Usage: csv_extract_column <csvfile> <column_number>"
        return 1
    fi
    awk -F',' "{print \$$col}" "$file"
}

csv_filter_rows() {
    local file="$1"
    local col="$2"
    local value="$3"
    if [ $# -lt 3 ]; then
        echo "Usage: csv_filter_rows <csvfile> <column_number> <value>"
        return 1
    fi
    head -1 "$file"
    awk -F',' "\$$col == \"$value\"" "$file"
}

# ----------------------------------------------------------------------------
# 2. WORD FREQUENCY ANALYZER
# ----------------------------------------------------------------------------

word_frequency() {
    local file="$1"
    local top="${2:-20}"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: word_frequency <file> [top_n]"
        return 1
    fi

    echo "Top $top words in $file:"
    tr -cs '[:alpha:]' '\n' < "$file" | \
        tr '[:upper:]' '[:lower:]' | \
        sort | uniq -c | sort -rn | head -n "$top"
}

# ----------------------------------------------------------------------------
# 3. LOG FILE ANALYZER
# ----------------------------------------------------------------------------

log_analyzer() {
    local file="$1"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: log_analyzer <logfile>"
        return 1
    fi

    local total=$(wc -l < "$file")
    local errors=$(grep -ci "error" "$file")
    local warnings=$(grep -ci "warning" "$file")
    local info=$(grep -ci "info" "$file")

    echo "Log Analysis: $file"
    echo "  Total lines: $total"
    echo "  Errors: $errors"
    echo "  Warnings: $warnings"
    echo "  Info: $info"

    if [ "$errors" -gt 0 ]; then
        echo ""
        echo "Last 5 errors:"
        grep -i "error" "$file" | tail -5
    fi
}

# ----------------------------------------------------------------------------
# 4. MULTI-FILE SEARCH AND REPLACE WITH BACKUP
# ----------------------------------------------------------------------------

search_replace() {
    local search="$1"
    local replace="$2"
    shift 2

    if [ -z "$search" ] || [ -z "$replace" ] || [ $# -eq 0 ]; then
        echo "Usage: search_replace <search> <replace> <file1> [file2] ..."
        return 1
    fi

    for file in "$@"; do
        if [ -f "$file" ]; then
            local matches=$(grep -c "$search" "$file")
            if [ "$matches" -gt 0 ]; then
                cp "$file" "${file}.bak"
                sed -i "s/$search/$replace/g" "$file"
                echo "$file: $matches replacement(s), backup at ${file}.bak"
            fi
        fi
    done
}

# ----------------------------------------------------------------------------
# 5. TEXT STATISTICS
# ----------------------------------------------------------------------------

text_stats() {
    local file="$1"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: text_stats <file>"
        return 1
    fi

    local lines=$(wc -l < "$file")
    local words=$(wc -w < "$file")
    local chars=$(wc -c < "$file")
    local unique=$(tr -cs '[:alpha:]' '\n' < "$file" | tr '[:upper:]' '[:lower:]' | sort -u | wc -l)
    local sentences=$(grep -co '[.!?]' "$file" | paste -sd+ | bc)
    local paragraphs=$(grep -c '^$' "$file")

    echo "Text Statistics: $file"
    echo "  Lines: $lines"
    echo "  Words: $words"
    echo "  Characters: $chars"
    echo "  Unique words: $unique"
    echo "  Sentences: $sentences"
    echo "  Paragraphs: $((paragraphs + 1))"

    if [ "$sentences" -gt 0 ]; then
        local avg_words=$(echo "scale=1; $words / $sentences" | bc)
        echo "  Avg words/sentence: $avg_words"
    fi
}

# ----------------------------------------------------------------------------
# 6. PATTERN EXTRACTOR (emails, IPs, URLs)
# ----------------------------------------------------------------------------

extract_patterns() {
    local file="$1"
    local type="${2:-all}"
    if [ -z "$file" ] || [ ! -f "$file" ]; then
        echo "Usage: extract_patterns <file> [email|ip|url|all]"
        return 1
    fi

    case $type in
        email|all)
            echo "Emails found:"
            grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$file" | sort -u
            ;;&
        ip|all)
            echo "IP addresses found:"
            grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$file" | sort -u
            ;;&
        url|all)
            echo "URLs found:"
            grep -oE 'https?://[^ ]+' "$file" | sort -u
            ;;
    esac
}

echo "Advanced Text Processing loaded."
echo "Functions: csv_to_table, csv_extract_column, csv_filter_rows,"
echo "           word_frequency, log_analyzer, search_replace,"
echo "           text_stats, extract_patterns"
