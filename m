Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j266CbDo004949
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2005 01:12:38 -0500 (EST)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2665rbb013778
	for <selinux@tycho.nsa.gov>; Sun, 6 Mar 2005 06:05:53 GMT
Received: by rproxy.gmail.com with SMTP id y7so923736rne
        for <selinux@tycho.nsa.gov>; Sat, 05 Mar 2005 22:08:22 -0800 (PST)
Date: Sun, 6 Mar 2005 01:07:07 +0000
From: Marco Morales Barrera <soulse@gmail.com>
To: selinux@tycho.nsa.gov
Subject: bootup problem
Message-ID: <20050306010707.GA23579@Lilith.cpe.cablenet.com.pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Im getting weird denials at bootup like this:
audit(1110042094.818:0): avc:  denied  { getattr } for  pid=3D938
exe=3D/bin/bash path=3D/etc/passwd dev=3Dhda5 ino=3D193401 scontext=3Dsyste=
m_u:system_r:kernel_t
tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
fs is correctly labeled.... why that happens?
im attaching bootup log..

--=20
"If knowledge can create problems, it is not through ignorance that we=20
can solve them."
- Isaac Asimov
--

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=boot
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.10-hardened-r3 (root@Lilith) (gcc version 3.3.5 (Gentoo L=
inux 3.3.5-r1, ssp-3.3.2-3, pie-8.7.7.1)) #3 SMP Sat Mar 5 16:49:32 GMT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126912 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D850MV MV85010A 0x20020328 MSFT 0x00001011) @ 0x1fff0000
ACPI: FADT (v001 D850MV MV85010A 0x20020328 MSFT 0x00001011) @ 0x1fff1000
ACPI: MADT (v001 D850MV MV85010A 0x20020328 MSFT 0x00001011) @ 0x1ffe3732
ACPI: DSDT (v001 D850MV MV85010A 0x00000004 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=3D/dev/hda5 gentoo=3Dnodevfs
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc0598000 soft=3Dc0590000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1994.606 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513224k/524032k available (3170k kernel code, 10332k reserved, 749k=
 data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3932.16 BogoMIPS (lpj=3D1966080)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module re=
gistered.
Failure registering Root Plug  module with primary security module.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 0000=
0000 00000000
CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 00000=
000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps: 3febfbff 00000000 00000000 00000080 00000000 00=
000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
per-CPU timeslice cutoff: 1462.65 usecs.
task migration cache decay timeout: 2 msecs.
Total of 1 processors activated (3932.16 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
Brought up 1 CPUs
CPU0:
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1110042090.880:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.22 [Flags: R/W DEBUG].
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i850 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
eth0: VIA Rhine III at 0xfeaffc00, 00:05:5d:77:b6:d9, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.
ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
eth1: VIA Rhine III at 0xfeaff800, 00:05:5d:6c:05:67, IRQ 21.
eth1: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 4D080H4, ATA DISK drive
hdb: QUANTUM FIREBALLlct10 20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CD-R/RW SW-252B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(=
100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 128KiB
hdb: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=3D39560/16/63, UDMA(33)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 < hdb5 >
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.10 loaded.
ieee1394: raw1394: /dev/raw1394 device initialized
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 19, io base 0xef40
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 23, io base 0xef80
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-2: new full speed USB device using uhci_hcd and address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Intel 810 + AC97 Audio, version 1.01, 16:24:40 Mar  5 2005
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, MEM 0x0000 and 0x0000, IRQ =
17
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ADS96 (Analog Devices AD1885)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not presen=
t), total channels =3D 2
i810_audio: setting clocking to 48689
es1371: version v0.32 time 16:24:43 Mar  5 2005
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53=
 2004 UTC).
ALSA device list:
  No soundcards found.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 340 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
ClusterIP Version 0.6 loaded successfully
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:=20
PBTN PCI1 NEC0 NEC1 NEC2 UAR1 UAR2  USB USB2  AC9  SMB=20
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
kjournald starting.  Commit interval 5 seconds
security:  4 users, 5 roles, 510 types, 3 bools
security:  54 classes, 40206 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
audit(1110042094.818:0): avc:  denied  { getattr } for  pid=3D938 exe=3D/bi=
n/bash path=3D/etc/passwd dev=3Dhda5 ino=3D193401 scontext=3Dsystem_u:syste=
m_r:kernel_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
audit(1110042094.818:0): avc:  denied  { read } for  pid=3D938 path=3D/etc/=
passwd dev=3Dhda5 ino=3D193401 scontext=3Dsystem_u:system_r:kernel_t tconte=
xt=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
audit(1110042094.827:0): avc:  denied  { ioctl } for  pid=3D938 exe=3D/bin/=
bash path=3D/sbin/hotplug dev=3Dhda5 ino=3D112111 scontext=3Dsystem_u:syste=
m_r:kernel_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
SELinux: initialized (dev hda5, type ext3), uses xattr
audit(1110042094.893:0): avc:  denied  { read } for  pid=3D938 exe=3D/bin/b=
ash name=3D05-wait_for_sysfs.hotplug dev=3Dhda5 ino=3D192456 scontext=3Dsys=
tem_u:system_r:kernel_t tcontext=3Dsystem_u:object_r:etc_t tclass=3Dlnk_file
audit(1110042094.925:0): avc:  denied  { execute } for  pid=3D940 path=3D/l=
ib/ld-2.3.4.so dev=3Dhda5 ino=3D272023 scontext=3Dsystem_u:system_r:kernel_=
t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
audit(1110042094.925:0): avc:  denied  { search } for  pid=3D940 exe=3D/sbi=
n/wait_for_sysfs name=3Detc dev=3Dhda5 ino=3D192001 scontext=3Dsystem_u:sys=
tem_r:udev_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Ddir
audit(1110042094.925:0): avc:  denied  { read } for  pid=3D940 exe=3D/sbin/=
wait_for_sysfs name=3Dld.so.cache dev=3Dhda5 ino=3D192248 scontext=3Dsystem=
_u:system_r:udev_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
audit(1110042094.925:0): avc:  denied  { getattr } for  pid=3D940 exe=3D/sb=
in/wait_for_sysfs path=3D/etc/ld.so.cache dev=3Dhda5 ino=3D192248 scontext=
=3Dsystem_u:system_r:udev_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=
=3Dfile
audit(1110042094.926:0): avc:  denied  { read } for  pid=3D940 exe=3D/sbin/=
wait_for_sysfs name=3Dlibc.so.6 dev=3Dhda5 ino=3D272051 scontext=3Dsystem_u=
:system_r:udev_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dlnk_file
audit(1110042094.926:0): avc:  denied  { execute } for  pid=3D940 path=3D/l=
ib/libc-2.3.4.so dev=3Dhda5 ino=3D272024 scontext=3Dsystem_u:system_r:udev_=
t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile
audit(1110042094.926:0): avc:  denied  { read } for  pid=3D940 exe=3D/sbin/=
wait_for_sysfs name=3Durandom dev=3Dhda5 ino=3D132839 scontext=3Dsystem_u:s=
ystem_r:udev_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dchr_file
audit(1110042095.007:0): avc:  denied  { execute_no_trans } for  pid=3D948 =
exe=3D/bin/bash path=3D/etc/hotplug.d/default/default.hotplug dev=3Dhda5 in=
o=3D192486 scontext=3Dsystem_u:system_r:kernel_t tcontext=3Dsystem_u:object=
_r:sbin_t tclass=3Dfile
audit(1110042095.036:0): avc:  denied  { read } for  pid=3D949 exe=3D/bin/b=
ash name=3Dmtab dev=3Dhda5 ino=3D192040 scontext=3Dsystem_u:system_r:kernel=
_t tcontext=3Dsystem_u:object_r:etc_runtime_t tclass=3Dfile
audit(1110042095.036:0): avc:  denied  { getattr } for  pid=3D949 exe=3D/bi=
n/bash path=3D/etc/mtab dev=3Dhda5 ino=3D192040 scontext=3Dsystem_u:system_=
r:kernel_t tcontext=3Dsystem_u:object_r:etc_runtime_t tclass=3Dfile
audit(1110042095.036:0): avc:  denied  { read } for  pid=3D949 exe=3D/bin/b=
ash name=3Dnsswitch.conf dev=3Dhda5 ino=3D193519 scontext=3Dsystem_u:system=
_r:kernel_t tcontext=3Dsystem_u:object_r:etc_t tclass=3Dfile
audit(1110042095.036:0): avc:  denied  { getattr } for  pid=3D949 exe=3D/bi=
n/bash path=3D/etc/nsswitch.conf dev=3Dhda5 ino=3D193519 scontext=3Dsystem_=
u:system_r:kernel_t tcontext=3Dsystem_u:object_r:etc_t tclass=3Dfile
audit(1110042095.052:0): avc:  denied  { getattr } for  pid=3D949 exe=3D/bi=
n/bash path=3D/etc/hotplug dev=3Dhda5 ino=3D192442 scontext=3Dsystem_u:syst=
em_r:kernel_t tcontext=3Dsystem_u:object_r:hotplug_etc_t tclass=3Ddir
audit(1110042095.098:0): avc:  denied  { read } for  pid=3D949 exe=3D/bin/b=
ash path=3Dpipe:[1030] dev=3Dpipefs ino=3D1030 scontext=3Dsystem_u:system_r=
:kernel_t tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfifo_file
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contex=
ts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1110042095.877:0): avc:  denied  { read } for  pid=3D1139 exe=3D/sbin=
/restorecon name=3D/ dev=3Dtmpfs ino=3D1183 scontext=3Dsystem_u:system_r:in=
itrc_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Ddir
audit(1110042095.886:0): avc:  denied  { read } for  pid=3D1139 exe=3D/sbin=
/restorecon name=3Dfile_contexts dev=3Dhda5 ino=3D192026 scontext=3Dsystem_=
u:system_r:initrc_t tcontext=3Dsystem_u:object_r:file_context_t tclass=3Dfi=
le
audit(1110042095.914:0): avc:  denied  { write } for  pid=3D1139 exe=3D/sbi=
n/restorecon name=3Dcontext dev=3Dselinuxfs ino=3D5 scontext=3Dsystem_u:sys=
tem_r:initrc_t tcontext=3Dsystem_u:object_r:security_t tclass=3Dfile
audit(1110042095.914:0): avc:  denied  { check_context } for  pid=3D1139 ex=
e=3D/sbin/restorecon scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsyste=
m_u:object_r:security_t tclass=3Dsecurity
audit(1110042095.960:0): avc:  denied  { relabelfrom } for  pid=3D1139 exe=
=3D/sbin/restorecon name=3D/ dev=3Dtmpfs ino=3D1183 scontext=3Dsystem_u:sys=
tem_r:initrc_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Ddir
audit(1110042095.960:0): avc:  denied  { relabelto } for  pid=3D1139 exe=3D=
/sbin/restorecon name=3D/ dev=3Dtmpfs ino=3D1183 scontext=3Dsystem_u:system=
_r:initrc_t tcontext=3Dsystem_u:object_r:device_t tclass=3Ddir
audit(1110042096.072:0): avc:  denied  { create } for  pid=3D1142 exe=3D/bi=
n/tar name=3Dsndstat scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsyste=
m_u:object_r:device_t tclass=3Dfile
audit(1110042096.072:0): avc:  denied  { unlink } for  pid=3D1142 exe=3D/bi=
n/tar name=3Dsndstat dev=3Dtmpfs ino=3D1192 scontext=3Dsystem_u:system_r:in=
itrc_t tcontext=3Dsystem_u:object_r:device_t tclass=3Dfile
audit(1110042096.072:0): avc:  denied  { create } for  pid=3D1142 exe=3D/bi=
n/tar name=3Dsndstat scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsyste=
m_u:object_r:device_t tclass=3Dlnk_file
audit(1110042096.072:0): avc:  denied  { setattr } for  pid=3D1142 exe=3D/b=
in/tar name=3Dsndstat dev=3Dtmpfs ino=3D1193 scontext=3Dsystem_u:system_r:i=
nitrc_t tcontext=3Dsystem_u:object_r:device_t tclass=3Dlnk_file
audit(1110042096.093:0): avc:  denied  { associate } for  pid=3D1 exe=3D/sb=
in/init name=3Dinitctl scontext=3Dsystem_u:object_r:initctl_t tcontext=3Dsy=
stem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.129:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3D.udev.tdb scontext=3Dsystem_u:object_r:udev_tdb_t tcontex=
t=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.205:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dfull scontext=3Dsystem_u:object_r:null_device_t tcontext=
=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.207:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dkmem scontext=3Dsystem_u:object_r:memory_device_t tcontex=
t=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.210:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Drandom scontext=3Dsystem_u:object_r:random_device_t tcont=
ext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.211:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Durandom scontext=3Dsystem_u:object_r:urandom_device_t tco=
ntext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.211:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dzero scontext=3Dsystem_u:object_r:zero_device_t tcontext=
=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.212:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dmice scontext=3Dsystem_u:object_r:mouse_device_t tcontext=
=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.221:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dlp0 scontext=3Dsystem_u:object_r:printer_device_t tcontex=
t=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.222:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3DcontrolC0 scontext=3Dsystem_u:object_r:sound_device_t tco=
ntext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.227:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dconsole scontext=3Dsystem_u:object_r:console_device_t tco=
ntext=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.228:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dptmx scontext=3Dsystem_u:object_r:ptmx_t tcontext=3Dsyste=
m_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.424:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dtty scontext=3Dsystem_u:object_r:devtty_t tcontext=3Dsyst=
em_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042096.704:0): avc:  denied  { execute_no_trans } for  pid=3D1146=
 exe=3D/sbin/udev path=3D/etc/udev/scripts/cdsymlinks.sh dev=3Dhda5 ino=3D1=
92446 scontext=3Dsystem_u:system_r:udev_t tcontext=3Dsystem_u:object_r:udev=
_helper_exec_t tclass=3Dfile
audit(1110042096.862:0): avc:  denied  { associate } for  pid=3D1145 exe=3D=
/sbin/udev name=3Dhda scontext=3Dsystem_u:object_r:fixed_disk_device_t tcon=
text=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042097.259:0): avc:  denied  { create } for  pid=3D1430 exe=3D/bi=
n/mkdir name=3Dpts scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_=
u:object_r:device_t tclass=3Ddir
audit(1110042097.266:0): avc:  denied  { write } for  pid=3D1431 exe=3D/bin=
/touch name=3D.udev dev=3Dtmpfs ino=3D3638 scontext=3Dsystem_u:system_r:ini=
trc_t tcontext=3Dsystem_u:object_r:device_t tclass=3Dfile
Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
audit(1110042097.719:0): avc:  denied  { search } for  pid=3D1503 exe=3D/bi=
n/bash name=3Dvar dev=3Dhda5 ino=3D160001 scontext=3Dsystem_u:system_r:upda=
te_modules_t tcontext=3Droot:object_r:file_t tclass=3Ddir
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda6, type ext3), uses xattr
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda7, type ext3), uses xattr
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda8, type ext3), uses xattr
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda9, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1110042098.341:0): avc:  denied  { mounton } for  pid=3D1581 exe=3D/b=
in/mount path=3D/dev/shm dev=3Dtmpfs ino=3D3821 scontext=3Dsystem_u:system_=
r:mount_t tcontext=3Dsystem_u:object_r:tmpfs_t tclass=3Ddir
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1110042101.329:0): avc:  denied  { getattr } for  pid=3D1780 exe=3D/s=
bin/pam_console_apply path=3D/dev/floppy/0 dev=3Dtmpfs ino=3D3158 scontext=
=3Dsystem_u:system_r:pam_console_t tcontext=3Dsystem_u:object_r:device_t tc=
lass=3Dblk_file
audit(1110042101.329:0): avc:  denied  { setattr } for  pid=3D1780 exe=3D/s=
bin/pam_console_apply name=3D0 dev=3Dtmpfs ino=3D3158 scontext=3Dsystem_u:s=
ystem_r:pam_console_t tcontext=3Dsystem_u:object_r:device_t tclass=3Dblk_fi=
le
audit(1110042101.334:0): avc:  denied  { getattr } for  pid=3D1780 exe=3D/s=
bin/pam_console_apply path=3D/proc/asound/oss/sndstat dev=3Dproc ino=3D-268=
435015 scontext=3Dsystem_u:system_r:pam_console_t tcontext=3Dsystem_u:objec=
t_r:proc_t tclass=3Dfile
audit(1110042101.334:0): avc:  denied  { setattr } for  pid=3D1780 exe=3D/s=
bin/pam_console_apply name=3Dsndstat dev=3Dproc ino=3D-268435015 scontext=
=3Dsystem_u:system_r:pam_console_t tcontext=3Dsystem_u:object_r:proc_t tcla=
ss=3Dfile
audit(1110042104.761:0): avc:  denied  { associate } for  pid=3D2855 exe=3D=
/usr/sbin/metalog name=3Dlog scontext=3Dsystem_u:object_r:devlog_t tcontext=
=3Dsystem_u:object_r:tmpfs_t tclass=3Dfilesystem
audit(1110042104.761:0): avc:  denied  { setpgid } for  pid=3D2856 exe=3D/u=
sr/sbin/metalog scontext=3Dsystem_u:system_r:syslogd_t tcontext=3Dsystem_u:=
system_r:syslogd_t tclass=3Dprocess
audit(1110042104.796:0): avc:  denied  { read } for  pid=3D2855 exe=3D/usr/=
sbin/metalog name=3D.timestamp dev=3Dhda8 ino=3D112712 scontext=3Dsystem_u:=
system_r:syslogd_t tcontext=3Dsystem_u:object_r:var_log_t tclass=3Dfile
audit(1110042104.962:0): avc:  denied  { write } for  pid=3D2895 exe=3D/bin=
/touch name=3Dresolv.conf dev=3Dhda5 ino=3D192277 scontext=3Dsystem_u:syste=
m_r:initrc_t tcontext=3Dsystem_u:object_r:net_conf_t tclass=3Dfile
audit(1110042105.239:0): avc:  denied  { getattr } for  pid=3D2934 exe=3D/u=
sr/bin/fetchmail path=3D/.fetchids dev=3Dhda5 ino=3D12 scontext=3Dsystem_u:=
system_r:fetchmail_t tcontext=3Dsystem_u:object_r:default_t tclass=3Dfile
audit(1110042105.239:0): avc:  denied  { read } for  pid=3D2934 exe=3D/usr/=
bin/fetchmail name=3D.fetchids dev=3Dhda5 ino=3D12 scontext=3Dsystem_u:syst=
em_r:fetchmail_t tcontext=3Dsystem_u:object_r:default_t tclass=3Dfile

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCKle7fsSHBrPpqGcRAuCkAJ0W1IB1cFWi2TVzQ41gmVJYPKQ74gCfeiY9
0KXzmiIZEEODX1YwiYrtFck=
=yI71
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
