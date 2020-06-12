# Scratch Desktop Ubuntu build script

Unofficial script to build and install Scratch Desktop for Ubuntu. Based on this Gist by [lyshie](https://gist.github.com/lyshie): https://gist.github.com/lyshie/0c49393076b8b375ca1bd98c28f95fb0. View the Gist if you want to build for Fedora, openSUSE or architectures other than 64-bit.

This script works because the Scratch Desktop Windows version is just an Electron application and so can run fine on Linux with some minor tweaks.

## Building

To install on Ubuntu:

```bash
git clone https://github.com/siphomateke/scratch-desktop
cd scratch-desktop
chmod +x ./create-deb.sh
sudo ./create-deb.sh
```

The Scratch Desktop Windows installer will then be downloaded, extracted and converted to a .deb file. You can now install the deb file as you would any other.
