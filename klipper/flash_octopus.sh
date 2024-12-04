#!/bin/bash
set -e

pushd ~/klipper
git pull
make clean
make -j4 KCONFIG_CONFIG=~/klipper-config/klipper/config.octopus

cd scripts
python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_stm32f446xx_25000F001650344D30353320-if00")'
sleep 5
popd

~/katapult/scripts/flashtool.py -d /dev/serial/by-id/usb-katapult_stm32f446xx_25000F001650344D30353320-if00
