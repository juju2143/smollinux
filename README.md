# Yuki's Smol Linux

This is a Linux distro project that attempts to fit a modern and usable Linux install onto a standard 1.44 MB floppy disk.

## Build

Install everything needed to build a Linux kernel, musl, syslinux, and dosfstools, then just type `make`. You should get a disk image you can write to a standard 1.44 MB floppy disk.

Note: You might have to type your sudo password at some point as some steps require it.

You can then try out your newly built bootable floppy in qemu:

```
qemu-system-x86_64 -fda base.img -m 28
```

## Goals

- The base floppy should stand alone with a minimal installation with at least some of coreutils, dpkg and a text editor enabled in busybox.
- You should be able to install additional packages from a set of floppy disks into a ramdisk or a hard drive, such as musl or a more complete busybox install. (Coming soon!)
- Only 64-bit is supported for now, but 32-bit should be supported for use on more old computers.

## Minimum requirements

- 64-bit CPU
- 28 MB RAM
- A bootable floppy drive (could also be a USB stick you dd'd the image on but it's better on a floppy)

## Why?

Why not? It's pretty much a stupid proof of concept made for fun, but I can see some use on old computers.

## Who should you blame for that abomination?

I'm J.P. Savard, and you can follow me on Twitter at [@juju2143](http://twitter.com/juju2143).