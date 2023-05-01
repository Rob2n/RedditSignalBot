#!/bin/bash -l
timestamp=`date -I"seconds"`
# Start the helper processes
service rsyslog start
cron
echo -e "$timestamp Signal-Cron started!"
python3 view.py