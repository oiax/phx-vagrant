#!/bin/bash
set -eu

while true; do
  rsync -au --exclude 'node_modules/' --exclude '_build/' --exclude 'deps/' \
    --exclude 'priv/static/' --exclude '.git/' --exclude '*.log' \
    /vagrant/ /work/
  rsync -au --exclude 'node_modules/' --exclude '_build/' --exclude 'deps/' \
    --exclude 'priv/static/' --exclude '.git/' --exclude '*.log' --existing \
    /work/ /vagrant/
  sleep 1
done
