#!/bin/bash

# 1. Login to the system
# ssh username@hostname

# 2. Find out the users who are currently logged in
who
who | grep "username"

# 3. Display the calendar
cal 1 2026        # (i) Jan 2026
cal 2 1999        # (ii) Feb 1999
cal 9 7           # (iii) 9th month of year 7 A.D
cal               # (iv) Current month
date +"%a, %b %Y" # (v) Current date with abbreviations

# 4. Display time in 12-Hour and 24-Hour format
date +"%I:%M:%S %p"  # 12-Hour
date +"%H:%M:%S"     # 24-Hour

# 5. Display current date and time
date

# 6. Display "GOOD MORNING" in enlarged characters
# banner GOOD MORNING
# figlet GOOD MORNING

# 7. Display home directory name
echo $HOME

# 8. Create directory SAMPLE under home
mkdir ~/SAMPLE

# 9. Create sub-directory TRIAL under SAMPLE
mkdir ~/SAMPLE/TRIAL

# 10. Change to SAMPLE
cd ~/SAMPLE
pwd

# 11. Change to home directory
cd ~
pwd

# 12. Change to TRIAL using absolute pathname
cd ~/SAMPLE/TRIAL
pwd

# Change to TRIAL using relative pathname (from home)
cd ~
cd SAMPLE/TRIAL
pwd

# 13. Remove directory TRIAL
cd ~/SAMPLE
rmdir TRIAL

# 14. Create directory TEST using absolute pathname
mkdir ~/TEST

# 15. Change to home using single command
cd
pwd

# 16. Remove directory using absolute pathname
rmdir ~/TEST

# 17. Create files myfile and yourfile
cd ~/SAMPLE
touch myfile yourfile

# 18. Display files myfile and yourfile
cat myfile
cat yourfile

# 19. Append lines to files
echo "This is line 1 in myfile" >> myfile
echo "This is line 2 in myfile" >> myfile
echo "This is line 1 in yourfile" >> yourfile
echo "This is line 2 in yourfile" >> yourfile

# 20. Create a hidden file
touch .hiddenfile
ls -la | grep .hiddenfile

# 21. Copy myfile to emp
cp myfile emp

# 22. Create alias
alias ll='ls -la'

# 23. Move yourfile to dept
mv yourfile dept

# 24. Copy emp and dept to TRIAL
mkdir -p ~/SAMPLE/TRIAL
cp emp dept ~/SAMPLE/TRIAL/

# 25. Compare a file with itself
cmp myfile myfile

# 26. Compare myfile and emp
cmp myfile emp

# 27. Append lines to emp in TRIAL
echo "Additional line 1 in emp" >> ~/SAMPLE/TRIAL/emp
echo "Additional line 2 in emp" >> ~/SAMPLE/TRIAL/emp

# 28. Compare emp files
cmp emp ~/SAMPLE/TRIAL/emp

# 29. Find difference between files
diff emp ~/SAMPLE/TRIAL/emp

# 30. Remove files in TRIAL directory
rm ~/SAMPLE/TRIAL/*

# 31. Remove directory with files using single command
mkdir -p ~/SAMPLE/TESTDIR
touch ~/SAMPLE/TESTDIR/file1 ~/SAMPLE/TESTDIR/file2
rm -r ~/SAMPLE/TESTDIR

# 32. Get back deleted file
# No standard Linux command to recover deleted files
# Use backups, recovery tools (extundelete, testdisk), or version control

# 33. Rename TRIAL as DATA
mv ~/SAMPLE/TRIAL ~/SAMPLE/DATA

# 34. Copy DATA to TRIAL
cp -r ~/SAMPLE/DATA ~/SAMPLE/TRIAL

# 35. Create dummy file and link to star
touch ~/SAMPLE/TRIAL/dummy
echo "Dummy file content" > ~/SAMPLE/TRIAL/dummy
ln ~/SAMPLE/TRIAL/dummy ~/SAMPLE/TRIAL/star
ls -li ~/SAMPLE/TRIAL/dummy ~/SAMPLE/TRIAL/star
