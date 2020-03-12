#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

source ./mount.sh

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

# the MS-DOS 6.22 floppy image
dos_boot_mountpoint=$(mount 622C.IMG)
rm -v "$dos_boot_mountpoint/CONFIG.SYS"
cp -v FDISK.SCP "$dos_boot_mountpoint"
cp -v FDISK.BAT "$dos_boot_mountpoint"
cp -v FORMAT.SCP "$dos_boot_mountpoint"
cp -v FORMAT.BAT "$dos_boot_mountpoint"
# This AUTOEXEC partitions and formats.  There's also one to kick off
# the setup, but we stick it on the floppy later.
cp -v partition.AUTOEXEC.BAT "$dos_boot_mountpoint/AUTOEXEC.BAT"
eject "$dos_boot_mountpoint"

./layers/01_partition.expect

echo ""
echo "Partition and format done.  Will try prepare setup folder now."

# We have to mount the MS-DOS 6.22 floppy image again, to add an
# AUTOEXEC.BAT, which kicks off SETUP.EXE.  If we added it up above,
# it wouldn't have done the formatting correctly.
dos_boot_mountpoint=$(mount 622C.IMG)
cp -v runsetup.AUTOEXEC.BAT "$dos_boot_mountpoint/AUTOEXEC.BAT"
eject "$dos_boot_mountpoint"

hdd_mount=$(mount win95_disk.img) # our fresh HDD image
win_cdrom=$(mount "Win95 OSR2.ISO") # The source CD

# Guess mount point?
cp -rv "${win_cdrom}/WIN95" "${hdd_mount}/"
cp -v  "./MSBATCH.INF" "${hdd_mount}/WIN95/"
cp -v  "./CUSTOM.INF" "${hdd_mount}/WIN95/"
cp -v  "./vga_driver/VBE.vxd" "${hdd_mount}/WIN95/"
cp -v  "./vga_driver/VBEMP.DRV" "${hdd_mount}/WIN95/"
cp -v  "./vga_driver/vbemp.inf" "${hdd_mount}/WIN95/"

eject "${win_cdrom}"
eject "${hdd_mount}"

echo ""
echo "Starting Windows setup run..."

qemu-system-i386 -drive file=win95_disk.img,format=raw -m 100 -boot order=ca,once=a -vga std -drive file=622C.IMG,format=raw,index=0,if=floppy -nic none

# Proposed steps:


# Wishlist:
# - remote administration of reg keys??
# - get really good at writing PIF/BAT files?
# - somehow know when it's done?  wait for it to open a port????

# - VGA drivers.
# - maybe only ask for 16 colour / 640x480 in MSBATCH.INF
