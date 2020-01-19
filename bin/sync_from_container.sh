#!/bin/bash
set -eu

rsync -au --exclude 'node_modules/' --exclude '_build/' --exclude 'deps/' \
  --exclude 'priv/static/' --exclude '*.log' /work/ /vagrant/
