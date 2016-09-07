#!/bin/bash

# Install in:
# /usr/local/bin/ubuntu-mirror-sync.sh


## Log File
log=/var/log/ubuntu-mirror-sync.log

## Mirror Server
remote=rsync://archive.ubuntu.com/ubuntu

## Local mirroe directory
local=/media/mirror/ubuntu

## Initialize some other variables
complete="false"
failures=0
status=1
pid=$$

echo "`date +%x-%R` - $pid - Started Ubuntu Mirror Sync" >> $log
while [[ "$complete" != "true" ]]; do

        if [[ $failures -gt 0 ]]; then
                ## Sleep for 5 minutes for sanity's sake
                ## The most common reason for a failure at this point
                ##  is that the rsync server is handling too many concurrent connections.
                sleep 5m
        fi

        if [[ $1 == "debug" ]]; then
                echo "Working on attempt number $failures"
                rsync -a --delete-after --progress $remote $local
                status=$?
        else
                echo "`date +%x-%R` - $pid - Running rsync" >> $log
                rsync -a --delete-after $remote $local >> $log
                status=$?
        fi
        
        if [[ $status -ne "0" ]]; then
                complete="false"
                (( failures += 1 ))
        else
                echo "`date +%x-%R` - $pid - Finished Ubuntu Mirror Sync" >> $log
echo "`date +%x-%R` - $pid - Script completed." >> $log

exit 0
