MAKEFLAGS=-j8

all: base

base: base.img linux/arch/x86/boot/bzImage
	mkdir build
	sudo mount base.img build -o rw,umask=000
	sudo cp linux/arch/x86/boot/bzImage build
	sudo cp config/syslinux.cfg build
	sudo umount build
	rmdir build

base.img: 
	dd if=/dev/zero of=base.img bs=512 count=2880
	mkfs.msdos -i 21430001 -n SMOLBASE base.img
	syslinux -i base.img

linux/arch/x86/boot/bzImage: linux/.config initrd/bin/busybox
	make -C linux oldconfig
	make -C linux $(MAKEFLAGS)

initrd/bin/busybox: busybox/.config
	make -C busybox oldconfig
	make -C busybox CC=musl-gcc $(MAKEFLAGS)
	make -C busybox CC=musl-gcc $(MAKEFLAGS) install
	mkdir initrd/{dev,proc,sys}
	sudo mknod -m 644 initrd/dev/console c 5 1

busybox/.config:
	cp config/busybox.config busybox/.config

linux/.config:
	cp config/linux.config linux/.config

clean:
	make -C busybox CC=musl-gcc clean
	make -C linux clean
	rm base.img
	rm -r initrd/{bin,sbin,usr,linuxrc}

qemu:
	qemu-system-x86_64 -fda base.img -m 28