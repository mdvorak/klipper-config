# Voron 2.4 Klipper Config

Private [Klipper](https://www.klipper3d.org/) config for [BTT Pi](https://github.com/bigtreetech/CB1). 
Based on [Mainsail](https://github.com/mainsail-crew/mainsail-config#readme).

Using [Fly-SB2040-V2](https://mellow-3d.github.io/fly_sb2040_v2_general.html) toolhead board, connected via CAN bus.

Optionally using [ERCF](https://github.com/EtteGit/EnragedRabbitProject).

## Installation

It is recommended to update all modules first, do that via Mainsail UI.

Clone all required repositories

```shell
cd
git clone https://github.com/mdvorak/klipper-config.git
git clone https://github.com/Arksine/katapult
git clone https://github.com/moggieuk/ERCF-Software-V3.git
git clone https://github.com/shumatech/BOSSA.git

ln -s ~/klipper-config ~/printer_data/config/klipper-config
```

### ERCF

```shell
cp ~/ERCF-Software-V3/extras/*.py ~/klipper/klippy/extras/
cp ~/klipper-config/ERCF/ercf_vars.cfg ~/printer_data/config/
```

To flash a new EasyBRD firmware, see [ERCF.md](./ERCF.md).

### Crowsnest

Replace default `[cam]` config with the one from [crowsnest.conf](./crowsnest.conf).

### Security

_TODO nginx config, SSL certs, firewall_

### Moonraker

Update `moonraker.conf` in `~/printer_data/config` as listed in [moonraker.conf](./moonraker.conf).

### DS18B20 Temperature Sensors

See [DS18B20 on BigTreeTech Pi 1.2](https://gist.github.com/mdvorak/2fccca3fa9f76f5a2e11e567797c76d6).

## Usage

Update `printer.cfg` in `~/printer_data/config` as follows, includes order is important

```ini
[include mainsail.cfg]

# host MCU service is preinstalled and ready to use with:
[mcu CB1]
serial: /tmp/klipper_host_mcu

[include print_area_bed_mesh.cfg]
[include klipper-config/printer.cfg]
[include klipper-config/ercf.cfg]

[save_variables]
filename: ~/printer_data/config/ercf_vars.cfg

#[stepper_z]
#position_endstop: 1.000
```
