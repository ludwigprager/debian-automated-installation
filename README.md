# Debian Unattended Install ISO file

This project creates an ISO file which, when copied onto a USB stick, performs
a debian installation without manual steps and internet access.

The [test script](./10-run-this-poc.sh) performs these 3 steps:
- create a preseed-iso based on a standard DVD install ISO file
- install this preseed-iso in a virtual machine (qemu)
- start/test the new machine

These three steps are unattended, i.e. without manual interaction.
The preseed-iso is created in the context of a docker-container.

# Prerequisites
- qemu-utils
- qemu-system-x86

```
./10-run-this-poc.sh
```
