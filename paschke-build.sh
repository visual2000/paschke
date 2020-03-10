#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

echo "Welcome to Paschke.  We'll try and build a Windows 95 image here."

# Proposed steps:
# somehow make a qemu image. e.g., 300MB
# give it one primary partitition, make it boot/"active"
# format it as FAT16 or FAT32 (OSS tools exist??)
# mount / load the hdd image for r/w
# find a win95 ISO
# Mount / load the CD image
# extract the /WIN95 folder into the hdd's FAT partition

# find a msbatch.inf?? file somewhere
# add it to the /WIN95 folder

# find a dos 622C.IMG floppy, add an AUTOEXEC.BAT to it with contents:
#     C: ; CD WIN95 ; SETUP /IS /IW MSBATCH.INF

# Try boot it all up in qemu i386???

# Wishlist:
# - remote administration of reg keys??
# - get really good at writing PIF/BAT files?
# - somehow know when it's done?  wait for it to open a port????
