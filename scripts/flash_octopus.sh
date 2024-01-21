#!/bin/bash

pushd ~/klipper || exit
git pull
make clean
make -j4 KCONFIG_CONFIG=config.octopus

cd scripts || exit
python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_stm32f446xx_25000F001650344D30353320-if00")'
sleep 5
popd || exit

~/katapult/scripts/flashtool.py -d /dev/serial/by-id/usb-katapult_stm32f446xx_25000F001650344D30353320-if00
