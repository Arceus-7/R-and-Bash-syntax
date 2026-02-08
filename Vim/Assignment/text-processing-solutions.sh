#!/bin/bash

# Create the dataset file
cat > server.log << 'EOF'
2026-01-01 INFO User Rahul logged in from 192.168.1.10
2026-01-01 ERROR Disk space low
2026-01-01 WARNING CPU usage high
2026-01-02 INFO User Ankit logged in from 192.168.1.12
2026-01-02 ERROR Failed login attempt
2026-01-02 INFO Backup completed
2026-01-03 INFO User Rahul logged out
2026-01-03 ERROR Network timeout
2026-01-03 WARNING Memory usage high
2026-01-04 INFO User Meera logged in from 192.168.1.15
2026-01-04 INFO File uploaded
2026-01-04 ERROR Permission denied
EOF

# Q1. Show only ERROR lines
grep "ERROR" server.log

# Q2. Case-insensitive search for "warning"
grep -i "warning" server.log

# Q3. Count number of INFO entries
grep -c "INFO" server.log

# Q4. Display lines NOT containing INFO
grep -v "INFO" server.log

# Q5. Show lines where date is 2026-01-02
grep "2026-01-02" server.log

# Q6. Extract IP addresses only
grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' server.log

# Q7. Show first 5 lines
head -5 server.log

# Q8. Show last 3 lines
tail -3 server.log

# Q9. Continuously monitor file updates
# tail -f server.log

# Q10. Show lines from 3 to 8
head -8 server.log | tail -6

# Q11. Count ERROR occurrences
grep "ERROR" server.log | wc -l

# Q12. List unique users who logged in
grep "logged in" server.log | awk '{print $4}' | sort | uniq

# Q13. Show most frequent log type
awk '{print $2}' server.log | sort | uniq -c | sort -nr

# Q14. Display ERROR entries from last 7 lines only
tail -7 server.log | grep "ERROR"

# Q15. Lines starting with date
grep '^2026' server.log

# Q16. Lines ending with an IP
grep '[0-9]$' server.log

# Q17. Lines containing either ERROR or WARNING
grep -E "ERROR|WARNING" server.log

# Q18. Find lines where username is Rahul
grep "Rahul" server.log

# Q19. Find how many times each user appears
grep "User" server.log | awk '{print $4}' | sort | uniq -c

# Q20. Show last 5 ERROR/WARNING entries
grep -E "ERROR|WARNING" server.log | tail -5
