#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

source ./lib/mount.sh

echo "Welcome to Paschke.  We'll refresh the games in the image here."

if ! qemu-system-i386 -version | grep -E '4\.[0-9]\.[0-9]'; then
    echo "Please make sure you have at least qemu version 4."
    exit 4
fi

if [ ! -f "win95_disk.img" ]; then
    echo "Oops, vdisk not found."
    exit 3
fi

# Grab actual mount points:
hdd_mount=$(image_mount win95_disk.img) # our fresh HDD image
echo "Found hard disk mounted at ${hdd_mount}."

sleep 3

rm -v  "${hdd_mount}/games/"*
cp -v  "$HOME/Public/Conway/Conway.exe" "${hdd_mount}/games/"
cp -v  "$HOME/Public/DadaCards/DadaCards.exe" "${hdd_mount}/games/"
cp -v  "$HOME/Public/2048/2048.exe" "${hdd_mount}/games/"

eject "${hdd_mount}"

printf "Done.  To apply changes (update desktop shortcuts):\n"
echo "    make boot"

make boot
