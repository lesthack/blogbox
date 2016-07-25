#!/bin/bash
/etc/init.d/vboxdrv stop
sudo modprobe kvm_amd
sudo modprobe kvm
/etc/init.d/vboxdrv start
