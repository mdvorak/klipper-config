# Voron 2.4 Klipper Config

Private [Klipper](https://www.klipper3d.org/) config for BTT Pi, using Armbian.
Based on [Mainsail](https://github.com/mainsail-crew/mainsail-config#readme).

Using [Fly-SB2040-V2](https://mellow-3d.github.io/fly_sb2040_v2_general.html) toolhead board, connected via CAN bus.

## Installation

Use [kiuah](https://github.com/dw-0/kiauh#klipper-installation-and-update-helper) to install

Clone all required repositories

```shell
cd ~
git clone https://github.com/dw-0/kiauh#klipper-installation-and-update-helper
git clone https://github.com/mdvorak/klipper-config.git -b kms
git clone https://github.com/Arksine/katapult
git clone https://github.com/pstolarz/w1-gpio-cl.git
git clone https://github.com/protoloft/klipper_z_calibration.git

~/kiauh/kiauh.sh

ln -s ~/klipper-config ~/printer_data/config/klipper-config
~/klipper_z_calibration/install.sh
```

# TODO linux mcp flash and service, realtime config

### Crowsnest

Replace default `[cam]` config with the one from [crowsnest.conf](./crowsnest.conf).

### Security

[nginx config](./nginx/mainsail)
[firewall](./set_firewall.sh)

### Moonraker

Update `moonraker.conf` in `~/printer_data/config` as listed in [moonraker.conf](./moonraker.conf).

### DS18B20 Temperature Sensors

See [DS18B20 on BigTreeTech Pi 1.2](https://gist.github.com/mdvorak/2fccca3fa9f76f5a2e11e567797c76d6).

## Fly-SB2040-V2 Toolhead PCB

See https://mellow-3d.github.io/fly_sb2040_v2_canboot_can.html#compile-katapult-firmware for installation and
flashing instructions.

## Usage

Update `printer.cfg` in `~/printer_data/config` as follows, includes order is important

```ini
[include mainsail.cfg]
[include klipper-config/printer.cfg]
[include ./KAMP/Adaptive_Meshing.cfg]
[include ./KAMP/Line_Purge.cfg]
[include ./KAMP/Smart_Park.cfg]
```
