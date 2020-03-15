#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

source ./lib/mount.sh

echo "Welcome to Paschke.  We'll try and build a Windows 95 image here."

if ! qemu-system-i386 -version | grep -E '4\.[0-9]\.[0-9]'; then
    echo "Please make sure you have at least qemu version 4."
    exit 4
fi

if [ -f "win95_disk.img" ]; then
    echo "Oops, vdisk already exists."
    exit 3
fi


# We keep a 'golden' image, because it's mounted RW, so who knows
# what'll happen to it.
gunzip --keep --force images/win95b-boot.img.gz

# Have a look at https://www.richud.com/wiki/Ubuntu_Create_Hard_Drive_Image for some golden tips about blessing a Win9x partition correctly.

gunzip --keep --force images/hdd-512mb.img.gz
mv images/hdd-512mb.img ./win95_disk.img

echo ""
echo "Partition and format done.  Will try prepare setup folder now."

# We have to mount the MS-DOS 6.22 floppy image again, to add an
# AUTOEXEC.BAT, which kicks off SETUP.EXE.  If we added it up above,
# it wouldn't have done the formatting correctly.
dos_boot_mountpoint=$(image_mount images/win95b-boot.img)
cp -v 02runsetup/runsetup.AUTOEXEC.BAT "$dos_boot_mountpoint/AUTOEXEC.BAT"
eject "$dos_boot_mountpoint"

# Grab actual mount points:
hdd_mount=$(image_mount win95_disk.img) # our fresh HDD image
win_cdrom=$(image_mount "images/Win98SE.ISO" ro) # The source CD

# Windows ISOs don't always have consistent capitalisation, so maybe
# it's D:\WIN95, or maybe it's D:\win95 we need...
install_folder_path=$(find "${win_cdrom}" -iname win98)
if [ -z "$install_folder_path" ]; then
    echo "Oh no, can't find Windows install files!  Bailing."
    exit 54
fi
install_folder_basename=$(basename "${install_folder_path}")

cp -rv "${win_cdrom}/${install_folder_basename}" "${hdd_mount}/"
cp -v  "./02runsetup/MSBATCH.INF" "${hdd_mount}/${install_folder_basename}/"
cp -v  "./02runsetup/CUSTOM.INF" "${hdd_mount}/${install_folder_basename}/"
cp -v  "./02runsetup/vga_driver/VBE.vxd" "${hdd_mount}/${install_folder_basename}/"
cp -v  "./02runsetup/vga_driver/VBEMP.DRV" "${hdd_mount}/${install_folder_basename}/"
cp -v  "./02runsetup/vga_driver/vbemp.inf" "${hdd_mount}/${install_folder_basename}/"
cp -rv "./02runsetup/mscomctl" "${hdd_mount}/"
cp -rv "./02runsetup/vbrun60" "${hdd_mount}/"
cp -v "$HOME/Public/Conway/Conway.exe" "${hdd_mount}/"
cp -v "$HOME/Public/DadaCards/DadaCards.exe" "${hdd_mount}/"
cp -v "$HOME/Public/2048/2048.exe" "${hdd_mount}/"

eject "${win_cdrom}"
eject "${hdd_mount}"

echo ""
echo "Starting Windows setup run..."

qemu-system-i386 -drive file=win95_disk.img,format=raw \
                 -cpu pentium \
                 -m 100 \
                 -boot order=ca,once=a \
                 -vga std \
                 -drive file=images/win95b-boot.img,format=raw,index=0,if=floppy \
                 -nic none

# Proposed steps:


# Wishlist:
# - remote administration of reg keys??
# - get really good at writing PIF/BAT files?
# - somehow know when it's done?  wait for it to open a port????

# - VGA drivers.
# - maybe only ask for 16 colour / 640x480 in MSBATCH.INF

# - TODO bash working directories.
