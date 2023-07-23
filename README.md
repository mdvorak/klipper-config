# Custom Klipper Config

My own private klipper config - feel free to copy parts of it, but note that it is tailored to my HW modified Ender 3 V2.

[Pinout](./_PINOUT.md)

This config is for [Moonraker](https://moonraker.readthedocs.io/en/latest/).

## Usage

Clone the repo and add config symlink

```shell
git clone https://github.com/mdvorak/klipper-config.git
ln -s ~/klipper-config ~/printer_data/config/klipper-config
```

Edit `printer.cfg` file with following code (omit first line if not using [Mainsail](https://github.com/mainsail-crew/mainsail-config#readme)):

```ini
[include mainsail.cfg]
[include klipper-config/*.cfg]
# For standalone use without ERCF, include
[include klipper-config/filament_loading/*.cfg]
```

### Moonraker

Update system - Moonraker can do that for you.

```shell
sudo apt update
sudo apt upgrade -y
```

Add this section to `moonraker.conf`

```ini
[update_manager klipper-config]
type: git_repo
primary_branch: main
path: ~/klipper-config
origin: https://github.com/mdvorak/klipper-config.git
managed_services: klipper
```

### Crowsnest

My own [crowsnest](https://github.com/mainsail-crew/crowsnest#readme) config.

Replace default `[cam]` config with the one from [crowsnest.conf](./crowsnest.conf).

If webcam does not work, crowsnest may need to be recompiled manually. Run

```shell
cd ~/crowsnest
git pull
sudo make install
```

### ERCF

Installation according to [ERCF Manual](https://raw.githubusercontent.com/EtteGit/EnragedRabbitProject/no_toolhead_sensor/Documentation/ERCF_Manual.pdf).

Build flash utility

```shell
sudo apt install -y libreadline-dev libwxgtk3.0-*
cd ~
git clone https://github.com/shumatech/BOSSA.git
cd BOSSA
make
sudo cp bin/bossac /usr/local/bin
```

Go to klipper

```shell
cd ~/klipper
make clean
make menuconfig
```

Configure it as follows

```
[*] Enable extra low-level configuration options
    Micro-controller Architecture (SAMC21/SAMD21/SAMD51/SAME5x)  --->
    Processor model (SAMD21G18 (Arduino Zero))  --->
    Bootloader offset (8KiB bootloader (Arduino Zero))  --->
    Clock Reference (Internal clock)  --->
    Communication interface (USB)  --->
    USB ids  --->
()  GPIO pins to set at micro-controller startup (NEW)
```

Then build it and flash it, see [Enter Bootloader Mode](https://wiki.seeedstudio.com/Seeeduino-XIAO/#enter-bootloader-mode).

> * Connect the Seeed Studio XIAO SAMD21 to your computer.
> * Use tweezers or short lines to short the RST pins in the diagram twice.
> * The orange LED lights flicker on and light up.

Find out correct device with `ls -l /dev/serial/by-id/`, and flash it

```shell
sudo /usr/local/bin/bossac -i -d -p /dev/ttyACM0 -e -w -v -R --offset=0x2000 out/klipper.bin
```

Install [ERCF "Happy Hare"](https://github.com/moggieuk/ERCF-Software-V3)

```shell
cd ~
git clone https://github.com/moggieuk/ERCF-Software-V3.git
```

Run `install.sh`, there is however no need to generate config, since it is already present in the [ERCF](./ERCF) directory.

```shell
cd ~/ERCF-Software-V3
./install.sh
cp ~/klipper-config/ERCF/*.cfg ~/printer_data/config/
```

Update `printer.cfg` as follows, includes order is important

```ini
[include mainsail.cfg]
[include klipper-config/*.cfg]

### For standalone use without ERCF, include
#[include klipper-config/filament_loading/*.cfg]

### ERCF
[include ercf_hardware.cfg]
#[include ercf_menu.cfg]
[include ercf_software.cfg]
[include ercf_vars.cfg]
[include ercf_parameters.cfg]
```

**NOTE If local copies of the files are modified, don't forget to commit them back to the repository!**

Add update lines to `moonraker.conf`

```ini
[update_manager ercf-happy_hare]
type: git_repo
path: ~/ERCF-Software-V3
origin: https://github.com/moggieuk/ERCF-Software-V3.git
install_script: install.sh
managed_services: klipper

[update_manager bossa]
type: git_repo
primary_branch: main
path: ~/BOSSA
origin: https://github.com/shumatech/BOSSA.git
is_system_service: False
```
