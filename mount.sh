#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

function mount() {
    # This function mounts an image and returns the mount point.

    if [ ! -f "$1" ]; then
        echo "Cannot find image $1!" 1>&2
        exit 2
    fi

    local output
    output=$(hdiutil attach "$1")

    echo "$output" | awk '{print $2}'
}

function eject() {
    hdiutil eject "$1"
}
