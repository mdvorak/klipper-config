# Custom Klipper Config

My own private klipper config - feel free to copy parts of it, but note it is tailored to my HW modified Ender 3 V2.

## Usage

Clone the repo

```shell
git clone https://github.com/mdvorak/klipper-config.git
```

Create `~/printer.cfg` file with following code

```ini
[include klipper-config/*.cfg]
```

To update the code, run `git pull` in the repo and `RESTART` the klipper.

### Update from OctoPrint

Create update script `/usr/local/bin/update-klipper-config`

```sh
#!/bin/bash
set -e

pushd ~/klipper-config
git pull
popd
```

Install [GCODE System Commands](https://github.com/kantlivelong/OctoPrint-GCodeSystemCommands) plugin.

Create `OCTO0` command with `/usr/local/bin/update-klipper-config` system command.

_Note that this command is not available in a Klipper, it is an OctoPrint macro._

### One-click Reload

Install [Terminal Commands Extended](https://github.com/jneilliii/OctoPrint-TerminalCommandsExtended) plugin.

Add command `Reload Config` with following code

```gcode
OCTO0
RESTART
```

Do not run this during print.
