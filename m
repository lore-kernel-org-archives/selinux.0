Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MIjurT004033
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 14:45:56 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MIjtWF021598
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 18:45:55 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i8MIkt3k001153
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 14:46:55 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i8MIktIc001152
	for selinux@tycho.nsa.gov; Wed, 22 Sep 2004 14:46:55 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MIOQrT003857
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 14:24:26 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MIONWF020732
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 18:24:24 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4A0D1.DCAC4B80"
Subject: SELinux  Doesn't Complete Initialization
Date: Wed, 22 Sep 2004 14:27:48 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B1DADF@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4A0D1.DCAC4B80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm working on a master's thesis on SELinux and I'm trying to get it up =
and running on my home server.  I am able to compile, install, and load =
the policy via "make load" in the policy source directory, however I'm =
unable to get it to come all the way up on a boot.  On my last go, I set =
the contexts for the filesystems using the "make relabel" function call. =
 There is never an "SELinux: Initialization Complete" message and the =
system defaults to SELinux disabled.  Any help would be greatly =
appreciated.  Here are the details.

Fedora Core 2
2.6.8-1.521
checkpolicy-1.17.5-1
policycoreutils-1.17.5-3
libselinux-1.17.13-1
selinux-policy-strict-1.17.19-2
selinux-policy-strict-sources-1.17.19-2

/boot/grub/grub.conf:
default=3D0
timeout=3D10
splashimage=3D(hd0,0)/grub/splash.xpm.gz

title SELinux (2.6.8-1.521)
        root (hd0,0)
        kernel /vmlinuz-2.6.8-1.521 ro root=3DLABEL=3D/ quiet vga=3D792 =
selinux=3D1 enforcing=3D0
        initrd /initrd-2.6.8-1.521.img

/etc/sysconfig/selinux -> /etc/selinux/config:
# This file controls the state of SELinux on the system.
# SELINUX=3D can take one of these three values:
#       enforcinfg - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=3Dpermissive
                                                                         =
      =20
# SELINUXTYPE=3D can take one of these two values:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=3Dstrict

Here is what the boot logs state:
Sep 22 13:57:20 seth syslogd 1.4.1: restart.
Sep 22 13:57:20 seth syslog: syslogd startup succeeded
Sep 22 13:57:20 seth kernel: klogd 1.4.1, log source =3D /proc/kmsg =
started.
Sep 22 13:57:20 seth kernel: Linux version 2.6.8-1.521 =
(bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat =
Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004
Sep 22 13:57:20 seth kernel: BIOS-provided physical RAM map:
Sep 22 13:57:20 seth kernel:  BIOS-e820: 0000000000000000 - =
000000000009fc00 (usable)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 000000000009fc00 - =
00000000000a0000 (reserved)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 00000000000f0000 - =
0000000000100000 (reserved)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 0000000000100000 - =
000000003fff0000 (usable)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 000000003fff0000 - =
000000003fff8000 (ACPI data)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 000000003fff8000 - =
0000000040000000 (ACPI NVS)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 00000000fec00000 - =
00000000fec01000 (reserved)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 00000000fee00000 - =
00000000fee01000 (reserved)
Sep 22 13:57:20 seth kernel:  BIOS-e820: 00000000fff00000 - =
0000000100000000 (reserved)
Sep 22 13:57:20 seth syslog: klogd startup succeeded
Sep 22 13:57:20 seth kernel: 0MB HIGHMEM available.
Sep 22 13:57:20 seth kernel: 1023MB LOWMEM available.
Sep 22 13:57:20 seth kernel: zapping low mappings.
Sep 22 13:57:20 seth kernel: DMI 2.3 present.
Sep 22 13:57:20 seth kernel: ACPI: RSDP (v000 AMI         ) @ 0x000fa6a0
Sep 22 13:57:20 seth kernel: ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 =
MSFT 0x00000097) @ 0x3fff0000
Sep 22 13:57:20 seth kernel: ACPI: FADT (v001 AMIINT INTEL875 0x00000011 =
MSFT 0x00000097) @ 0x3fff0030
Sep 22 13:57:20 seth kernel: ACPI: MADT (v001 AMIINT INTEL875 0x00000009 =
MSFT 0x00000097) @ 0x3fff00c0
Sep 22 13:57:20 seth kernel: ACPI: DSDT (v001  INTEL     I875 0x00001000 =
MSFT 0x0100000d) @ 0x00000000
Sep 22 13:57:20 seth kernel: ACPI: PM-Timer IO Port: 0x808
Sep 22 13:57:20 seth kernel: Built 1 zonelists
Sep 22 13:57:20 seth kernel: Kernel command line: ro root=3DLABEL=3D/ =
quiet vga=3D792 selinux=3D1 enforcing=3D0
 Sep 22 13:57:20 seth kernel: mapped 4G/4G trampoline to ffff3000.
Sep 22 13:57:20 seth kernel: Initializing CPU#0
Sep 22 13:57:20 seth kernel: CPU 0 irqstacks, hard=3D023c7000 =
soft=3D023c6000
Sep 22 13:57:20 seth kernel: PID hash table entries: 4096 (order 12: =
32768 bytes)
Sep 22 13:57:20 seth kernel: Detected 2400.985 MHz processor.
Sep 22 13:57:20 seth kernel: Using tsc for high-res timesource
Sep 22 13:57:20 seth irqbalance: irqbalance startup succeeded
Sep 22 13:57:20 seth kernel: Console: colour dummy device 80x25
Sep 22 13:57:20 seth kernel: Dentry cache hash table entries: 131072 =
(order: 7, 524288 bytes)
Sep 22 13:57:20 seth kernel: Inode-cache hash table entries: 131072 =
(order: 7, 524288 bytes)
Sep 22 13:57:20 seth kernel: Memory: 1034960k/1048512k available (2012k =
kernel code, 12764k reserved, 651k data, 140k init, 0k highmem)
Sep 22 13:57:20 seth kernel: Calibrating delay loop... 4734.97 BogoMIPS
Sep 22 13:57:20 seth kernel: Security Scaffold v1.0.0 initialized
Sep 22 13:57:20 seth kernel: SELinux:  Initializing.
Sep 22 13:57:20 seth kernel: SELinux:  Starting in permissive mode
Sep 22 13:57:20 seth kernel: There is already a security framework =
initialized, register_security failed.
Sep 22 13:57:20 seth kernel: selinux_register_security:  Registering =
secondary module capability
Sep 22 13:57:20 seth kernel: Capability LSM initialized as secondary
Sep 22 13:57:20 seth kernel: Mount-cache hash table entries: 512 (order: =
0, 4096 bytes)
Sep 22 13:57:20 seth kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Sep 22 13:57:20 seth kernel: CPU: L2 cache: 512K
Sep 22 13:57:20 seth kernel: Intel machine check architecture supported.
Sep 22 13:57:20 seth kernel: Intel machine check reporting enabled on =
CPU#0.
Sep 22 13:57:20 seth kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) =
available
Sep 22 13:57:20 seth kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz =
stepping 04
Sep 22 13:57:20 seth kernel: Enabling fast FPU save and restore... done.
Sep 22 13:57:20 seth kernel: Enabling unmasked SIMD FPU exception =
support... done.
Sep 22 13:57:20 seth kernel: Checking 'hlt' instruction... OK.
Sep 22 13:57:20 seth kernel: checking if image is initramfs...it isn't =
(no cpio magic); looks like an initrd
Sep 22 13:57:20 seth kernel: Freeing initrd memory: 187k freed
Sep 22 13:57:20 seth kernel: NET: Registered protocol family 16
Sep 22 13:57:20 seth kernel: PCI: PCI BIOS revision 2.10 entry at =
0xfdb81, last bus=3D3
Sep 22 13:57:20 seth kernel: PCI: Using configuration type 1
Sep 22 13:57:20 seth kernel: mtrr: v2.0 (20020519)
Sep 22 13:57:20 seth kernel: ACPI: Subsystem revision 20040326
Sep 22 13:57:20 seth portmap: portmap startup succeeded
Sep 22 13:57:20 seth kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Sep 22 13:57:20 seth kernel: ACPI: Interpreter enabled
Sep 22 13:57:20 seth kernel: ACPI: Using PIC for interrupt routing
Sep 22 13:57:20 seth kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep 22 13:57:20 seth kernel: PCI: Probing PCI hardware (bus 00)
Sep 22 13:57:20 seth kernel: PCI: Ignoring BAR0-3 of IDE controller =
0000:00:1f.1Sep 22 13:57:20 seth kernel: PCI: Transparent bridge - =
0000:00:1e.0
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [URP1] (off)
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [URP2] (off)
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [FDDP] (off)
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [LPTP] (off)
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 =
6 7 10 *11 12 14 15)
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 =
6 7 10 *11 12 14 15)
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 =
*5 6 7 10 11 12 14 15)
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 =
5 6 7 10 11 12 14 15)
Sep 22 13:57:20 seth rpc.statd[1616]: Version 1.0.6 Starting
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 =
6 7 10 11 12 14 15) *0, disabled.
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 =
*5 6 7 10 11 12 14 15)
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 =
6 7 10 11 12 14 15) *0, disabled.
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 =
6 7 *10 11 12 14 15)
Sep 22 13:57:20 seth kernel: Linux Plug and Play Support v0.97 (c) Adam =
Belay
Sep 22 13:57:21 seth kernel: usbcore: registered new driver usbfs
Sep 22 13:57:21 seth kernel: usbcore: registered new driver hub
Sep 22 13:57:21 seth nfslock: rpc.statd startup succeeded
Sep 22 13:57:21 seth kernel: PCI: Using ACPI for IRQ routing
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKA] enabled at =
IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKD] enabled at =
IRQ 3
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI =
3 (level, low) -> IRQ 3
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKC] enabled at =
IRQ 5
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKH] enabled at =
IRQ 10
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI =
10 (level, low) -> IRQ 10
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKB] enabled at =
IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKF] enabled at =
IRQ 5
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:03:09.0[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:21 seth kernel: vesafb: framebuffer at 0xe8000000, mapped =
to 0x42807000, size 6144k
Sep 22 13:57:21 seth kernel: vesafb: mode is 1024x768x32, =
linelength=3D4096, pages=3D1
Sep 22 13:57:21 seth kernel: vesafb: protected mode interface info at =
c000:c530
Sep 22 13:57:21 seth kernel: vesafb: scrolling: redraw
Sep 22 13:57:21 seth kernel: vesafb: directcolor: size=3D8:8:8:8, =
shift=3D24:16:8:0
Sep 22 13:57:21 seth kernel: fb0: VESA VGA frame buffer device
Sep 22 13:57:21 seth kernel: apm: BIOS version 1.2 Flags 0x03 (Driver =
version 1.16ac)
Sep 22 13:57:21 seth kernel: apm: overridden by ACPI.
Sep 22 13:57:21 seth kernel: audit: initializing netlink socket =
(disabled)
Sep 22 13:57:21 seth kernel: audit(1095861409.645:0): initialized
Sep 22 13:57:21 seth kernel: Total HugeTLB memory allocated, 0
Sep 22 13:57:21 seth kernel: VFS: Disk quotas dquot_6.5.1
Sep 22 13:57:21 seth kernel: Dquot-cache hash table entries: 1024 (order =
0, 4096 bytes)
Sep 22 13:57:22 seth kernel: SELinux:  Registering netfilter hooks
Sep 22 13:57:22 seth kernel: Initializing Cryptographic API
Sep 22 13:57:22 seth kernel: ksign: Installing public key data
Sep 22 13:57:17 seth sysctl: kernel.core_uses_pid =3D 1
Sep 22 13:57:22 seth kernel: Loading keyring
Sep 22 13:57:17 seth network: Setting network parameters:  succeeded
Sep 22 13:57:22 seth kernel: - Added public key 9488DB81FF525AA3
Sep 22 13:57:17 seth network: Bringing up loopback interface:  succeeded
Sep 22 13:57:22 seth kernel: - User ID: Red Hat, Inc. (Kernel Module GPG =
key)
Sep 22 13:57:22 seth kernel: ksign: invalid packet (ctb=3D00)
Sep 22 13:57:22 seth kernel: Unable to load default keyring: error=3D74
Sep 22 13:57:22 seth kernel: pci_hotplug: PCI Hot Plug PCI Core version: =
0.5
Sep 22 13:57:22 seth kernel: ACPI: Processor [CPU1] (supports C1, 8 =
throttling states)
Sep 22 13:57:23 seth kernel: isapnp: Scanning for PnP cards...
Sep 22 13:57:23 seth kernel: isapnp: No Plug & Play device found
Sep 22 13:57:23 seth kernel: Console: switching to colour frame buffer =
device 128x48
Sep 22 13:57:23 seth kernel: Real Time Clock Driver v1.12
Sep 22 13:57:23 seth kernel: Linux agpgart interface v0.100 (c) Dave =
Jones
Sep 22 13:57:23 seth kernel: agpgart: Detected an Intel i875 Chipset.
Sep 22 13:57:23 seth kernel: agpgart: Maximum main memory to use for agp =
memory: 941M
Sep 22 13:57:23 seth kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Sep 22 13:57:23 seth kernel: Serial: 8250/16550 driver $Revision: 1.90 $ =
8 ports, IRQ sharing enabled
Sep 22 13:57:24 seth kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Sep 22 13:57:24 seth kernel: RAMDISK driver initialized: 16 RAM disks of =
16384K size 1024 blocksize
Sep 22 13:57:24 seth kernel: Uniform Multi-Platform E-IDE driver =
Revision: 7.00alpha2
Sep 22 13:57:24 seth kernel: ide: Assuming 33MHz system bus speed for =
PIO modes; override with idebus=3Dxx
Sep 22 13:57:24 seth kernel: ICH5: IDE controller at PCI slot =
0000:00:1f.1
Sep 22 13:57:24 seth kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> =
0007)
Sep 22 13:57:25 seth kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:25 seth kernel: ICH5: chipset revision 2
Sep 22 13:57:25 seth kernel: ICH5: not 100%% native mode: will probe =
irqs later
Sep 22 13:57:25 seth kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS =
settings: hda:DMA, hdb:pio
Sep 22 13:57:25 seth kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS =
settings: hdc:DMA, hdd:pio
Sep 22 13:57:25 seth kernel: hda: IC35L120AVVA07-0, ATA DISK drive
Sep 22 13:57:25 seth kernel: Using cfq io scheduler
Sep 22 13:57:25 seth kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 22 13:57:25 seth kernel: hdc: Compaq DVD-ROM DVD-117, ATAPI =
CD/DVD-ROM driveSep 22 13:57:25 seth kernel: ide1 at 0x170-0x177,0x376 =
on irq 15
Sep 22 13:57:25 seth kernel: hda: max request size: 128KiB
Sep 22 13:57:25 seth kernel: hda: 241254720 sectors (123522 MB) =
w/1863KiB Cache, CHS=3D65535/16/63, UDMA(100)
Sep 22 13:57:25 seth kernel:  hda: hda1 hda2 hda3
Sep 22 13:57:26 seth kernel: hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, =
UDMA(44)Sep 22 13:57:26 seth kernel: Uniform CD-ROM driver Revision: =
3.20
Sep 22 13:57:26 seth kernel: ide-floppy driver 0.99.newide
Sep 22 13:57:26 seth kernel: usbcore: registered new driver hiddev
Sep 22 13:57:26 seth kernel: usbcore: registered new driver usbhid
Sep 22 13:57:26 seth kernel: drivers/usb/input/hid-core.c: v2.0:USB HID =
core driver
Sep 22 13:57:26 seth kernel: mice: PS/2 mouse device common for all mice
Sep 22 13:57:26 seth kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 22 13:57:26 seth kernel: input: ImPS/2 Generic Wheel Mouse on =
isa0060/serio1Sep 22 13:57:26 seth kernel: serio: i8042 KBD port at =
0x60,0x64 irq 1
Sep 22 13:57:26 seth kernel: input: AT Translated Set 2 keyboard on =
isa0060/serio0
Sep 22 13:57:26 seth kernel: md: md driver 0.90.0 MAX_MD_DEVS=3D256, =
MD_SB_DISKS=3D27
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 2
Sep 22 13:57:27 seth kernel: IP: routing cache hash table of 2048 =
buckets, 64Kbytes
Sep 22 13:57:27 seth kernel: TCP: Hash tables configured (established =
262144 bind 37449)
Sep 22 13:57:27 seth kernel: Initializing IPsec netlink socket
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 1
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 17
Sep 22 13:57:27 seth kernel: ACPI: (supports S0 S1 S4 S5)
Sep 22 13:57:27 seth kernel: md: Autodetecting RAID arrays.
Sep 22 13:57:27 seth kernel: md: autorun ...
Sep 22 13:57:27 seth kernel: md: ... autorun DONE.
Sep 22 13:57:27 seth kernel: RAMDISK: Compressed image found at block 0
Sep 22 13:57:27 seth kernel: VFS: Mounted root (ext2 filesystem).
Sep 22 13:57:27 seth kernel: EXT3-fs: INFO: recovery required on =
readonly filesystem.
Sep 22 13:57:27 seth kernel: EXT3-fs: write access will be enabled =
during recovery.
Sep 22 13:57:27 seth kernel: kjournald starting.  Commit interval 5 =
seconds
Sep 22 13:57:28 seth kernel: EXT3-fs: hda2: orphan cleanup on readonly =
fs
Sep 22 13:57:28 seth kernel: EXT3-fs: hda2: 1 orphan inode deleted
Sep 22 13:57:28 seth kernel: EXT3-fs: recovery complete.
Sep 22 13:57:28 seth kernel: EXT3-fs: mounted filesystem with ordered =
data mode.Sep 22 13:57:28 seth kernel: Freeing unused kernel memory: =
140k freed
Sep 22 13:57:28 seth kernel: ACPI: Power Button (FF) [PWRF]
Sep 22 13:57:28 seth kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI =
10 (level, low) -> IRQ 10
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: irq 10, pci mem =
42e32c00
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: new USB bus =
registered, assigned bus number 1
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, =
EHCI 1.00, driver 2004-May-10
Sep 22 13:57:28 seth kernel: hub 1-0:1.0: USB hub found
Sep 22 13:57:28 seth kernel: hub 1-0:1.0: 8 ports detected
Sep 22 13:57:28 seth kernel: USB Universal Host Controller Interface =
driver v2.2
Sep 22 13:57:28 seth kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: irq 11, io base =
0000e000
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: new USB bus =
registered, assigned bus number 2
Sep 22 13:57:29 seth kernel: hub 2-0:1.0: USB hub found
Sep 22 13:57:29 seth kernel: hub 2-0:1.0: 2 ports detected
Sep 22 13:57:29 seth kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI =
3 (level, low) -> IRQ 3
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: irq 3, io base =
0000e400
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: new USB bus =
registered, assigned bus number 3
Sep 22 13:57:29 seth kernel: hub 3-0:1.0: USB hub found
Sep 22 13:57:29 seth kernel: hub 3-0:1.0: 2 ports detected
Sep 22 13:57:29 seth kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.2: irq 5, io base =
0000e800
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.2: new USB bus =
registered, assigned bus number 4
Sep 22 13:57:30 seth kernel: hub 4-0:1.0: USB hub found
Sep 22 13:57:30 seth kernel: hub 4-0:1.0: 2 ports detected
Sep 22 13:57:30 seth kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI =
11 (level, low) -> IRQ 11
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: irq 11, io base =
0000ec00
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: new USB bus =
registered, assigned bus number 5
Sep 22 13:57:30 seth kernel: hub 5-0:1.0: USB hub found
Sep 22 13:57:30 seth kernel: hub 5-0:1.0: 2 ports detected
Sep 22 13:57:30 seth kernel: EXT3 FS on hda2, internal journal
Sep 22 13:57:30 seth kernel: device-mapper: 4.1.0-ioctl (2003-12-10) =
initialised: dm@uk.sistina.com
Sep 22 13:57:30 seth kernel: cdrom: open failed.
Sep 22 13:57:30 seth kernel: Adding 2040244k swap on /dev/hda3.  =
Priority:-1 extents:1
Sep 22 13:57:30 seth kernel: kjournald starting.  Commit interval 5 =
seconds
Sep 22 13:57:31 seth kernel: EXT3 FS on hda1, internal journal
Sep 22 13:57:31 seth kernel: EXT3-fs: mounted filesystem with ordered =
data mode.Sep 22 13:57:31 seth kernel: IA-32 Microcode Update Driver: =
v1.14 <tigran@veritas.com>
Sep 22 13:57:31 seth kernel: microcode: No new microdata for cpu 0
Sep 22 13:57:31 seth kernel: parport0: PC-style at 0x378 (0x778) =
[PCSPP,TRISTATE,EPP]
Sep 22 13:57:31 seth kernel: parport0: irq 7 detected
Sep 22 13:57:31 seth kernel: SCSI subsystem initialized
Sep 22 13:57:31 seth kernel: inserting floppy driver for 2.6.8-1.521
Sep 22 13:57:31 seth kernel: Floppy drive(s): fd0 is 1.44M
Sep 22 13:57:31 seth kernel: FDC 0 is a post-1991 82077
Sep 22 13:57:31 seth kernel: ohci1394: $Rev: 1223 $ Ben Collins =
<bcollins@debian.org>
Sep 22 13:57:31 seth kernel: ACPI: PCI interrupt 0000:03:09.0[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:31 seth kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): =
IRQ=3D[5]  MMIO=3D[feaef800-feaeffff]  Max Packet=3D[2048]
Sep 22 13:57:32 seth kernel: e1000: Ignoring new-style parameters in =
presence of obsolete ones
Sep 22 13:57:32 seth kernel: Intel(R) PRO/1000 Network Driver - version =
5.2.52-k4
Sep 22 13:57:32 seth kernel: Copyright (c) 1999-2004 Intel Corporation.
Sep 22 13:57:32 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:32 seth kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 =
Network Connection
Sep 22 13:57:32 seth kernel: ip_tables: (C) 2000-2002 Netfilter core =
team
Sep 22 13:57:32 seth kernel: ip_conntrack version 2.1 (8191 buckets, =
65528 max) - 320 bytes per conntrack
Sep 22 13:57:32 seth kernel: e1000: Ignoring new-style parameters in =
presence of obsolete ones
Sep 22 13:57:32 seth kernel: Intel(R) PRO/1000 Network Driver - version =
5.2.52-k4
Sep 22 13:57:32 seth kernel: Copyright (c) 1999-2004 Intel Corporation.
Sep 22 13:57:32 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI =
5 (level, low) -> IRQ 5
Sep 22 13:57:32 seth kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 =
Network Connection
Sep 22 13:57:33 seth kernel: e1000: eth0: e1000_watchdog: NIC Link is Up =
100 Mbps Full Duplex
Sep 22 13:57:41 seth rpcidmapd: rpc.idmapd startup succeeded
Sep 22 13:57:41 seth random: Initializing random number generator:  =
succeeded
Sep 22 13:57:41 seth netfs: Mounting other filesystems:  succeeded
Sep 22 13:57:41 seth autofs: automount startup succeeded
Sep 22 13:57:41 seth smartd[1715]: smartd version 5.21 Copyright (C) =
2002-3 Bruce Allen
Sep 22 13:57:41 seth smartd[1715]: Home page is =
http://smartmontools.sourceforge.net/
Sep 22 13:57:41 seth smartd[1715]: Opened configuration file =
/etc/smartd.conf
Sep 22 13:57:41 seth smartd[1715]: Configuration file /etc/smartd.conf =
parsed.
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, opened
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, not found in smartd =
database.
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, is SMART capable. =
Adding to "monitor" list.
Sep 22 13:57:41 seth smartd[1715]: Monitoring 1 ATA and 0 SCSI devices
Sep 22 13:57:42 seth smartd[1717]: smartd has fork()ed into background =
mode. New PID=3D1717.
Sep 22 13:57:42 seth smartd: smartd startup succeeded
Sep 22 13:57:42 seth acpid: acpid startup succeeded
Sep 22 13:57:43 seth kernel: parport0: PC-style at 0x378 (0x778) =
[PCSPP,TRISTATE,EPP]
Sep 22 13:57:43 seth kernel: parport0: irq 7 detected
Sep 22 13:57:43 seth kernel: lp0: using parport0 (polling).
Sep 22 13:57:43 seth kernel: lp0: console ready
Sep 22 13:57:45 seth cups: cupsd startup succeeded
Sep 22 13:57:45 seth kernel: NET: Registered protocol family 10
Sep 22 13:57:45 seth kernel: Disabled Privacy Extensions on device =
0235c2a0(lo)
Sep 22 13:57:45 seth kernel: IPv6 over IPv4 tunneling driver
Sep 22 13:57:45 seth sshd:  succeeded
Sep 22 13:57:45 seth xinetd: xinetd startup succeeded
Sep 22 13:57:47 seth mysqld: Starting MySQL:  succeeded
Sep 22 13:57:47 seth xinetd[1966]: xinetd Version 2.3.13 started with =
libwrap loadavg options compiled in.
Sep 22 13:57:47 seth xinetd[1966]: Started working: 1 available service
Sep 22 13:57:47 seth sendmail: sendmail startup succeeded
Sep 22 13:57:48 seth sendmail: sm-client startup succeeded
Sep 22 13:57:48 seth gpm[2053]: *** info [startup.c(95)]:
Sep 22 13:57:48 seth gpm[2053]: Started gpm successfully. Entered daemon =
mode.
Sep 22 13:57:48 seth gpm[2053]: *** info [mice.c(1766)]:
Sep 22 13:57:48 seth gpm[2053]: imps2: Auto-detected intellimouse PS/2
Sep 22 13:57:48 seth gpm: gpm startup succeeded
Sep 22 13:57:50 seth httpd: httpd startup succeeded
Sep 22 13:57:51 seth su(pam_unix)[2079]: session opened for user =
postgres by (uid=3D0)
Sep 22 13:57:51 seth su(pam_unix)[2079]: session closed for user =
postgres
Sep 22 13:57:52 seth postgresql: Starting postgresql service:  succeeded
Sep 22 13:57:52 seth crond: crond startup succeeded
Sep 22 13:57:53 seth xfs: xfs startup succeeded
Sep 22 13:57:53 seth anacron: anacron startup succeeded
Sep 22 13:57:53 seth atd: atd startup succeeded
Sep 22 13:57:53 seth saslauthd[2185]: detach_tty      : master pid is: =
2185
Sep 22 13:57:53 seth saslauthd[2185]: ipc_init        : listening on =
socket: /var/run/saslauthd/mux
Sep 22 13:57:53 seth saslauthd: saslauthd startup succeeded
Sep 22 13:57:54 seth messagebus: messagebus startup succeeded





------_=_NextPart_001_01C4A0D1.DCAC4B80
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6944.0">
<TITLE>SELinux  Doesn't Complete Initialization</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I'm working on a master's thesis on SELinux and I'm =
trying to get it up and running on my home server.&nbsp; I am able to =
compile, install, and load the policy via &quot;make load&quot; in the =
policy source directory, however I'm unable to get it to come all the =
way up on a boot.&nbsp; On my last go, I set the contexts for the =
filesystems using the &quot;make relabel&quot; function call.&nbsp; =
There is never an &quot;SELinux: Initialization Complete&quot; message =
and the system defaults to SELinux disabled.&nbsp; Any help would be =
greatly appreciated.&nbsp; Here are the details.<BR>
<BR>
Fedora Core 2<BR>
2.6.8-1.521<BR>
checkpolicy-1.17.5-1<BR>
policycoreutils-1.17.5-3<BR>
libselinux-1.17.13-1<BR>
selinux-policy-strict-1.17.19-2<BR>
selinux-policy-strict-sources-1.17.19-2<BR>
<BR>
/boot/grub/grub.conf:<BR>
default=3D0<BR>
timeout=3D10<BR>
splashimage=3D(hd0,0)/grub/splash.xpm.gz<BR>
<BR>
title SELinux (2.6.8-1.521)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root (hd0,0)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel /vmlinuz-2.6.8-1.521 =
ro root=3DLABEL=3D/ quiet vga=3D792 selinux=3D1 enforcing=3D0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initrd =
/initrd-2.6.8-1.521.img<BR>
<BR>
/etc/sysconfig/selinux -&gt; /etc/selinux/config:<BR>
# This file controls the state of SELinux on the system.<BR>
# SELINUX=3D can take one of these three values:<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enforcinfg - SELinux security =
policy is enforced.<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; permissive - SELinux prints =
warnings instead of enforcing.<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled - No SELinux policy is =
loaded.<BR>
SELINUX=3Dpermissive<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
# SELINUXTYPE=3D can take one of these two values:<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; targeted - Only targeted network =
daemons are protected.<BR>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strict - Full SELinux =
protection.<BR>
SELINUXTYPE=3Dstrict<BR>
<BR>
Here is what the boot logs state:<BR>
Sep 22 13:57:20 seth syslogd 1.4.1: restart.<BR>
Sep 22 13:57:20 seth syslog: syslogd startup succeeded<BR>
Sep 22 13:57:20 seth kernel: klogd 1.4.1, log source =3D /proc/kmsg =
started.<BR>
Sep 22 13:57:20 seth kernel: Linux version 2.6.8-1.521 =
(bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat =
Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004<BR>
Sep 22 13:57:20 seth kernel: BIOS-provided physical RAM map:<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 0000000000000000 - =
000000000009fc00 (usable)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 000000000009fc00 - =
00000000000a0000 (reserved)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 00000000000f0000 - =
0000000000100000 (reserved)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 0000000000100000 - =
000000003fff0000 (usable)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 000000003fff0000 - =
000000003fff8000 (ACPI data)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 000000003fff8000 - =
0000000040000000 (ACPI NVS)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 00000000fec00000 - =
00000000fec01000 (reserved)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 00000000fee00000 - =
00000000fee01000 (reserved)<BR>
Sep 22 13:57:20 seth kernel:&nbsp; BIOS-e820: 00000000fff00000 - =
0000000100000000 (reserved)<BR>
Sep 22 13:57:20 seth syslog: klogd startup succeeded<BR>
Sep 22 13:57:20 seth kernel: 0MB HIGHMEM available.<BR>
Sep 22 13:57:20 seth kernel: 1023MB LOWMEM available.<BR>
Sep 22 13:57:20 seth kernel: zapping low mappings.<BR>
Sep 22 13:57:20 seth kernel: DMI 2.3 present.<BR>
Sep 22 13:57:20 seth kernel: ACPI: RSDP (v000 =
AMI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) @ 0x000fa6a0<BR>
Sep 22 13:57:20 seth kernel: ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 =
MSFT 0x00000097) @ 0x3fff0000<BR>
Sep 22 13:57:20 seth kernel: ACPI: FADT (v001 AMIINT INTEL875 0x00000011 =
MSFT 0x00000097) @ 0x3fff0030<BR>
Sep 22 13:57:20 seth kernel: ACPI: MADT (v001 AMIINT INTEL875 0x00000009 =
MSFT 0x00000097) @ 0x3fff00c0<BR>
Sep 22 13:57:20 seth kernel: ACPI: DSDT (v001&nbsp; =
INTEL&nbsp;&nbsp;&nbsp;&nbsp; I875 0x00001000 MSFT 0x0100000d) @ =
0x00000000<BR>
Sep 22 13:57:20 seth kernel: ACPI: PM-Timer IO Port: 0x808<BR>
Sep 22 13:57:20 seth kernel: Built 1 zonelists<BR>
Sep 22 13:57:20 seth kernel: Kernel command line: ro root=3DLABEL=3D/ =
quiet vga=3D792 selinux=3D1 enforcing=3D0<BR>
&nbsp;Sep 22 13:57:20 seth kernel: mapped 4G/4G trampoline to =
ffff3000.<BR>
Sep 22 13:57:20 seth kernel: Initializing CPU#0<BR>
Sep 22 13:57:20 seth kernel: CPU 0 irqstacks, hard=3D023c7000 =
soft=3D023c6000<BR>
Sep 22 13:57:20 seth kernel: PID hash table entries: 4096 (order 12: =
32768 bytes)<BR>
Sep 22 13:57:20 seth kernel: Detected 2400.985 MHz processor.<BR>
Sep 22 13:57:20 seth kernel: Using tsc for high-res timesource<BR>
Sep 22 13:57:20 seth irqbalance: irqbalance startup succeeded<BR>
Sep 22 13:57:20 seth kernel: Console: colour dummy device 80x25<BR>
Sep 22 13:57:20 seth kernel: Dentry cache hash table entries: 131072 =
(order: 7, 524288 bytes)<BR>
Sep 22 13:57:20 seth kernel: Inode-cache hash table entries: 131072 =
(order: 7, 524288 bytes)<BR>
Sep 22 13:57:20 seth kernel: Memory: 1034960k/1048512k available (2012k =
kernel code, 12764k reserved, 651k data, 140k init, 0k highmem)<BR>
Sep 22 13:57:20 seth kernel: Calibrating delay loop... 4734.97 =
BogoMIPS<BR>
Sep 22 13:57:20 seth kernel: Security Scaffold v1.0.0 initialized<BR>
Sep 22 13:57:20 seth kernel: SELinux:&nbsp; Initializing.<BR>
Sep 22 13:57:20 seth kernel: SELinux:&nbsp; Starting in permissive =
mode<BR>
Sep 22 13:57:20 seth kernel: There is already a security framework =
initialized, register_security failed.<BR>
Sep 22 13:57:20 seth kernel: selinux_register_security:&nbsp; =
Registering secondary module capability<BR>
Sep 22 13:57:20 seth kernel: Capability LSM initialized as secondary<BR>
Sep 22 13:57:20 seth kernel: Mount-cache hash table entries: 512 (order: =
0, 4096 bytes)<BR>
Sep 22 13:57:20 seth kernel: CPU: Trace cache: 12K uops, L1 D cache: =
8K<BR>
Sep 22 13:57:20 seth kernel: CPU: L2 cache: 512K<BR>
Sep 22 13:57:20 seth kernel: Intel machine check architecture =
supported.<BR>
Sep 22 13:57:20 seth kernel: Intel machine check reporting enabled on =
CPU#0.<BR>
Sep 22 13:57:20 seth kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) =
available<BR>
Sep 22 13:57:20 seth kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz =
stepping 04<BR>
Sep 22 13:57:20 seth kernel: Enabling fast FPU save and restore... =
done.<BR>
Sep 22 13:57:20 seth kernel: Enabling unmasked SIMD FPU exception =
support... done.<BR>
Sep 22 13:57:20 seth kernel: Checking 'hlt' instruction... OK.<BR>
Sep 22 13:57:20 seth kernel: checking if image is initramfs...it isn't =
(no cpio magic); looks like an initrd<BR>
Sep 22 13:57:20 seth kernel: Freeing initrd memory: 187k freed<BR>
Sep 22 13:57:20 seth kernel: NET: Registered protocol family 16<BR>
Sep 22 13:57:20 seth kernel: PCI: PCI BIOS revision 2.10 entry at =
0xfdb81, last bus=3D3<BR>
Sep 22 13:57:20 seth kernel: PCI: Using configuration type 1<BR>
Sep 22 13:57:20 seth kernel: mtrr: v2.0 (20020519)<BR>
Sep 22 13:57:20 seth kernel: ACPI: Subsystem revision 20040326<BR>
Sep 22 13:57:20 seth portmap: portmap startup succeeded<BR>
Sep 22 13:57:20 seth kernel: ACPI: IRQ9 SCI: Edge set to Level =
Trigger.<BR>
Sep 22 13:57:20 seth kernel: ACPI: Interpreter enabled<BR>
Sep 22 13:57:20 seth kernel: ACPI: Using PIC for interrupt routing<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Root Bridge [PCI0] (00:00)<BR>
Sep 22 13:57:20 seth kernel: PCI: Probing PCI hardware (bus 00)<BR>
Sep 22 13:57:20 seth kernel: PCI: Ignoring BAR0-3 of IDE controller =
0000:00:1f.1Sep 22 13:57:20 seth kernel: PCI: Transparent bridge - =
0000:00:1e.0<BR>
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [URP1] (off)<BR>
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [URP2] (off)<BR>
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [FDDP] (off)<BR>
Sep 22 13:57:20 seth kernel: ACPI: Power Resource [LPTP] (off)<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 =
6 7 10 *11 12 14 15)<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 =
6 7 10 *11 12 14 15)<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 =
*5 6 7 10 11 12 14 15)<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 =
5 6 7 10 11 12 14 15)<BR>
Sep 22 13:57:20 seth rpc.statd[1616]: Version 1.0.6 Starting<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 =
6 7 10 11 12 14 15) *0, disabled.<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 =
*5 6 7 10 11 12 14 15)<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 =
6 7 10 11 12 14 15) *0, disabled.<BR>
Sep 22 13:57:20 seth kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 =
6 7 *10 11 12 14 15)<BR>
Sep 22 13:57:20 seth kernel: Linux Plug and Play Support v0.97 (c) Adam =
Belay<BR>
Sep 22 13:57:21 seth kernel: usbcore: registered new driver usbfs<BR>
Sep 22 13:57:21 seth kernel: usbcore: registered new driver hub<BR>
Sep 22 13:57:21 seth nfslock: rpc.statd startup succeeded<BR>
Sep 22 13:57:21 seth kernel: PCI: Using ACPI for IRQ routing<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKA] enabled at =
IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKD] enabled at =
IRQ 3<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -&gt; =
GSI 3 (level, low) -&gt; IRQ 3<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKC] enabled at =
IRQ 5<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKH] enabled at =
IRQ 10<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -&gt; =
GSI 10 (level, low) -&gt; IRQ 10<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKB] enabled at =
IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:01:00.0[A] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI Interrupt Link [LNKF] enabled at =
IRQ 5<BR>
Sep 22 13:57:21 seth kernel: ACPI: PCI interrupt 0000:03:09.0[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:21 seth kernel: vesafb: framebuffer at 0xe8000000, mapped =
to 0x42807000, size 6144k<BR>
Sep 22 13:57:21 seth kernel: vesafb: mode is 1024x768x32, =
linelength=3D4096, pages=3D1<BR>
Sep 22 13:57:21 seth kernel: vesafb: protected mode interface info at =
c000:c530<BR>
Sep 22 13:57:21 seth kernel: vesafb: scrolling: redraw<BR>
Sep 22 13:57:21 seth kernel: vesafb: directcolor: size=3D8:8:8:8, =
shift=3D24:16:8:0<BR>
Sep 22 13:57:21 seth kernel: fb0: VESA VGA frame buffer device<BR>
Sep 22 13:57:21 seth kernel: apm: BIOS version 1.2 Flags 0x03 (Driver =
version 1.16ac)<BR>
Sep 22 13:57:21 seth kernel: apm: overridden by ACPI.<BR>
Sep 22 13:57:21 seth kernel: audit: initializing netlink socket =
(disabled)<BR>
Sep 22 13:57:21 seth kernel: audit(1095861409.645:0): initialized<BR>
Sep 22 13:57:21 seth kernel: Total HugeTLB memory allocated, 0<BR>
Sep 22 13:57:21 seth kernel: VFS: Disk quotas dquot_6.5.1<BR>
Sep 22 13:57:21 seth kernel: Dquot-cache hash table entries: 1024 (order =
0, 4096 bytes)<BR>
Sep 22 13:57:22 seth kernel: SELinux:&nbsp; Registering netfilter =
hooks<BR>
Sep 22 13:57:22 seth kernel: Initializing Cryptographic API<BR>
Sep 22 13:57:22 seth kernel: ksign: Installing public key data<BR>
Sep 22 13:57:17 seth sysctl: kernel.core_uses_pid =3D 1<BR>
Sep 22 13:57:22 seth kernel: Loading keyring<BR>
Sep 22 13:57:17 seth network: Setting network parameters:&nbsp; =
succeeded<BR>
Sep 22 13:57:22 seth kernel: - Added public key 9488DB81FF525AA3<BR>
Sep 22 13:57:17 seth network: Bringing up loopback interface:&nbsp; =
succeeded<BR>
Sep 22 13:57:22 seth kernel: - User ID: Red Hat, Inc. (Kernel Module GPG =
key)<BR>
Sep 22 13:57:22 seth kernel: ksign: invalid packet (ctb=3D00)<BR>
Sep 22 13:57:22 seth kernel: Unable to load default keyring: =
error=3D74<BR>
Sep 22 13:57:22 seth kernel: pci_hotplug: PCI Hot Plug PCI Core version: =
0.5<BR>
Sep 22 13:57:22 seth kernel: ACPI: Processor [CPU1] (supports C1, 8 =
throttling states)<BR>
Sep 22 13:57:23 seth kernel: isapnp: Scanning for PnP cards...<BR>
Sep 22 13:57:23 seth kernel: isapnp: No Plug &amp; Play device found<BR>
Sep 22 13:57:23 seth kernel: Console: switching to colour frame buffer =
device 128x48<BR>
Sep 22 13:57:23 seth kernel: Real Time Clock Driver v1.12<BR>
Sep 22 13:57:23 seth kernel: Linux agpgart interface v0.100 (c) Dave =
Jones<BR>
Sep 22 13:57:23 seth kernel: agpgart: Detected an Intel i875 =
Chipset.<BR>
Sep 22 13:57:23 seth kernel: agpgart: Maximum main memory to use for agp =
memory: 941M<BR>
Sep 22 13:57:23 seth kernel: agpgart: AGP aperture is 64M @ =
0xf8000000<BR>
Sep 22 13:57:23 seth kernel: Serial: 8250/16550 driver $Revision: 1.90 $ =
8 ports, IRQ sharing enabled<BR>
Sep 22 13:57:24 seth kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a =
16550A<BR>
Sep 22 13:57:24 seth kernel: RAMDISK driver initialized: 16 RAM disks of =
16384K size 1024 blocksize<BR>
Sep 22 13:57:24 seth kernel: Uniform Multi-Platform E-IDE driver =
Revision: 7.00alpha2<BR>
Sep 22 13:57:24 seth kernel: ide: Assuming 33MHz system bus speed for =
PIO modes; override with idebus=3Dxx<BR>
Sep 22 13:57:24 seth kernel: ICH5: IDE controller at PCI slot =
0000:00:1f.1<BR>
Sep 22 13:57:24 seth kernel: PCI: Enabling device 0000:00:1f.1 (0005 =
-&gt; 0007)<BR>
Sep 22 13:57:25 seth kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:25 seth kernel: ICH5: chipset revision 2<BR>
Sep 22 13:57:25 seth kernel: ICH5: not 100%% native mode: will probe =
irqs later<BR>
Sep 22 13:57:25 seth kernel:&nbsp;&nbsp;&nbsp;&nbsp; ide0: BM-DMA at =
0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio<BR>
Sep 22 13:57:25 seth kernel:&nbsp;&nbsp;&nbsp;&nbsp; ide1: BM-DMA at =
0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio<BR>
Sep 22 13:57:25 seth kernel: hda: IC35L120AVVA07-0, ATA DISK drive<BR>
Sep 22 13:57:25 seth kernel: Using cfq io scheduler<BR>
Sep 22 13:57:25 seth kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14<BR>
Sep 22 13:57:25 seth kernel: hdc: Compaq DVD-ROM DVD-117, ATAPI =
CD/DVD-ROM driveSep 22 13:57:25 seth kernel: ide1 at 0x170-0x177,0x376 =
on irq 15<BR>
Sep 22 13:57:25 seth kernel: hda: max request size: 128KiB<BR>
Sep 22 13:57:25 seth kernel: hda: 241254720 sectors (123522 MB) =
w/1863KiB Cache, CHS=3D65535/16/63, UDMA(100)<BR>
Sep 22 13:57:25 seth kernel:&nbsp; hda: hda1 hda2 hda3<BR>
Sep 22 13:57:26 seth kernel: hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, =
UDMA(44)Sep 22 13:57:26 seth kernel: Uniform CD-ROM driver Revision: =
3.20<BR>
Sep 22 13:57:26 seth kernel: ide-floppy driver 0.99.newide<BR>
Sep 22 13:57:26 seth kernel: usbcore: registered new driver hiddev<BR>
Sep 22 13:57:26 seth kernel: usbcore: registered new driver usbhid<BR>
Sep 22 13:57:26 seth kernel: drivers/usb/input/hid-core.c: v2.0:USB HID =
core driver<BR>
Sep 22 13:57:26 seth kernel: mice: PS/2 mouse device common for all =
mice<BR>
Sep 22 13:57:26 seth kernel: serio: i8042 AUX port at 0x60,0x64 irq =
12<BR>
Sep 22 13:57:26 seth kernel: input: ImPS/2 Generic Wheel Mouse on =
isa0060/serio1Sep 22 13:57:26 seth kernel: serio: i8042 KBD port at =
0x60,0x64 irq 1<BR>
Sep 22 13:57:26 seth kernel: input: AT Translated Set 2 keyboard on =
isa0060/serio0<BR>
Sep 22 13:57:26 seth kernel: md: md driver 0.90.0 MAX_MD_DEVS=3D256, =
MD_SB_DISKS=3D27<BR>
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 2<BR>
Sep 22 13:57:27 seth kernel: IP: routing cache hash table of 2048 =
buckets, 64Kbytes<BR>
Sep 22 13:57:27 seth kernel: TCP: Hash tables configured (established =
262144 bind 37449)<BR>
Sep 22 13:57:27 seth kernel: Initializing IPsec netlink socket<BR>
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 1<BR>
Sep 22 13:57:27 seth kernel: NET: Registered protocol family 17<BR>
Sep 22 13:57:27 seth kernel: ACPI: (supports S0 S1 S4 S5)<BR>
Sep 22 13:57:27 seth kernel: md: Autodetecting RAID arrays.<BR>
Sep 22 13:57:27 seth kernel: md: autorun ...<BR>
Sep 22 13:57:27 seth kernel: md: ... autorun DONE.<BR>
Sep 22 13:57:27 seth kernel: RAMDISK: Compressed image found at block =
0<BR>
Sep 22 13:57:27 seth kernel: VFS: Mounted root (ext2 filesystem).<BR>
Sep 22 13:57:27 seth kernel: EXT3-fs: INFO: recovery required on =
readonly filesystem.<BR>
Sep 22 13:57:27 seth kernel: EXT3-fs: write access will be enabled =
during recovery.<BR>
Sep 22 13:57:27 seth kernel: kjournald starting.&nbsp; Commit interval 5 =
seconds<BR>
Sep 22 13:57:28 seth kernel: EXT3-fs: hda2: orphan cleanup on readonly =
fs<BR>
Sep 22 13:57:28 seth kernel: EXT3-fs: hda2: 1 orphan inode deleted<BR>
Sep 22 13:57:28 seth kernel: EXT3-fs: recovery complete.<BR>
Sep 22 13:57:28 seth kernel: EXT3-fs: mounted filesystem with ordered =
data mode.Sep 22 13:57:28 seth kernel: Freeing unused kernel memory: =
140k freed<BR>
Sep 22 13:57:28 seth kernel: ACPI: Power Button (FF) [PWRF]<BR>
Sep 22 13:57:28 seth kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -&gt; =
GSI 10 (level, low) -&gt; IRQ 10<BR>
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: EHCI Host =
Controller<BR>
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: irq 10, pci mem =
42e32c00<BR>
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: new USB bus =
registered, assigned bus number 1<BR>
Sep 22 13:57:28 seth kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, =
EHCI 1.00, driver 2004-May-10<BR>
Sep 22 13:57:28 seth kernel: hub 1-0:1.0: USB hub found<BR>
Sep 22 13:57:28 seth kernel: hub 1-0:1.0: 8 ports detected<BR>
Sep 22 13:57:28 seth kernel: USB Universal Host Controller Interface =
driver v2.2<BR>
Sep 22 13:57:28 seth kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: UHCI Host =
Controller<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: irq 11, io base =
0000e000<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.0: new USB bus =
registered, assigned bus number 2<BR>
Sep 22 13:57:29 seth kernel: hub 2-0:1.0: USB hub found<BR>
Sep 22 13:57:29 seth kernel: hub 2-0:1.0: 2 ports detected<BR>
Sep 22 13:57:29 seth kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -&gt; =
GSI 3 (level, low) -&gt; IRQ 3<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: UHCI Host =
Controller<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: irq 3, io base =
0000e400<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.1: new USB bus =
registered, assigned bus number 3<BR>
Sep 22 13:57:29 seth kernel: hub 3-0:1.0: USB hub found<BR>
Sep 22 13:57:29 seth kernel: hub 3-0:1.0: 2 ports detected<BR>
Sep 22 13:57:29 seth kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:29 seth kernel: uhci_hcd 0000:00:1d.2: UHCI Host =
Controller<BR>
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.2: irq 5, io base =
0000e800<BR>
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.2: new USB bus =
registered, assigned bus number 4<BR>
Sep 22 13:57:30 seth kernel: hub 4-0:1.0: USB hub found<BR>
Sep 22 13:57:30 seth kernel: hub 4-0:1.0: 2 ports detected<BR>
Sep 22 13:57:30 seth kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -&gt; =
GSI 11 (level, low) -&gt; IRQ 11<BR>
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: UHCI Host =
Controller<BR>
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: irq 11, io base =
0000ec00<BR>
Sep 22 13:57:30 seth kernel: uhci_hcd 0000:00:1d.3: new USB bus =
registered, assigned bus number 5<BR>
Sep 22 13:57:30 seth kernel: hub 5-0:1.0: USB hub found<BR>
Sep 22 13:57:30 seth kernel: hub 5-0:1.0: 2 ports detected<BR>
Sep 22 13:57:30 seth kernel: EXT3 FS on hda2, internal journal<BR>
Sep 22 13:57:30 seth kernel: device-mapper: 4.1.0-ioctl (2003-12-10) =
initialised: dm@uk.sistina.com<BR>
Sep 22 13:57:30 seth kernel: cdrom: open failed.<BR>
Sep 22 13:57:30 seth kernel: Adding 2040244k swap on /dev/hda3.&nbsp; =
Priority:-1 extents:1<BR>
Sep 22 13:57:30 seth kernel: kjournald starting.&nbsp; Commit interval 5 =
seconds<BR>
Sep 22 13:57:31 seth kernel: EXT3 FS on hda1, internal journal<BR>
Sep 22 13:57:31 seth kernel: EXT3-fs: mounted filesystem with ordered =
data mode.Sep 22 13:57:31 seth kernel: IA-32 Microcode Update Driver: =
v1.14 &lt;tigran@veritas.com&gt;<BR>
Sep 22 13:57:31 seth kernel: microcode: No new microdata for cpu 0<BR>
Sep 22 13:57:31 seth kernel: parport0: PC-style at 0x378 (0x778) =
[PCSPP,TRISTATE,EPP]<BR>
Sep 22 13:57:31 seth kernel: parport0: irq 7 detected<BR>
Sep 22 13:57:31 seth kernel: SCSI subsystem initialized<BR>
Sep 22 13:57:31 seth kernel: inserting floppy driver for 2.6.8-1.521<BR>
Sep 22 13:57:31 seth kernel: Floppy drive(s): fd0 is 1.44M<BR>
Sep 22 13:57:31 seth kernel: FDC 0 is a post-1991 82077<BR>
Sep 22 13:57:31 seth kernel: ohci1394: $Rev: 1223 $ Ben Collins =
&lt;bcollins@debian.org&gt;<BR>
Sep 22 13:57:31 seth kernel: ACPI: PCI interrupt 0000:03:09.0[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:31 seth kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): =
IRQ=3D[5]&nbsp; MMIO=3D[feaef800-feaeffff]&nbsp; Max Packet=3D[2048]<BR>
Sep 22 13:57:32 seth kernel: e1000: Ignoring new-style parameters in =
presence of obsolete ones<BR>
Sep 22 13:57:32 seth kernel: Intel(R) PRO/1000 Network Driver - version =
5.2.52-k4<BR>
Sep 22 13:57:32 seth kernel: Copyright (c) 1999-2004 Intel =
Corporation.<BR>
Sep 22 13:57:32 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:32 seth kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 =
Network Connection<BR>
Sep 22 13:57:32 seth kernel: ip_tables: (C) 2000-2002 Netfilter core =
team<BR>
Sep 22 13:57:32 seth kernel: ip_conntrack version 2.1 (8191 buckets, =
65528 max) - 320 bytes per conntrack<BR>
Sep 22 13:57:32 seth kernel: e1000: Ignoring new-style parameters in =
presence of obsolete ones<BR>
Sep 22 13:57:32 seth kernel: Intel(R) PRO/1000 Network Driver - version =
5.2.52-k4<BR>
Sep 22 13:57:32 seth kernel: Copyright (c) 1999-2004 Intel =
Corporation.<BR>
Sep 22 13:57:32 seth kernel: ACPI: PCI interrupt 0000:02:01.0[A] -&gt; =
GSI 5 (level, low) -&gt; IRQ 5<BR>
Sep 22 13:57:32 seth kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 =
Network Connection<BR>
Sep 22 13:57:33 seth kernel: e1000: eth0: e1000_watchdog: NIC Link is Up =
100 Mbps Full Duplex<BR>
Sep 22 13:57:41 seth rpcidmapd: rpc.idmapd startup succeeded<BR>
Sep 22 13:57:41 seth random: Initializing random number generator:&nbsp; =
succeeded<BR>
Sep 22 13:57:41 seth netfs: Mounting other filesystems:&nbsp; =
succeeded<BR>
Sep 22 13:57:41 seth autofs: automount startup succeeded<BR>
Sep 22 13:57:41 seth smartd[1715]: smartd version 5.21 Copyright (C) =
2002-3 Bruce Allen<BR>
Sep 22 13:57:41 seth smartd[1715]: Home page is <A =
HREF=3D"http://smartmontools.sourceforge.net/">http://smartmontools.sourc=
eforge.net/</A><BR>
Sep 22 13:57:41 seth smartd[1715]: Opened configuration file =
/etc/smartd.conf<BR>
Sep 22 13:57:41 seth smartd[1715]: Configuration file /etc/smartd.conf =
parsed.<BR>
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, opened<BR>
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, not found in smartd =
database.<BR>
Sep 22 13:57:41 seth smartd[1715]: Device: /dev/hda, is SMART capable. =
Adding to &quot;monitor&quot; list.<BR>
Sep 22 13:57:41 seth smartd[1715]: Monitoring 1 ATA and 0 SCSI =
devices<BR>
Sep 22 13:57:42 seth smartd[1717]: smartd has fork()ed into background =
mode. New PID=3D1717.<BR>
Sep 22 13:57:42 seth smartd: smartd startup succeeded<BR>
Sep 22 13:57:42 seth acpid: acpid startup succeeded<BR>
Sep 22 13:57:43 seth kernel: parport0: PC-style at 0x378 (0x778) =
[PCSPP,TRISTATE,EPP]<BR>
Sep 22 13:57:43 seth kernel: parport0: irq 7 detected<BR>
Sep 22 13:57:43 seth kernel: lp0: using parport0 (polling).<BR>
Sep 22 13:57:43 seth kernel: lp0: console ready<BR>
Sep 22 13:57:45 seth cups: cupsd startup succeeded<BR>
Sep 22 13:57:45 seth kernel: NET: Registered protocol family 10<BR>
Sep 22 13:57:45 seth kernel: Disabled Privacy Extensions on device =
0235c2a0(lo)<BR>
Sep 22 13:57:45 seth kernel: IPv6 over IPv4 tunneling driver<BR>
Sep 22 13:57:45 seth sshd:&nbsp; succeeded<BR>
Sep 22 13:57:45 seth xinetd: xinetd startup succeeded<BR>
Sep 22 13:57:47 seth mysqld: Starting MySQL:&nbsp; succeeded<BR>
Sep 22 13:57:47 seth xinetd[1966]: xinetd Version 2.3.13 started with =
libwrap loadavg options compiled in.<BR>
Sep 22 13:57:47 seth xinetd[1966]: Started working: 1 available =
service<BR>
Sep 22 13:57:47 seth sendmail: sendmail startup succeeded<BR>
Sep 22 13:57:48 seth sendmail: sm-client startup succeeded<BR>
Sep 22 13:57:48 seth gpm[2053]: *** info [startup.c(95)]:<BR>
Sep 22 13:57:48 seth gpm[2053]: Started gpm successfully. Entered daemon =
mode.<BR>
Sep 22 13:57:48 seth gpm[2053]: *** info [mice.c(1766)]:<BR>
Sep 22 13:57:48 seth gpm[2053]: imps2: Auto-detected intellimouse =
PS/2<BR>
Sep 22 13:57:48 seth gpm: gpm startup succeeded<BR>
Sep 22 13:57:50 seth httpd: httpd startup succeeded<BR>
Sep 22 13:57:51 seth su(pam_unix)[2079]: session opened for user =
postgres by (uid=3D0)<BR>
Sep 22 13:57:51 seth su(pam_unix)[2079]: session closed for user =
postgres<BR>
Sep 22 13:57:52 seth postgresql: Starting postgresql service:&nbsp; =
succeeded<BR>
Sep 22 13:57:52 seth crond: crond startup succeeded<BR>
Sep 22 13:57:53 seth xfs: xfs startup succeeded<BR>
Sep 22 13:57:53 seth anacron: anacron startup succeeded<BR>
Sep 22 13:57:53 seth atd: atd startup succeeded<BR>
Sep 22 13:57:53 seth saslauthd[2185]: =
detach_tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : master pid is: 2185<BR>
Sep 22 13:57:53 seth saslauthd[2185]: =
ipc_init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : listening on =
socket: /var/run/saslauthd/mux<BR>
Sep 22 13:57:53 seth saslauthd: saslauthd startup succeeded<BR>
Sep 22 13:57:54 seth messagebus: messagebus startup succeeded<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4A0D1.DCAC4B80--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
