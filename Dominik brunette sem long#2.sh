#!/bin/bash
LOG="$HOME/ProcessUsageReport-$(date +%F).log"
KILLED=0
ps -eo pid,user,lstart,%cpu,group --sort=%cpu | head -n 6 > /tmp/top5.txt
cat /tmp/top5.txt
echo "want to kill the processes ? yes or no?:"
read YN
if [ "$YN" != "yes" ]; then
echo "nothing happens"
exit
fi
while read LINE; do
PID=$(echo "$LINE" | awk '{print $1}')
USER=$(echo "$LINE" | awk '{print $2}')
LSTART=$(echo "$LINE" | awk '{print $3, $4, $5, $6, $7}')
GROUP=$(echo "$LINE" | awk '{print $9}') 
if [ "$PID" = "PID" ]; then
continue
fi
if [ "$USER" = "root" ]; then
continue
fi
kill -9 "$PID" 2>/dev/null
if [ $? -eq 0 ]; then
((KILLED++))
echo "$USER | $LSTART |$MONTH $DAY $TIME $YEAR | $(date) | $GROUP" >> "$LOG"
fi
done < /tmp/top5.txt
echo "$KILLED the process has been eraticated :))"

