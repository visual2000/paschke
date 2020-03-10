#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

echo "Welcome to Paschke.  We'll try and build a Windows 95 image here."

if [ -f "win95_disk.img" ]; then
    echo "Oops, vdisk already exists."
    exit 3
fi

if [ ! -f "win95_disk.img" ]; then
    qemu-img create -f raw win95_disk.img 512M
fi

# We keep a 'golden' image, because it's mounted RW, so who knows
# what'll happen to it.
gunzip --keep --force 622C.IMG.golden.gz
mv 622C.IMG.golden 622C.IMG

./layers/01_partition.expect

echo "Partition and format done.  Will try prepare setup folder now."

hdiutil attach win95_disk.img # our fresh HDD image
hdiutil attach Win95_OSR2.ISO # The source CD

sleep 10

# Guess mount point?
cp -rv /Volumes/WIN_95C/WIN95 /Volumes/PARSNIP/
cp -v ./MSBATCH.INF /Volumes/PARSNIP/WIN95/
cp -v ./vga_driver/VBE.vxd /Volumes/PARSNIP/WIN95/
cp -v ./vga_driver/VBEMP.DRV /Volumes/PARSNIP/WIN95/
cp -v ./vga_driver/vbemp.inf /Volumes/PARSNIP/WIN95/

diskutil eject /Volumes/WIN_95C
diskutil eject /Volumes/PARSNIP

sleep 10

qemu-system-i386 -drive file=win95_disk.img,format=raw -m 100 -soundhw sb16 -boot order=ca,once=a -vga std -drive file=622C.IMG,format=raw,index=0,if=floppy

# Proposed steps:

# find a msbatch.inf?? file somewhere
# add it to the /WIN95 folder


# Try boot it all up in qemu i386???

# Wishlist:
# - remote administration of reg keys??
# - get really good at writing PIF/BAT files?
# - somehow know when it's done?  wait for it to open a port????

# - VGA drivers.
# - maybe only ask for 16 colour / 640x480 in MSBATCH.INF
