# Custom Klipper Config

My own private klipper config - feel free to copy parts of it, but note that it is tailored to my HW modified Ender 3 V2.

[Pinout](./_PINOUT.md)

This config is now for use with Moonraker.

## Usage

Clone the repo

```shell
git clone https://github.com/mdvorak/klipper-config.git
```

Edit `printer.cfg` file with following code

```ini
[include klipper-config/*.cfg]
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

Note that it is not needed to run `install.sh`, since config is already under ERCF directory in this repo.

Add update lines to `moonraker.conf`

```ini
[update_manager bossa]
type: git_repo
primary_branch: main
path: ~/BOSSA
origin: https://github.com/shumatech/BOSSA.git

[update_manager ercf-happy_hare]
type: git_repo
path: ~/ERCF-Software-V3
origin: https://github.com/moggieuk/ERCF-Software-V3.git
install_script: install.sh
managed_services: klipper
```
