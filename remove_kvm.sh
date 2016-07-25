#!/bin/bash
/etc/init.d/vboxdrv stop
sudo modprobe -r kvm_amd
sudo modprobe -r kvm
/etc/init.d/vboxdrv start
