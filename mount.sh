#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

function mount() {
    # This function mounts an image and returns the mount point.

    [ -f "$1" ] || (echo "Cannot find image $1!"; exit 2)

    local output
    output=$(hdiutil attach "$1")

    echo "$output" | awk '{print $2}'
}

function eject() {
    hdiutil eject "$1"
}
