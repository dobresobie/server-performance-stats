#!/bin/bash

cpuUsage=$(top -bn2 | grep '%Cpu' | tail -n 1 | awk '{print 100 - $8}')
printf "Total CPU usage -> %s%%\n\n" "$cpuUsage"


ramTotal=$(free -m | tail -n +2 | grep Mem: | awk '{print $2}')
ramFree=$(free -m | tail -n +2 | grep Mem: | awk '{print $4}')
ramUsed=$(free -m | tail -n +2 | grep Mem: | awk '{print $3}')
ramUsage=$(echo "scale=2; $ramUsed * 100 / $ramTotal" | bc)

printf "Total memory usage\n"
printf "Free memory -> $ramFree MiB\n"
printf "Used memory -> $ramUsed MiB\n"
printf "Ram usage -> $ramUsage%%\n\n"

freeDisk=$(df -h / | awk 'NR==2 {print $4}')
usedDisk=$(df -h / | awk 'NR==2 {print $3}')
diskP=$(df -h / | awk 'NR==2 {print $5}')

printf "Total disk usage\n"
printf "Free disk usage -> $freeDisk\n"
printf "Used disk usage -> $usedDisk\n"
printf "Disk usage -> %s\n\n" "$diskP"


cpuTOP5=$(ps aux --sort=-%cpu | head -n 6 | awk '{print $2, $3, $11}')
printf "\nTOP 5 processes in CPU usage\n"
printf "%s\n" "$cpuTOP5"


memoryTOP5=$(ps aux --sort=-%mem | head -n 6 | awk '{print $2, $4, $11}')
printf "\nTOP 5 processes by memory usage\n"
printf "%s\n" "$memoryTOP5"


