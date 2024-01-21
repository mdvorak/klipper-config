#!/bin/bash

pushd ~/klipper || exit
git pull
make clean
make -j4 KCONFIG_CONFIG=config.sb2040v2
popd || exit

~/katapult/scripts/flashtool.py -u 16204041f80e
