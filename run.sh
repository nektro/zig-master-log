#!/usr/bin/env bash

set -eu

while true
do
    latest_server=$(curl -s https://ziglang.org/download/index.json | jq -r '.master.version')
    latest_known=$(cat masters_log.txt | tail -n1)

    if [ "$latest_server" != "$latest_known" ]
    then
        echo $latest_server >> masters_log.txt
        git add masters_log.txt
        git commit -m "Automatic update"
        git fetch
        git pull --rebase
        git push origin
    fi

    sleep 1h
done
