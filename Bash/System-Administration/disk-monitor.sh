#!/bin/bash

# ============================================================================
# System Administration: Disk Usage Monitor
# ============================================================================
# Monitor disk usage and alert if threshold is exceeded

echo "=== Disk Usage Monitor ==="
echo

# Configuration
THRESHOLD=NN  # Alert if usage exceeds this percentage
EMAIL="abc@xyz.com"  # Email for alerts (not actually sent in demo)

# ----------------------------------------------------------------------------
# Check disk usage
# ----------------------------------------------------------------------------

echo "Checking disk usage..."
echo

# Get disk usage for all mounted filesystems
df -h | grep -v "Filesystem" | while read line; do
    # Extract fields
    filesystem=$(echo $line | awk '{print $1}')
    size=$(echo $line | awk '{print $2}')
    used=$(echo $line | awk '{print $3}')
    avail=$(echo $line | awk '{print $4}')
    percent=$(echo $line | awk '{print $5}' | sed 's/%//')
    mount=$(echo $line | awk '{print $6}')
    
    echo "Filesystem: $filesystem"
    echo "  Mounted on: $mount"
    echo "  Size: $size"
    echo "  Used: $used ($percent%)"
    echo "  Available: $avail"
    
    # Check if usage exceeds threshold
    if (( percent > THRESHOLD )); then
        echo "  ⚠️  WARNING: Usage exceeds ${THRESHOLD}% threshold!"
        # In production, send email:
        # echo "Disk usage on $mount is at $percent%" | mail -s "Disk Alert" $EMAIL
    else
        echo "  ✓ OK"
    fi
    echo
done

# ----------------------------------------------------------------------------
# Find large files
# ----------------------------------------------------------------------------

echo "=== Top 10 Largest Files in Home Directory ==="
echo

# Find and display large files (requires Unix-like find command)
if command -v find &> /dev/null; then
    find ~ -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10
else
    echo "find command not available on this system"
fi

echo
echo "=== Monitoring Complete ==="
echo
echo "Useful commands:"
echo "  df -h                     - Disk free space"
echo "  du -sh /path/*            - Disk usage by directory"
echo "  ncdu                      - Interactive disk usage analyzer"
echo "  df -i                      - Inode usage"
