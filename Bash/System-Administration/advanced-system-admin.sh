#!/bin/bash

# ============================================================================
# Advanced System Administration
# ============================================================================

# ----------------------------------------------------------------------------
# 1. SYSTEM HEALTH DASHBOARD
# ----------------------------------------------------------------------------

system_health() {
    echo "=== System Health ==="

    # Uptime
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"

    # CPU load
    echo "Load Average: $(cat /proc/loadavg 2>/dev/null | cut -d' ' -f1-3)"

    # Memory
    echo ""
    echo "Memory:"
    free -h 2>/dev/null | awk 'NR==2{printf "  Used: %s / %s (%.1f%%)\n", $3, $2, $3/$2*100}'

    # Disk
    echo ""
    echo "Disk Usage:"
    df -h / 2>/dev/null | awk 'NR==2{printf "  Root: %s / %s (%s used)\n", $3, $2, $5}'

    # Top processes by CPU
    echo ""
    echo "Top 5 CPU processes:"
    ps aux --sort=-%cpu 2>/dev/null | head -6 | awk 'NR>1{printf "  %-20s CPU:%-6s MEM:%-6s\n", $11, $3"%", $4"%"}'
}

# ----------------------------------------------------------------------------
# 2. AUTOMATED BACKUP WITH ROTATION
# ----------------------------------------------------------------------------

backup_with_rotation() {
    local source_dir="$1"
    local backup_dir="$2"
    local max_backups="${3:-7}"

    if [ -z "$source_dir" ] || [ -z "$backup_dir" ]; then
        echo "Usage: backup_with_rotation <source_dir> <backup_dir> [max_backups]"
        return 1
    fi

    mkdir -p "$backup_dir"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_name="backup_${timestamp}.tar.gz"

    tar -czf "$backup_dir/$backup_name" -C "$(dirname "$source_dir")" "$(basename "$source_dir")" 2>/dev/null
    echo "Created: $backup_name"

    # Remove old backups beyond max
    local count=$(ls -1 "$backup_dir"/backup_*.tar.gz 2>/dev/null | wc -l)
    if [ "$count" -gt "$max_backups" ]; then
        local to_remove=$((count - max_backups))
        ls -1t "$backup_dir"/backup_*.tar.gz | tail -n "$to_remove" | xargs rm -f
        echo "Removed $to_remove old backup(s)"
    fi

    echo "Total backups: $(ls -1 "$backup_dir"/backup_*.tar.gz 2>/dev/null | wc -l)/$max_backups"
}

# ----------------------------------------------------------------------------
# 3. NETWORK CONNECTIVITY MONITOR
# ----------------------------------------------------------------------------

network_monitor() {
    local hosts=("${@:-google.com 8.8.8.8 1.1.1.1}")
    if [ $# -eq 0 ]; then
        hosts=("google.com" "8.8.8.8" "1.1.1.1")
    fi

    echo "Network Connectivity Check:"
    for host in "${hosts[@]}"; do
        if ping -c 1 -W 2 "$host" >/dev/null 2>&1; then
            local latency=$(ping -c 1 -W 2 "$host" 2>/dev/null | grep 'time=' | sed 's/.*time=\([^ ]*\).*/\1/')
            echo "  $host: OK (${latency}ms)"
        else
            echo "  $host: UNREACHABLE"
        fi
    done

    # DNS check
    echo ""
    echo "DNS Resolution:"
    for domain in "google.com" "github.com"; do
        if nslookup "$domain" >/dev/null 2>&1; then
            local ip=$(nslookup "$domain" 2>/dev/null | awk '/^Address:/{a=$2} END{print a}')
            echo "  $domain -> $ip"
        else
            echo "  $domain -> FAILED"
        fi
    done
}

# ----------------------------------------------------------------------------
# 4. SERVICE STATUS CHECKER
# ----------------------------------------------------------------------------

service_check() {
    local services=("$@")
    if [ ${#services[@]} -eq 0 ]; then
        services=("sshd" "cron" "nginx" "apache2" "mysql" "docker")
    fi

    echo "Service Status:"
    for svc in "${services[@]}"; do
        if systemctl is-active "$svc" >/dev/null 2>&1; then
            echo "  $svc: RUNNING"
        elif command -v "$svc" >/dev/null 2>&1; then
            echo "  $svc: INSTALLED (not running)"
        else
            echo "  $svc: NOT FOUND"
        fi
    done
}

# ----------------------------------------------------------------------------
# 5. USER ACCOUNT AUDIT
# ----------------------------------------------------------------------------

user_audit() {
    echo "User Account Audit"
    echo ""

    # System users vs regular users
    local total=$(wc -l < /etc/passwd)
    local regular=$(awk -F: '$3 >= 1000 && $3 < 65534' /etc/passwd | wc -l)
    local system=$((total - regular))

    echo "  Total accounts: $total"
    echo "  Regular users: $regular"
    echo "  System accounts: $system"

    echo ""
    echo "Regular users:"
    awk -F: '$3 >= 1000 && $3 < 65534 {printf "  %-15s UID:%-6s Home:%s\n", $1, $3, $6}' /etc/passwd

    echo ""
    echo "Currently logged in:"
    who | awk '{printf "  %-15s Terminal:%-8s Since:%s %s\n", $1, $2, $3, $4}'

    echo ""
    echo "Users with login shell:"
    grep -v '/nologin\|/false' /etc/passwd | awk -F: '{printf "  %-15s Shell:%s\n", $1, $7}'
}

# ----------------------------------------------------------------------------
# 6. DISK SPACE ALERTER
# ----------------------------------------------------------------------------

disk_alert() {
    local threshold="${1:-80}"

    echo "Disk Space Alert (threshold: ${threshold}%)"
    echo ""

    local alert=0
    while read -r line; do
        local usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
        local mount=$(echo "$line" | awk '{print $6}')
        local size=$(echo "$line" | awk '{print $2}')
        local used=$(echo "$line" | awk '{print $3}')

        if [ "$usage" -ge "$threshold" ]; then
            echo "  WARNING: $mount at ${usage}% ($used / $size)"
            alert=1
        else
            echo "  OK: $mount at ${usage}% ($used / $size)"
        fi
    done < <(df -h --output=source,size,used,avail,pcent,target 2>/dev/null | tail -n +2 | grep '^/dev')

    [ $alert -eq 0 ] && echo "  All partitions under ${threshold}%"
}

echo "Advanced System Administration loaded."
echo "Functions: system_health, backup_with_rotation, network_monitor,"
echo "           service_check, user_audit, disk_alert"
