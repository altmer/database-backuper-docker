#!/bin/bash

while true
do
    backup perform -t database -c /Backup/config.rb
    echo "Sleeping before next backup..."
    sleep 12h
done
