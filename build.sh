#!/bin/bash

set -e
set -x

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

DEV="/dev/sdb"
DEV_BOOT="${DEV}1"
DEV_ROOT="${DEV}2"
MNT="/mnt"
MNT_BOOT="${MNT}/boot"
MNT_ROOT="${MNT}/root"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${MNT}/alarm.tar.gz"

function build {
    local TGZ="ArchLinuxARM-${1}-latest.tar.gz"
    local URL="http://os.archlinuxarm.org/os/${TGZ}"
    wget -O "${SRC}" "${URL}"

    sfdisk "${DEV}" < "${ROOT_DIR}/sdcard.sfdisk"
    mkfs.vfat "${DEV_BOOT}"
    mkfs.ext4 "${DEV_ROOT}"
    mkdir "${MNT_BOOT}"
    mkdir "${MNT_ROOT}"
    mount "${DEV_BOOT}" "${MNT_BOOT}"
    mount "${DEV_ROOT}" "${MNT_ROOT}"

    bsdtar -xpf "${SRC}" -C "${MNT_ROOT}"
    mv "${MNT_ROOT}/boot/"* "${MNT_BOOT}"
    sync

    umount "${DEV_BOOT}"
    umount "${DEV_ROOT}"
    dd if="${DEV}" | pv | dd of="/vagrant/build/${TGZ/tar.gz/img}"
}

function clean {
    rm "${SRC}"
    rmdir "${MNT_BOOT}"
    rmdir "${MNT_ROOT}"
    wipefs --all "${DEV}"
}

case "${1}" in
    "rpi-1" | "rpi-2" | "rpi-3")
        build "${1/-1/}"
        clean
        ;;
    *)
        echo "Usage: build.sh [rpi-1|rpi-2|rpi-3]..."
        exit 1
        ;;
esac
