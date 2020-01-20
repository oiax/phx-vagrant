#!/bin/bash
set -eu

PATTERN='/(_build|deps|node_modules|priv/static|.+\.log)(/|$)'

while true; do
  inotifywait -qq -e create -r /work/ --exclude $PATTERN
  TIME0=$(date --date="-1 second" -Iseconds)

  sleep 1

  while true; do
    [[ ! -n $(find /work/ -newermt '-1 second') ]] && break
    sleep 1
  done

  cd /work

  find . -newermt $TIME0 | grep -v -E $PATTERN | \
    rsync -lptgo --files-from=- /work/ /vagrant/
done
