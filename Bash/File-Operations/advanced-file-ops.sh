#!/bin/bash

# ============================================================================
# Advanced File Operations
# ============================================================================

# ----------------------------------------------------------------------------
# 1. RECURSIVE DIRECTORY TREE WITH SIZES
# ----------------------------------------------------------------------------

dir_tree() {
    local dir="${1:-.}"
    local prefix="${2:-}"
    local entries=("$dir"/*)

    for entry in "${entries[@]}"; do
        [ ! -e "$entry" ] && continue
        local name=$(basename "$entry")
        if [ -d "$entry" ]; then
            local size=$(du -sh "$entry" 2>/dev/null | cut -f1)
            echo "${prefix}├── $name/ ($size)"
            dir_tree "$entry" "${prefix}│   "
        else
            local size=$(du -sh "$entry" 2>/dev/null | cut -f1)
            echo "${prefix}├── $name ($size)"
        fi
    done
}

# ----------------------------------------------------------------------------
# 2. DUPLICATE FILE FINDER (by MD5 checksum)
# ----------------------------------------------------------------------------

find_duplicates() {
    local dir="${1:-.}"
    echo "Scanning $dir for duplicates..."

    declare -A checksums
    local dupes=0

    while IFS= read -r -d '' file; do
        hash=$(md5sum "$file" 2>/dev/null | cut -d' ' -f1)
        if [ -n "${checksums[$hash]}" ]; then
            echo "Duplicate: $file"
            echo "  Original: ${checksums[$hash]}"
            ((dupes++))
        else
            checksums[$hash]="$file"
        fi
    done < <(find "$dir" -type f -print0)

    echo "Found $dupes duplicate(s)"
}

# ----------------------------------------------------------------------------
# 3. LOG FILE ROTATOR
# ----------------------------------------------------------------------------
# Rotates logs: app.log -> app.log.1 -> app.log.2 -> ... (keeps max N)

rotate_logs() {
    local logfile="$1"
    local max_rotations="${2:-5}"

    if [ -z "$logfile" ]; then
        echo "Usage: rotate_logs <logfile> [max_rotations]"
        return 1
    fi

    # Remove oldest
    [ -f "${logfile}.${max_rotations}" ] && rm "${logfile}.${max_rotations}"

    # Shift existing rotations
    for ((i = max_rotations - 1; i >= 1; i--)); do
        [ -f "${logfile}.${i}" ] && mv "${logfile}.${i}" "${logfile}.$((i + 1))"
    done

    # Rotate current
    [ -f "$logfile" ] && mv "$logfile" "${logfile}.1"
    touch "$logfile"

    echo "Rotated $logfile (keeping last $max_rotations)"
}

# ----------------------------------------------------------------------------
# 4. FILE INTEGRITY CHECKER
# ----------------------------------------------------------------------------
# Generate or verify checksums for files in a directory

integrity_check() {
    local dir="${1:-.}"
    local checksum_file="${dir}/.checksums"
    local action="${2:-generate}"

    if [ "$action" = "generate" ]; then
        find "$dir" -maxdepth 1 -type f ! -name ".checksums" -exec md5sum {} \; > "$checksum_file"
        echo "Generated checksums for $(wc -l < "$checksum_file") files"
    elif [ "$action" = "verify" ]; then
        if [ ! -f "$checksum_file" ]; then
            echo "No checksum file found. Run with 'generate' first."
            return 1
        fi
        if md5sum -c "$checksum_file" --quiet 2>/dev/null; then
            echo "All files OK"
        else
            echo "Some files have been modified!"
            md5sum -c "$checksum_file" 2>/dev/null | grep -v ": OK"
        fi
    fi
}

# ----------------------------------------------------------------------------
# 5. BULK FILE ORGANIZER BY EXTENSION
# ----------------------------------------------------------------------------

organize_by_extension() {
    local dir="${1:-.}"
    local moved=0

    for file in "$dir"/*; do
        [ -f "$file" ] || continue
        ext="${file##*.}"
        [ "$ext" = "$file" ] && ext="no_extension"
        ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

        mkdir -p "$dir/$ext"
        mv "$file" "$dir/$ext/"
        ((moved++))
    done

    echo "Organized $moved files by extension"
}

# ----------------------------------------------------------------------------
# 6. SAFE BATCH RENAME
# ----------------------------------------------------------------------------

batch_rename() {
    local dir="${1:-.}"
    local pattern="$2"
    local replacement="$3"

    if [ -z "$pattern" ] || [ -z "$replacement" ]; then
        echo "Usage: batch_rename <dir> <pattern> <replacement>"
        return 1
    fi

    local count=0
    for file in "$dir"/*"$pattern"*; do
        [ -f "$file" ] || continue
        local base=$(basename "$file")
        local newname="${base//$pattern/$replacement}"
        echo "  $base -> $newname"
        mv "$file" "$dir/$newname"
        ((count++))
    done

    echo "Renamed $count files"
}

echo "Advanced File Operations loaded."
echo "Functions: dir_tree, find_duplicates, rotate_logs,"
echo "           integrity_check, organize_by_extension, batch_rename"
