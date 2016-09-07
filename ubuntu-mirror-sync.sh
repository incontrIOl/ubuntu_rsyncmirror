#!/bin/bash

## Log File
log=/var/log/ubuntu-mirror-sync.log

## Mirror Server
remote=rsync://archive.ubuntu.com/ubuntu

## Local mirror directory
local=/mirror/

pid=$$


echo "`date +%x-%R` - $pid - Running rsync" >> $log
rsync -a --delete-after $remote $local >> $log
echo "`date +%x-%R` - $pid - Finished Ubuntu Mirror Sync" >> $log


exit 0