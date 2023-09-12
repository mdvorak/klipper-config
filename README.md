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
cd ~/ERCF-Software-V3
./install.sh
cp ~/klipper-config/ERCF/*.cfg ~/printer_data/config/
```

**NOTE If local copies of ERCF files are modified, don't forget to commit them back to the repository!**

To flash new firmware, see [ERCF.md](./ERCF.md).

### Crowsnest

Replace default `[cam]` config with the one from [crowsnest.conf](./crowsnest.conf).

### Security

_TODO nginx config, SSL certs, firewall_

### Moonraker

Update `moonraker.conf` in `~/printer_data/config` as listed in [moonraker.conf](./moonraker.conf).

## Usage

Update `printer.cfg` in `~/printer_data/config` as follows, includes order is important

```ini
[include mainsail.cfg]
[include print_area_bed_mesh.cfg]
[include klipper-config/printer.cfg]

# For standalone use without ERCF, include
#[include klipper-config/filament_loading/*.cfg]

# ERCF
# If local copies of the files are modified, don't forget to commit them back to the repository!
[include ercf_hardware.cfg]
[include ercf_menu.cfg]
[include ercf_software.cfg]
[include ercf_parameters.cfg]

[save_variables]
filename: ~/printer_data/config/ercf_vars.cfg

#[stepper_z]
#position_endstop: 1.000
```
