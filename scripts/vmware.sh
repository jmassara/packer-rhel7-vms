#!/usr/bin/env bash
set -x

VMWARE_ISO=/tmp/vmware_tools_linux.iso
VMWARE_MNTDIR=$(mktemp --tmpdir=/tmp -q -d -t vmware_mnt_XXXXXX)
VMWARE_TMPDIR=$(mktemp --tmpdir=/tmp -q -d -t vmware_XXXXXX)

# Extract tools
mount -o loop $VMWARE_ISO $VMWARE_MNTDIR
tar zxf $VMWARE_MNTDIR/VMwareTools*.tar.gz -C $VMWARE_TMPDIR
umount $VMWARE_MNTDIR

# Patch HGFS
curl -Lo $VMWARE_TMPDIR/hgfs_patch.tar.gz https://gist.github.com/jmassara/e794a6ed80543d7c75fb/download
tar zxf $VMWARE_TMPDIR/hgfs_patch.tar.gz -C $VMWARE_TMPDIR
cd $VMWARE_TMPDIR/vmware-tools-distrib/lib/modules/source/
tar xf vmhgfs.tar
cd vmhgfs-only
patch inode.c < $VMWARE_TMPDIR/gist*/vmhgfs-d_count-kernel-3.10-tools-9.6.2.patch
cd ..
rm -f vmhgfs.tar
tar cf vmhgfs.tar vmhgfs-only
cd ~

# Install tools
$VMWARE_TMPDIR/vmware-tools-distrib/vmware-install.pl -d

# Clean up
rm -f $VMWARE_ISO
rm -rf $VMWARE_MNTDIR
rm -rf $VMWARE_TMPDIR
