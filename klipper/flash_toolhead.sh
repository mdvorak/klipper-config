#!/bin/bash
set -e

pushd ~/klipper
git pull
make clean
make -j4 KCONFIG_CONFIG=~/klipper-config/klipper/config.toolhead
popd

~/katapult/scripts/flashtool.py -u 16204041f80e
