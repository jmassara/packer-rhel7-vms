## Packer templates for Red Hat Enterprise 7 x86_64

## Overview

This repository contains templates for [RHEL7](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/index.html)
x86_64 that creates [Vagrant](http://vagrantup.com) boxes using [Packer](http://packer.io).

## Prerequisites

To build all the boxes, you will need Packer and both VirtualBox and VMware
Fusion installed. You will also need the RHEL7 64-bit ISO from Red Hat and, if
using VirtualBox, the guest additions ISO matching the version of VirtualBox you
are using (see [here](http://download.virtualbox.org/virtualbox)). VMWare Fusion
comes packaged with their tools.

Once you've obtained the ISOs, copy all of them into the same directory
(e.g. /usr/local/isos).

## Creating the boxes

* Export `ISO_URL` to the location of the installation ISO
* Run packer with either the `rhel-7.0-vbox.json` or `rhel-7.0-vmware.json` template
* Add the box to Vagrant
* Build VMs

### Example

```
$ export ISO_URL=file:///usr/local/isos/rhel-server-7.0-x86_64-dvd.iso
$ packer build rhel-7.0-vbox.json
$ packer build rhel-7.0-vmware.json
$ vagrant box add rhel-7.0-vbox ./rhel-7.0-vbox.box
$ vagrant box add rhel-7.0-vmware ./rhel-7.0-vmware.box
```
