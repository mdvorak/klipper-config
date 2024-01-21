### ERCF

Installation according to [ERCF Manual](https://raw.githubusercontent.com/EtteGit/EnragedRabbitProject/no_toolhead_sensor/Documentation/ERCF_Manual.pdf).

Build flash utility

```shell
cd
sudo apt install -y libreadline-dev libwxgtk3.0-*
# git clone https://github.com/shumatech/BOSSA.git
cd ~/BOSSA
make
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
sudo ~/BOSSA/bin/bossac -i -d -p /dev/ttyACM1 -e -w -v -R --offset=0x2000 ~/klipper/out/klipper.bin
```
