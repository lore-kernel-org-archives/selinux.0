Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16418
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 12:23:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OHNlI27834
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:23:47 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h1OHNkf27830 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:23:46 GMT
Received: from moss-sooners.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5) with ESMTP id h1OHNjTT022448
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 12:23:45 -0500
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5/Submit) id h1OHNiCD022446
	for selinux@tycho.nsa.gov; Mon, 24 Feb 2003 12:23:44 -0500
Message-ID: <004601c2daca$dc53e5d0$6400a8c0@Comp1>
From: "S. Patel" <spatel@elp.rr.com>
To: <SELinux@tycho.nsa.gov>
Subject: Errors While Installing On Redhat 8.0
Date: Sat, 22 Feb 2003 16:33:53 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0043_01C2DA90.2FCA0630"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0043_01C2DA90.2FCA0630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hey all I just tryed to install SELinux and I have a couple of errors. =
Below is the compostion of my install on my redhat 8.0 server.  Im using =
LSM 2.4 if you got any ideas or tips please let me know. All help is =
appreciated. Thanks

make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make -C pcmcia modules
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make -C hotplug modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make -C ide modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make -C media modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C radio modules
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make -C video modules
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C misc modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make -C net modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make -C pcmcia modules
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make -C parport modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make -C pnp modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make -C scsi modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C pcmcia modules
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C sound modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make -C usb modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make -C video modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make -C  mm CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make -C  fs CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make -C  net CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make -C core modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make -C ipv4 modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make -C ipv4/netfilter modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make -C netlink modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make -C sched modules
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make -C  ipc CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make -C  lib CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make -C  security CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make -C  arch/i386/kernel CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make -C  arch/i386/mm CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make -C  arch/i386/lib CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 -DMODULE -DMODVERSIONS -include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h" =
MAKING_MODULES=3D1 modules
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make[1]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4'
Installing the SELinux kernel.
cd ../lsm-2.4; make install; make modules_install
make[1]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
  -DUTS_MACHINE=3D'"i386"' -DKBUILD_BASENAME=3Dversion -c -o =
init/version.o init/version.c
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  kernel
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make all_targets
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  drivers
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make -C block
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make -C cdrom
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make -C char
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make -C agp
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'
ld -m elf_i386  -r -o agpgart.o agpgart_fe.o agpgart_be.o
rm -f agp.o
ld -m elf_i386  -r -o agp.o agpgart.o
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'
make -C drm
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
ld -m elf_i386 -r -o tdfx.o tdfx_drv.o
ld -m elf_i386 -r -o radeon.o radeon_drv.o radeon_cp.o radeon_state.o
ld -m elf_i386 -r -o i810.o i810_drv.o i810_dma.o
rm -f drm.o
ld -m elf_i386  -r -o drm.o tdfx.o radeon.o i810.o
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make -C pcmcia
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make -C hotplug
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make -C ide
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
ld -m elf_i386 -r -o ide-mod.o ide.o ide-features.o ide-taskfile.o  =
cmd640.o ide-adma.o ide-dma.o ide-pci.o piix.o rz1000.o ide-proc.o
ld -m elf_i386 -r -o ide-probe-mod.o ide-probe.o ide-geometry.o
rm -f idedriver.o
ld -m elf_i386  -r -o idedriver.o ide-mod.o ide-probe-mod.o ide-disk.o =
ide-cd.o
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make -C media
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C radio
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make -C video
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C misc
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make -C net
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make -C pcmcia
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make -C parport
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make -C pci
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'
make -C pcmcia
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'
make -C pnp
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
ld -m elf_i386  -r -o isa-pnp.o isapnp.o quirks.o isapnp_proc.o
rm -f pnp.o
ld -m elf_i386  -r -o pnp.o isa-pnp.o
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make -C scsi
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C pcmcia
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o =
scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o =
scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
ld -m elf_i386 -r -o sd_mod.o sd.o
rm -f scsidrv.o
ld -m elf_i386  -r -o scsidrv.o scsi_mod.o sym53c8xx.o sd_mod.o
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C sound
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
ld -m elf_i386 -r -o soundcore.o sound_core.o sound_firmware.o
rm -f sounddrivers.o
ld -m elf_i386  -r -o sounddrivers.o soundcore.o es1371.o ac97_codec.o
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make -C usb
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make -C storage
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'
ld -m elf_i386 -r -o usb-storage.o scsiglue.o protocol.o transport.o =
usb.o initializers.o
rm -f storage.o
ld -m elf_i386  -r -o storage.o usb-storage.o
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
ld -m elf_i386 -r -o usbcore.o usb.o usb-debug.o hub.o hcd.o
rm -f usbdrv.o
ld -m elf_i386  -r -o usbdrv.o usbcore.o uhci.o storage/storage.o
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make -C video
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make all_targets
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  mm
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make all_targets
make[3]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  fs
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make -C autofs4
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'
make -C devpts
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'
make -C ext2
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'
make -C isofs
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'
make -C lockd
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'
make -C nfs
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'
make -C nfsd
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'
make -C partitions
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'
make -C proc
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'
make -C ramfs
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'
make all_targets
make[3]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  net
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make -C 802
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'
make -C core
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make -C ethernet
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'
make -C ipv4
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make -C ipv4/netfilter
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make -C netlink
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make -C packet
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'
make -C sched
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make -C sunrpc
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'
make -C unix
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'
make[4]: Nothing to be done for `all_targets'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'
make all_targets
make[3]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  ipc
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make all_targets
make[3]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  lib
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make all_targets
make[3]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  security
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make -C selinux
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'
make -C arch/i386
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make all_targets
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make[5]: Nothing to be done for `all_targets'.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make -C flask
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/flask'
make[4]: Nothing to be done for `all'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/flask'
make -C ss
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'
make[4]: Nothing to be done for `all'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'
make all_targets
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'
make -C arch/i386 security.o
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make[5]: `security.o' is up to date.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'
make -C ss ss.o
make[5]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'
make[5]: `ss.o' is up to date.
make[5]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'
make all_targets
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  arch/i386/kernel
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  arch/i386/mm
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make all_targets
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make CFLAGS=3D"-D__KERNEL__ =
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di686  =
 " -C  arch/i386/lib
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make all_targets
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make[3]: Nothing to be done for `all_targets'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
ld -m elf_i386 -T =
/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/vmlinux.lds -e stext =
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o =
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o =
mm/mm.o fs/fs.o ipc/ipc.o security/vmlinux-obj.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o =
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o =
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o =
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o =
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o =
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib/lib.a =
/home/Devesh/Programs/SELinux/lsm-2.4/lib/lib.a =
/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] =
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot'
gcc -E -D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-D__BIG_KERNEL__ -traditional -DSVGA_MODE=3DNORMAL_VGA  bootsect.S -o =
bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:256: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional -DSVGA_MODE=3DNORMAL_VGA  =
setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1456: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e begtext -o bsetup =
bsetup.o
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot/compressed'
tmppiggy=3D_tmp_$$piggy; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
objcopy -O binary -R .note -R .comment -S =
/home/Devesh/Programs/SELinux/lsm-2.4/vmlinux $tmppiggy; \
gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
echo "SECTIONS { .data : { input_len =3D .; LONG(input_data_end - =
input_data) input_data =3D .; *(.data) input_data_end =3D .; }}" > =
$tmppiggy.lnk; \
ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T =
$tmppiggy.lnk; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o =
piggy.o
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot/compressed'
objcopy -O binary -R .note -R .comment -S compressed/bvmlinux =
compressed/bvmlinux.out
tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > =
bzImage
Root device is (3, 5)
Boot sector 512 bytes.
Setup is 2541 bytes.
System is 1158 kB
warning: kernel is too big for standalone boot from floppy
sh -x ./install.sh 2.4.20-selinux bzImage =
/home/Devesh/Programs/SELinux/lsm-2.4/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.20-selinux bzImage =
/home/Devesh/Programs/SELinux/lsm-2.4/System.map ''
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot'
make[1]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4'
make[1]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4'
make -C  kernel modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'
make -C  drivers modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make -C block modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'
make -C cdrom modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'
make -C char modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make -C drm modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'
make -C pcmcia modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'
make -C hotplug modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'
make -C ide modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'
make -C media modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C radio modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'
make -C video modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'
make -C misc modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'
make -C net modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
mkdir -p /lib/modules/2.4.20-selinux/kernel/drivers/net/
cp dummy.o /lib/modules/2.4.20-selinux/kernel/drivers/net/
make -C pcmcia modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'
make -C parport modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'
make -C pnp modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'
make -C scsi modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C pcmcia modules_install
make[4]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[4]: Nothing to be done for `modules_install'.
make[4]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'
make -C sound modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'
make -C usb modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'
make -C video modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'
make -C  mm modules_install
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'
make -C  fs modules_install
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'
make -C  net modules_install
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make -C core modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'
make -C ipv4 modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'
make -C ipv4/netfilter modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'
make -C netlink modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'
make -C sched modules_install
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[3]: Nothing to be done for `modules_install'.
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'
make -C  ipc modules_install
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'
make -C  lib modules_install
make[2]: Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'
make -C  security modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security'
make -C  arch/i386/kernel modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'
make -C  arch/i386/mm modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'
make -C  arch/i386/lib modules_install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
make[2]: Nothing to be done for `modules_install'.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'
cd /lib/modules/2.4.20-selinux; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} =
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  =
2.4.20-selinux; fi
make[1]: Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4'
Building and installing support files needed by the userland components.
cd module && make install LSMVER=3D-2.4
make[1]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/module'
make -C checkpolicy LSMDIR=3D../../../lsm-2.4
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'
make[2]: `checkpolicy' is up to date.
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'
mkdir -p /usr/local/selinux/flask
mkdir -p /usr/local/selinux/include/linux/flask
mkdir -p /usr/local/selinux/include/asm-i386/flask
mkdir -p /usr/local/selinux/bin
( cd /usr/local/selinux/include; ln -sf asm-i386 asm)
cd ../../lsm-2.4/security/selinux/flask; install -m 644 access_vectors =
security_classes initial_sids /usr/local/selinux/flask
cd ../../lsm-2.4/security/selinux/include/linux/flask; install -m 644 =
*.h /usr/local/selinux/include/linux/flask
cd ../../lsm-2.4/security/selinux/include/asm/flask; [ -f unistd.h ] && =
install -m 644 unistd.h /usr/local/selinux/include/asm/flask ; true
cd ../../lsm-2.4/include/asm; install -m 644 unistd.h =
/usr/local/selinux/include/asm
cd ../../lsm-2.4/include/linux; install -m 644 version.h =
/usr/local/selinux/include/linux
make -C checkpolicy install
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'
install -m 755 checkpolicy /usr/local/selinux/bin
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'
make[1]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/module'
Building and installing the policy configuration.
cd tools && make insert-policy
make[1]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/tools'
make[2]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/tools/setools'
cd seuser ; make insert-policy
make[3]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/tools/setools/seuser'
install -m 644 ../policy/seuser.te =
/home/Devesh/Programs/SELinux/selinux/tools/../policy/domains/program
install -m 644 ../policy/seuser.fc =
/home/Devesh/Programs/SELinux/selinux/tools/../policy/file_contexts/progr=
am
make[3]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/tools/setools/seuser'
make[2]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/tools/setools'
make[1]: Leaving directory `/home/Devesh/Programs/SELinux/selinux/tools'
cd policy && make install-src install
make[1]: Entering directory =
`/home/Devesh/Programs/SELinux/selinux/policy'
rm -rf /etc/security/selinux/src/policy.old
mv /etc/security/selinux/src/policy /etc/security/selinux/src/policy.old
mv: cannot stat `/etc/security/selinux/src/policy': No such file or =
directory
make[1]: *** [install-src] Error 1
make[1]: Leaving directory =
`/home/Devesh/Programs/SELinux/selinux/policy'
make: *** [quickinstall] Error 2

------=_NextPart_000_0043_01C2DA90.2FCA0630
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1126" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DArial size=3D2>Hey all I just tryed to install SELinux =
and I have=20
a couple of errors. Below is the compostion of my install on my redhat =
8.0=20
server.&nbsp; Im using LSM 2.4 if you got any ideas or tips please let =
me know.=20
All help is appreciated. Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make[4]: =
Nothing to=20
be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make -C =
pcmcia=20
modules<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make =
-C=20
hotplug modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make[3]: =
Nothing to=20
be done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make -C ide=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make[3]: Nothing =
to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make -C media=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make -C radio=20
modules<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make[4]: =
Nothing=20
to be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make -C =
video=20
modules<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[4]: =
Nothing=20
to be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make =
-C misc=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make[3]: Nothing =
to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make -C net=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make -C pcmcia=20
modules<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make -C =
parport=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make[3]: =
Nothing to=20
be done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make -C pnp=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make[3]: Nothing =
to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make -C scsi=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make -C pcmcia=20
modules<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make =
-C sound=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make[3]: =
Nothing to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make -C usb=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make[3]: Nothing =
to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make -C video=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[3]: =
Nothing to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[2]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make =
-C&nbsp; mm=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make[2]: Nothing to be =
done for=20
`modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make -C&nbsp; fs=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make[2]: Nothing to be =
done for=20
`modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make -C&nbsp; net=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make -C core =
modules<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make[3]:=20
Nothing to be done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make -C ipv4=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make[3]: Nothing to =
be done=20
for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make -C =
ipv4/netfilter=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make[3]: =
Nothing=20
to be done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make -C =
netlink=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make[3]: Nothing =
to be=20
done for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make -C sched=20
modules<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[3]: Nothing to =
be done=20
for `modules'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make -C&nbsp; ipc=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make[2]: Nothing to be =
done for=20
`modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make -C&nbsp; lib=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make[2]: Nothing to be =
done for=20
`modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make -C&nbsp; security=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
-DMODULE -DMODVERSIONS -include=20
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make[2]: Nothing to =
be done=20
for `modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make -C&nbsp;=20
arch/i386/kernel CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; -DMODULE =
-DMODVERSIONS=20
-include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make[2]: =
Nothing to=20
be done for `modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make =
-C&nbsp;=20
arch/i386/mm CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; -DMODULE =
-DMODVERSIONS=20
-include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make[2]: Nothing =
to be=20
done for `modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make -C&nbsp;=20
arch/i386/lib CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; -DMODULE =
-DMODVERSIONS=20
-include =
/home/Devesh/Programs/SELinux/lsm-2.4/include/linux/modversions.h"=20
MAKING_MODULES=3D1 modules<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make[2]: =
Nothing to be=20
done for `modules'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make[1]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4'<BR>Installing the =
SELinux=20
kernel.<BR>cd ../lsm-2.4; make install; make modules_install<BR>make[1]: =

Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4'<BR>.=20
scripts/mkversion &gt; .tmpversion<BR>gcc -D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp;&nbsp;=20
-DUTS_MACHINE=3D'"i386"' -DKBUILD_BASENAME=3Dversion -c -o =
init/version.o=20
init/version.c<BR>make CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp;=20
kernel<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make =
all_targets<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make[3]:=20
Nothing to be done for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp;=20
drivers<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make -C =
block<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make =
-C=20
cdrom<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make =
-C=20
char<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make -C =
agp<BR>make[4]:=20
Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'<BR>ld -m =
elf_i386&nbsp;=20
-r -o agpgart.o agpgart_fe.o agpgart_be.o<BR>rm -f agp.o<BR>ld -m =
elf_i386&nbsp;=20
-r -o agp.o agpgart.o<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/agp'<BR>make -C=20
drm<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>ld -m =
elf_i386 -r -o=20
tdfx.o tdfx_drv.o<BR>ld -m elf_i386 -r -o radeon.o radeon_drv.o =
radeon_cp.o=20
radeon_state.o<BR>ld -m elf_i386 -r -o i810.o i810_drv.o =
i810_dma.o<BR>rm -f=20
drm.o<BR>ld -m elf_i386&nbsp; -r -o drm.o tdfx.o radeon.o =
i810.o<BR>make[5]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make -C=20
pcmcia<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[5]: =
Nothing=20
to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make[3]: Leaving =

directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make =
-C=20
hotplug<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make[4]: =
Nothing to=20
be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make[3]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make -C=20
ide<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>ld -m elf_i386 -r =
-o=20
ide-mod.o ide.o ide-features.o ide-taskfile.o&nbsp; cmd640.o ide-adma.o=20
ide-dma.o ide-pci.o piix.o rz1000.o ide-proc.o<BR>ld -m elf_i386 -r -o=20
ide-probe-mod.o ide-probe.o ide-geometry.o<BR>rm -f idedriver.o<BR>ld -m =

elf_i386&nbsp; -r -o idedriver.o ide-mod.o ide-probe-mod.o ide-disk.o=20
ide-cd.o<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make -C =

media<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make -C=20
radio<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make[5]: =
Nothing=20
to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make -C=20
video<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[5]: =
Nothing=20
to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make =
-C=20
misc<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make[3]: Leaving =

directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make =
-C=20
net<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make -C=20
pcmcia<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[5]: =
Nothing=20
to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make -C =

parport<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make[4]: =
Nothing to=20
be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make[3]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make -C=20
pci<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pci'<BR>make -C =

pcmcia<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pcmcia'<BR>make =
-C=20
pnp<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>ld -m =
elf_i386&nbsp; -r=20
-o isa-pnp.o isapnp.o quirks.o isapnp_proc.o<BR>rm -f pnp.o<BR>ld -m=20
elf_i386&nbsp; -r -o pnp.o isa-pnp.o<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make -C =

scsi<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make -C=20
pcmcia<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[5]: =
Nothing=20
to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>ld -m elf_i386 =
-r -o=20
scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o scsi_proc.o =

scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o scsi_merge.o =
scsi_dma.o=20
scsi_scan.o scsi_syms.o<BR>ld -m elf_i386 -r -o sd_mod.o sd.o<BR>rm -f=20
scsidrv.o<BR>ld -m elf_i386&nbsp; -r -o scsidrv.o scsi_mod.o sym53c8xx.o =

sd_mod.o<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make[3]: Leaving =

directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make =
-C=20
sound<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>ld -m elf_i386 =
-r -o=20
soundcore.o sound_core.o sound_firmware.o<BR>rm -f sounddrivers.o<BR>ld =
-m=20
elf_i386&nbsp; -r -o sounddrivers.o soundcore.o es1371.o=20
ac97_codec.o<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make =
-C=20
usb<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make -C=20
storage<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'<BR>make=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'<BR>ld -m =
elf_i386 -r=20
-o usb-storage.o scsiglue.o protocol.o transport.o usb.o =
initializers.o<BR>rm -f=20
storage.o<BR>ld -m elf_i386&nbsp; -r -o storage.o =
usb-storage.o<BR>make[5]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb/storage'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>ld -m elf_i386 -r =
-o=20
usbcore.o usb.o usb-debug.o hub.o hcd.o<BR>rm -f usbdrv.o<BR>ld -m=20
elf_i386&nbsp; -r -o usbdrv.o usbcore.o uhci.o =
storage/storage.o<BR>make[4]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make -C =

video<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make[3]: Nothing to =
be done=20
for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp; =
mm<BR>make[2]:=20
Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make[3]: Nothing to be =
done for=20
`all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make[2]: Leaving directory =

`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp; =
fs<BR>make[2]:=20
Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make -C =

autofs4<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/autofs4'<BR>make -C =
devpts<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/devpts'<BR>make -C =
ext2<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ext2'<BR>make -C =
isofs<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/isofs'<BR>make -C =
lockd<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/lockd'<BR>make -C =
nfs<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'<BR>make[4]: Nothing to be =
done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfs'<BR>make -C =
nfsd<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/nfsd'<BR>make -C=20
partitions<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'<BR>make[4]: =
Nothing to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/fs/partitions'<BR>make =
-C=20
proc<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'<BR>make =
all_targets<BR>make[4]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'<BR>make[4]:=20
Nothing to be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/proc'<BR>make -C =
ramfs<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs/ramfs'<BR>make =
all_targets<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make[3]:=20
Nothing to be done for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make[2]: Leaving directory =

`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp; =
net<BR>make[2]:=20
Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make =
-C=20
802<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'<BR>make =
all_targets<BR>make[4]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'<BR>make[4]:=20
Nothing to be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/802'<BR>make -C =
core<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make -C =
ethernet<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'<BR>make[3]: Leaving =

directory `/home/Devesh/Programs/SELinux/lsm-2.4/net/ethernet'<BR>make =
-C=20
ipv4<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make =
all_targets<BR>make[4]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make[4]:=20
Nothing to be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make -C=20
ipv4/netfilter<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make[4]: =
Nothing=20
to be done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make[3]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make -C=20
netlink<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make[3]: Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make -C =

packet<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/packet'<BR>make -C =
sched<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make -C =
sunrpc<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'<BR>make[4]: Nothing =
to be=20
done for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sunrpc'<BR>make -C =
unix<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'<BR>make[4]: Nothing to =
be done=20
for `all_targets'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'<BR>make[3]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/unix'<BR>make =
all_targets<BR>make[3]:=20
Entering directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make[3]:=20
Nothing to be done for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp; =
ipc<BR>make[2]:=20
Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make[3]: Nothing to be =
done for=20
`all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp; =
lib<BR>make[2]:=20
Entering directory `/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make[3]: Nothing to be =
done for=20
`all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp;=20
security<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make -C =
selinux<BR>make[3]:=20
Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'<BR>make -C=20
arch/i386<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e=20
all_targets<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e[5]:=20
Nothing to be done for `all_targets'.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e[4]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e -C=20
flask<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/flask'<BR>make[4]=
:=20
Nothing to be done for `all'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/flask'<BR>make =
-C=20
ss<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'<BR>make[4]: =
Nothing=20
to be done for `all'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'<BR>make=20
all_targets<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'<BR>make -C =
arch/i386=20
security.o<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e[5]:=20
`security.o' is up to date.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/arch/i386'<BR>mak=
e -C ss=20
ss.o<BR>make[5]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'<BR>make[5]: =
`ss.o'=20
is up to date.<BR>make[5]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux/ss'<BR>make[4]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'<BR>make[3]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security/selinux'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make[3]: Nothing to =
be done=20
for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make =
CFLAGS=3D"-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -Wall =
-Wstrict-prototypes=20
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di686&nbsp;&nbsp; " -C&nbsp;=20
arch/i386/kernel<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make[2]: =
Nothing to=20
be done for `all'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
" -C&nbsp; arch/i386/mm<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make[3]: Nothing =
to be=20
done for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make[2]: Leaving =

directory `/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make=20
CFLAGS=3D"-D__KERNEL__ -I/home/Devesh/Programs/SELinux/lsm-2.4/include =
-Wall=20
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=20
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 =
-march=3Di686&nbsp;&nbsp;=20
" -C&nbsp; arch/i386/lib<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make=20
all_targets<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make[3]: =
Nothing to be=20
done for `all_targets'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make[2]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>ld -m =

elf_i386 -T /home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/vmlinux.lds =
-e stext=20
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o =
init/version.o=20
init/do_mounts.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
--start-group=20
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
arch/i386/kernel/kernel.o=20
arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o=20
security/vmlinux-obj.o =
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o =
drivers/net/net.o=20
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o=20
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o=20
drivers/sound/sounddrivers.o drivers/pci/driver.o =
drivers/pcmcia/pcmcia.o=20
drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o drivers/video/video.o=20
drivers/usb/usbdrv.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
net/network.o \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib/lib.a=20
/home/Devesh/Programs/SELinux/lsm-2.4/lib/lib.a=20
/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib/lib.a=20
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --end-group=20
\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o vmlinux<BR>nm vmlinux =
| grep=20
-v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | =
sort=20
&gt; System.map<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot'<BR>gcc -E =
-D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -D__BIG_KERNEL__ =
-traditional=20
-DSVGA_MODE=3DNORMAL_VGA&nbsp; bootsect.S -o bbootsect.s<BR>as -o =
bbootsect.o=20
bbootsect.s<BR>bbootsect.s: Assembler messages:<BR>bbootsect.s:256: =
Warning:=20
indirect lcall without `*'<BR>ld -m elf_i386 -Ttext 0x0 -s --oformat =
binary=20
bbootsect.o -o bbootsect<BR>gcc -E -D__KERNEL__=20
-I/home/Devesh/Programs/SELinux/lsm-2.4/include -D__BIG_KERNEL__ =
-D__ASSEMBLY__=20
-traditional -DSVGA_MODE=3DNORMAL_VGA&nbsp; setup.S -o bsetup.s<BR>as -o =
bsetup.o=20
bsetup.s<BR>bsetup.s: Assembler messages:<BR>bsetup.s:1456: Warning: =
indirect=20
lcall without `*'<BR>ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e =
begtext -o=20
bsetup bsetup.o<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot/compressed'<BR>tmpp=
iggy=3D_tmp_$$piggy;=20
\<BR>rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \<BR>objcopy -O binary =
-R .note=20
-R .comment -S /home/Devesh/Programs/SELinux/lsm-2.4/vmlinux $tmppiggy;=20
\<BR>gzip -f -9 &lt; $tmppiggy &gt; $tmppiggy.gz; \<BR>echo "SECTIONS { =
.data :=20
{ input_len =3D .; LONG(input_data_end - input_data) input_data =3D .; =
*(.data)=20
input_data_end =3D .; }}" &gt; $tmppiggy.lnk; \<BR>ld -m elf_i386 -r -o =
piggy.o -b=20
binary $tmppiggy.gz -b elf32-i386 -T $tmppiggy.lnk; \<BR>rm -f $tmppiggy =

$tmppiggy.gz $tmppiggy.lnk<BR>ld -m elf_i386 -Ttext 0x100000 -e =
startup_32 -o=20
bvmlinux head.o misc.o piggy.o<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot/compressed'<BR>objc=
opy -O=20
binary -R .note -R .comment -S compressed/bvmlinux=20
compressed/bvmlinux.out<BR>tools/build -b bbootsect bsetup=20
compressed/bvmlinux.out CURRENT &gt; bzImage<BR>Root device is (3, =
5)<BR>Boot=20
sector 512 bytes.<BR>Setup is 2541 bytes.<BR>System is 1158 =
kB<BR>warning:=20
kernel is too big for standalone boot from floppy<BR>sh -x ./install.sh=20
2.4.20-selinux bzImage /home/Devesh/Programs/SELinux/lsm-2.4/System.map =
""<BR>+=20
'[' -x /root/bin/installkernel ']'<BR>+ '[' -x /sbin/installkernel =
']'<BR>+ exec=20
/sbin/installkernel 2.4.20-selinux bzImage=20
/home/Devesh/Programs/SELinux/lsm-2.4/System.map ''<BR>make[2]: Leaving=20
directory =
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/boot'<BR>make[1]:=20
Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4'<BR>make[1]: =
Entering=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4'<BR>make -C&nbsp; =
kernel=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make[2]: Nothing to be =
done=20
for `modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/kernel'<BR>make -C&nbsp; drivers=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make -C block=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make[3]: =
Nothing to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/block'<BR>make -C cdrom=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make[3]: =
Nothing to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/cdrom'<BR>make -C char=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make -C drm=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make[4]: =
Nothing to=20
be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/drm'<BR>make -C =
pcmcia=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/char'<BR>make =
-C=20
hotplug modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make[3]: =
Nothing to=20
be done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/hotplug'<BR>make -C ide=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make[3]: Nothing =
to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/ide'<BR>make -C media=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make -C radio=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make[4]: =
Nothing=20
to be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/radio'<BR>make -C =
video=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[4]: =
Nothing=20
to be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media/video'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/media'<BR>make =
-C misc=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make[3]: Nothing =
to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/misc'<BR>make -C net=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>mkdir -p=20
/lib/modules/2.4.20-selinux/kernel/drivers/net/<BR>cp dummy.o=20
/lib/modules/2.4.20-selinux/kernel/drivers/net/<BR>make -C pcmcia=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/net'<BR>make -C =
parport=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make[3]: =
Nothing to=20
be done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/parport'<BR>make -C pnp=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make[3]: Nothing =
to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/pnp'<BR>make -C scsi=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make -C pcmcia=20
modules_install<BR>make[4]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[4]: =
Nothing=20
to be done for `modules_install'.<BR>make[4]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi/pcmcia'<BR>make[3]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers/scsi'<BR>make =
-C sound=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make[3]: =
Nothing to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/sound'<BR>make -C usb=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make[3]: Nothing =
to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/usb'<BR>make -C video=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[3]: =
Nothing to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/drivers/video'<BR>make[2]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/lsm-2.4/drivers'<BR>make =
-C&nbsp; mm=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make[2]: Nothing to be =
done for=20
`modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/mm'<BR>make -C&nbsp; fs=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make[2]: Nothing to be =
done for=20
`modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/fs'<BR>make -C&nbsp; net=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make -C core=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make[3]: Nothing to =
be done=20
for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/core'<BR>make -C ipv4=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make[3]: Nothing to =
be done=20
for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4'<BR>make -C =
ipv4/netfilter=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make[3]: =
Nothing=20
to be done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/ipv4/netfilter'<BR>make -C =
netlink=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make[3]: Nothing =
to be=20
done for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/netlink'<BR>make -C sched=20
modules_install<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[3]: Nothing to =
be done=20
for `modules_install'.<BR>make[3]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net/sched'<BR>make[2]: Leaving =
directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/net'<BR>make -C&nbsp; ipc=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make[2]: Nothing to be =
done for=20
`modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/ipc'<BR>make -C&nbsp; lib=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make[2]: Nothing to be =
done for=20
`modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/lib'<BR>make -C&nbsp; security=20
modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make[2]: Nothing to =
be done=20
for `modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/security'<BR>make -C&nbsp;=20
arch/i386/kernel modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make[2]: =
Nothing to=20
be done for `modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/kernel'<BR>make =
-C&nbsp;=20
arch/i386/mm modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make[2]: Nothing =
to be=20
done for `modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/mm'<BR>make -C&nbsp;=20
arch/i386/lib modules_install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>make[2]: =
Nothing to be=20
done for `modules_install'.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/lsm-2.4/arch/i386/lib'<BR>cd=20
/lib/modules/2.4.20-selinux; \<BR>mkdir -p pcmcia; \<BR>find kernel =
-path=20
'*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia<BR>if [ -r =
System.map=20
]; then /sbin/depmod -ae -F System.map&nbsp; 2.4.20-selinux; =
fi<BR>make[1]:=20
Leaving directory `/home/Devesh/Programs/SELinux/lsm-2.4'<BR>Building =
and=20
installing support files needed by the userland components.<BR>cd module =

&amp;&amp; make install LSMVER=3D-2.4<BR>make[1]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/module'<BR>make -C checkpolicy=20
LSMDIR=3D../../../lsm-2.4<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'<BR>make[2]:=20
`checkpolicy' is up to date.<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'<BR>mkdir -p=20
/usr/local/selinux/flask<BR>mkdir -p=20
/usr/local/selinux/include/linux/flask<BR>mkdir -p=20
/usr/local/selinux/include/asm-i386/flask<BR>mkdir -p=20
/usr/local/selinux/bin<BR>( cd /usr/local/selinux/include; ln -sf =
asm-i386=20
asm)<BR>cd ../../lsm-2.4/security/selinux/flask; install -m 644 =
access_vectors=20
security_classes initial_sids /usr/local/selinux/flask<BR>cd=20
./../lsm-2.4/security/selinux/include/linux/flask; install -m 644 *.h=20
/usr/local/selinux/include/linux/flask<BR>cd=20
./../lsm-2.4/security/selinux/include/asm/flask; [ -f unistd.h ] =
&amp;&amp;=20
install -m 644 unistd.h /usr/local/selinux/include/asm/flask ; =
true<BR>cd=20
./../lsm-2.4/include/asm; install -m 644 unistd.h=20
/usr/local/selinux/include/asm<BR>cd ../../lsm-2.4/include/linux; =
install -m 644=20
version.h /usr/local/selinux/include/linux<BR>make -C checkpolicy=20
install<BR>make[2]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'<BR>install -m =
755=20
checkpolicy /usr/local/selinux/bin<BR>make[2]: Leaving directory=20
`/home/Devesh/Programs/SELinux/selinux/module/checkpolicy'<BR>make[1]: =
Leaving=20
directory `/home/Devesh/Programs/SELinux/selinux/module'<BR>Building and =

installing the policy configuration.<BR>cd tools &amp;&amp; make=20
insert-policy<BR>make[1]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/tools'<BR>make[2]: Entering =
directory=20
`/home/Devesh/Programs/SELinux/selinux/tools/setools'<BR>cd seuser ; =
make=20
insert-policy<BR>make[3]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/tools/setools/seuser'<BR>install =
-m 644=20
./policy/seuser.te=20
/home/Devesh/Programs/SELinux/selinux/tools/../policy/domains/program<BR>=
install=20
-m 644 ../policy/seuser.fc=20
/home/Devesh/Programs/SELinux/selinux/tools/../policy/file_contexts/progr=
am<BR>make[3]:=20
Leaving directory=20
`/home/Devesh/Programs/SELinux/selinux/tools/setools/seuser'<BR>make[2]: =
Leaving=20
directory =
`/home/Devesh/Programs/SELinux/selinux/tools/setools'<BR>make[1]:=20
Leaving directory `/home/Devesh/Programs/SELinux/selinux/tools'<BR>cd =
policy=20
&amp;&amp; make install-src install<BR>make[1]: Entering directory=20
`/home/Devesh/Programs/SELinux/selinux/policy'<BR>rm -rf=20
/etc/security/selinux/src/policy.old<BR>mv =
/etc/security/selinux/src/policy=20
/etc/security/selinux/src/policy.old<BR>mv: cannot stat=20
`/etc/security/selinux/src/policy': No such file or =
directory<BR>make[1]: ***=20
[install-src] Error 1<BR>make[1]: Leaving directory=20
`/home/Devesh/Programs/SELinux/selinux/policy'<BR>make: *** =
[quickinstall] Error=20
2<BR></DIV></DIV></BODY></HTML>

------=_NextPart_000_0043_01C2DA90.2FCA0630--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
