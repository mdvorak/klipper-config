#!/bin/bash
set -e

pushd ~/klipper-config/
git pull
popd

pushd ~/klipper
git pull
make clean
make -j4 KCONFIG_CONFIG=~/klipper-config/klipper/config.linux

make flash

popd
