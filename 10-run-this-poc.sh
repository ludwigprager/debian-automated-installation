#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $BASEDIR

pushd ${BASEDIR}/container
source ${BASEDIR}/container/set-env.sh
docker build -f Containerfile -t $UNATTENDED_DEBIAN_IMAGE . # ${BASEDIR}
popd


#wget -nc https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.6.0-amd64-netinst.iso
#wget -nc https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso
#wget -nc https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso
wget -nc https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/debian-11.7.0-amd64-DVD-1.iso



docker run -ti  \
  -v $(pwd):/work/ \
  -w /work/ \
  ${UNATTENDED_DEBIAN_IMAGE} \
  ./20-build-preseeded-iso.sh

# debian:bookworm-slim \

[[ -f mydisk.qcow2 ]] || qemu-img create -f qcow2 mydisk.qcow2 10G

qemu-system-x86_64 -boot d \
  -m 1024 \
  -hda mydisk.qcow2 \
  -cdrom debian-11.7.0-amd64-DVD-1-preseed.iso

qemu-system-x86_64 \
  -m 1024 \
  -hda mydisk.qcow2

