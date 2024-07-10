#!/bin/bash

# Calculate the hour one hour ago in UTC
previous_hour=$(TZ=UTC date -d '1 hour ago' +"%Y%m%d%H")
echo "Previous Hour in UTC: $previous_hour"

# Directory where the logs are stored
log_dir="./logs"

# Iterate over log files
find "$log_dir" -type f -name '*.log' | while read -r file; do
    # Extract timestamp from filename ensuring it is followed by '-access.log'
    timestamp=$(echo "$file" | sed -n 's/.*\([0-9]\{10\}\)-access\.log/\1/p')

    # Check if timestamp is less than or equal to previous hour
    if [[ $timestamp -le $previous_hour ]]; then
        # gzip the file
        gzip "$file"
        echo "File $file with timestamp $timestamp gzipped."
    fi
done
