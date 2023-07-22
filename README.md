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

## Auto-update

Add this section to `moonraker.conf`

```ini
[update_manager klipper-config]
type: git_repo
primary_branch: main
path: ~/klipper-config
origin: https://github.com/mdvorak/klipper-config.git
managed_services: klipper
```
