# Custom Klipper Config

My own private klipper config - feel free to copy parts of it, but note it is tailored to my HW modified Ender 3 V2.

## Usage

Clone the repo

```shell
git clone https://github.com/mdvorak/klipper-config
```

Create `~/printer.cfg` file with following code

```ini
[include klipper-config/*.cfg]
```

To update the code, run `git pull` in the repo and `RESTART` the klipper.
