#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

function _macos_mount() {
    local output
    output=$(hdiutil attach "$1")

    echo "$output" | sed -n 's#.*\(/Volume.*\)$#\1#p'
}

function _linux_mount() {
    local mountPoint
    mountPoint=$(mktemp --directory)

	mount_ro="${2:-}"
	if [ "${mount_ro}" = "ro" ]; then
		options=""
    else
		options="-o umask=000"
	fi
	loopback=$(sudo losetup --partscan --show --find "$1")

	# Ugh, we don't always have partitions...
	if [ -e "${loopback}p1" ]; then
			loopback="${loopback}p1"
	fi
	echo "Mounting ${loopback} on ${mountPoint}..." 1>&2
	sudo mount "${loopback}" "${mountPoint}" $options

    echo "$mountPoint"
}

function image_mount() {
    # This function mounts an image and returns the mount point.
    if [ ! -f "$1" ]; then
        echo "Cannot find image $1!" 1>&2
        exit 2
    fi

    if [ "$(uname -s)" = "Darwin" ]; then
		_macos_mount "$@"
    fi
    if [ "$(uname -s)" = "Linux" ]; then
		_linux_mount "$@"
    fi
}

function _linux_eject() {
	# magic! TODO find correct loopback and detach
	echo "Unmounting ${1}..."
	lodev=$(mount | grep "${1}" | awk '{print $1}')
	sudo umount "$1"

	if [[ "$lodev" =~ loop[0-9]p[0-9]$ ]]; then
		# Need to strip off partition number...
		lodev=$(echo -n "$lodev" | sed 's/p[0-9]$//')
	fi
	echo "Detaching ${lodev}..."
	sudo losetup --detach "${lodev}"
}

function _macos_eject() {
    hdiutil eject "$1"
}

function eject() {
    if [ "$(uname -s)" = "Darwin" ]; then
		_macos_eject "$@"
    fi
    if [ "$(uname -s)" = "Linux" ]; then
		_linux_eject "$@"
    fi
}
