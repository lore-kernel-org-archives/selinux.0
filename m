Subject: a few questions about selinux
From: max barwell <maxb@paradise.net.nz>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-WNO6d4mTLJReNsyzUx5g"
Message-Id: <1057807940.1029.2.camel@orac.lite.net.nz>
Mime-Version: 1.0
Date: 10 Jul 2003 15:32:20 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WNO6d4mTLJReNsyzUx5g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have just started using selinux and find it very interesting, I also
saw Russel Cokers interview at The Age and was pleased to note that
selinux is being adopted by the "smarter linux users".

I am using Debian sid, with debian kernel source 2.4.20.

I notice I get alot of avc denied errors on boot, and wondered if they
were normal, I have attached my dmesg output, so if someone could please
look at that.

Another couple of errors I have noticed are:

psidfile_init : contexts did not exist, initialisation failed, error 2

and

id: can't get process context

are these serious?

Also I must have changed something unwittingly, because it worked in the
beginning, the default context in /etc/security/default_contexts are not
being honoured, because when sshing into this machine, you still get a
choice of role, and can change role.

A couple more things, are there policies for apache php modules, and/or
netatalk, or are these things you have to write yourself. I also can't
start X, being told a number of things depending on role and user.

As sysadm_r there are errors about xauth and Xauthority being denied,
and as user_r i get an error about /dev/tty0 not existing.

sorry for the huge list of problems, but I would love to these sorted.

regards Max

--=-WNO6d4mTLJReNsyzUx5g
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=UTF-8
Content-Transfer-Encoding: 8bit

ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-252B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue e0838d24, I/O limit 4095Mb (mask 0xffffffff)
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [9729/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Journalled Block Device driver loaded
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,2): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 32
ext3_orphan_cleanup: deleting unreferenced inode 26
EXT3-fs: ide0(3,2): 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Completing initialization.
security:  loading policy configuration from /etc/security/selinux/policy.12
security:  policydb is compressed, decompressing...
security:  decompressed 1626216 bytes
security:  4 users, 5 roles, 664 types
security:  29 classes, 66308 rules
SELinux: initialized (dev 03:02, type ext3), uses PSIDs
SELinux: initialized (dev 01:00, type cramfs), not configured for labeling
SELinux: initialized (dev 00:07, type devpts), uses transition SIDs
SELinux: initialized (dev 00:06, type devfs), uses genfs_contexts
SELinux: initialized (dev 00:05, type pipefs), uses task SIDs
SELinux: initialized (dev 00:04, type tmpfs), uses transition SIDs
SELinux: initialized (dev 00:03, type sockfs), uses task SIDs
SELinux: initialized (dev 00:02, type proc), uses genfs_contexts
SELinux: initialized (dev 00:01, type bdev), not configured for labeling
SELinux: initialized (dev 00:00, type rootfs), not configured for labeling
Adding Swap: 498004k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal

avc:  denied  { read } for  pid=65 exe=/sbin/hwclock path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:hwclock_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { getattr } for  pid=65 exe=/sbin/hwclock path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:hwclock_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { read } for  pid=66 exe=/sbin/modprobe path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:insmod_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { getattr } for  pid=66 exe=/sbin/modprobe path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:insmod_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { search } for  pid=66 exe=/sbin/insmod.modutils path=/var dev=03:02 ino=2129 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:file_t tclass=dir
Real Time Clock Driver v1.10e
spurious 8259A interrupt: IRQ7.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 5 for device 00:01.3
PCI: Sharing IRQ 5 with 00:01.2
usb-ohci.c: USB OHCI at membase 0xe08bc000, IRQ 5
usb-ohci.c: usb-00:01.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 5 for device 00:01.2
PCI: Sharing IRQ 5 with 00:01.3
usb-ohci.c: USB OHCI at membase 0xe08be000, IRQ 5
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 01:49:09 Jul  6 2003
PCI: Found IRQ 11 for device 00:01.4
trident: SiS 7018 PCI Audio found at IO 0xd800, IRQ 11
ac97_codec: AC97 Audio codec, id: VIA97(Unknown)
sis900.c: v1.08.06 9/24/2002
PCI: Found IRQ 3 for device 00:01.1
eth0: Unknown PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 3, 00:07:95:36:bf:c0.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: DVD-ROM SD-616Q   Rev: F403
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SAMSUNG   Model: CD-R/RW SW-252B   Rev: R700
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
hub.c: new USB device 00:01.2-1, assigned address 2
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04A9 pid 0x107B
hub.c: new USB device 00:01.2-3, assigned address 3
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with IntelliEye] on usb2:3.0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:05, type ext3), uses PSIDs

avc:  denied  { mounton } for  pid=124 exe=/bin/mount path=/tmp dev=03:02 ino=1153 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:tmp_t tclass=dir
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
psidfiles_init:  contexts did not exist
psidfiles_init:  initialization failed, error 2
superblock_doinit: psid_init returned 2... (filesystem=/, pid=124)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:07, type ext3), uses PSIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:08, type ext3), uses PSIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:09, type ext3), uses PSIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:0a, type ext3), uses PSIDs

avc:  denied  { read } for  pid=144 exe=/sbin/ifconfig path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:ifconfig_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { getattr } for  pid=144 exe=/sbin/ifconfig path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:ifconfig_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { ioctl } for  pid=148 exe=/sbin/route path=socket:[187] dev=00:00 ino=187 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=udp_socket

avc:  denied  { setsched } for  pid=192 exe=/usr/sbin/ntpdate scontext=system_u:system_r:ntpd_t tcontext=system_u:system_r:ntpd_t tclass=process

avc:  denied  { setattr } for  pid=234 exe=/bin/chmod path=/dev/ttya0 dev=03:02 ino=6248 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=258 exe=/bin/chmod path=/dev/xconsole dev=03:02 ino=6970 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:device_t tclass=fifo_file

avc:  denied  { read write } for  pid=261 exe=/sbin/syslogd path=/dev/xconsole dev=03:02 ino=6970 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:device_t tclass=fifo_file

avc:  denied  { ioctl } for  pid=261 exe=/sbin/syslogd path=/dev/xconsole dev=03:02 ino=6970 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:device_t tclass=fifo_file

avc:  denied  { read } for  pid=266 exe=/usr/bin/perl path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file

avc:  denied  { ioctl } for  pid=266 exe=/usr/bin/perl path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file

avc:  denied  { read } for  pid=266 exe=/usr/bin/perl path=/etc/shadow dev=03:02 ino=40 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { ioctl } for  pid=266 exe=/usr/bin/perl path=socket:[339] dev=00:00 ino=339 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected

avc:  denied  { append } for  pid=267 exe=/usr/bin/perl path=/razor-agent.log dev=03:02 ino=17 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:file_t tclass=file

avc:  denied  { ioctl } for  pid=267 exe=/usr/bin/perl path=/razor-agent.log dev=03:02 ino=17 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:file_t tclass=file
lp0: using parport0 (polling).

avc:  denied  { read } for  pid=272 exe=/usr/lib/cups/backend/parallel path=/sys/dev/parport/parport0/autoprobe dev=00:02 ino=4527 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:sysctl_dev_t tclass=file

avc:  denied  { getattr } for  pid=272 exe=/usr/lib/cups/backend/parallel path=/sys/dev/parport/parport0/autoprobe dev=00:02 ino=4527 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:sysctl_dev_t tclass=file

avc:  denied  { write } for  pid=272 exe=/usr/lib/cups/backend/parallel path=/dev/par1 dev=03:02 ino=6615 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { write } for  pid=278 exe=/usr/lib/cups/backend/serial path=/dev/ttyS0 dev=03:02 ino=6602 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { sid_to_context } for  pid=287 exe=/usr/bin/id scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:security_t tclass=security

avc:  denied  { read } for  pid=288 exe=/usr/sbin/gpm path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:gpm_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { getattr } for  pid=288 exe=/usr/sbin/gpm path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:gpm_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { read } for  pid=267 exe=/usr/bin/perl path=socket:[416] dev=00:00 ino=416 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

avc:  denied  { write } for  pid=267 exe=/usr/bin/perl path=socket:[416] dev=00:00 ino=416 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

avc:  denied  { unlink } for  pid=289 exe=/usr/sbin/gpm path=/dev/gpmctl dev=03:02 ino=4091 scontext=system_u:system_r:gpm_t tcontext=system_u:object_r:device_t tclass=sock_file

avc:  denied  { create } for  pid=289 exe=/usr/sbin/gpm path=/dev/gpmctl scontext=system_u:system_r:gpm_t tcontext=system_u:object_r:device_t tclass=sock_file

avc:  denied  { setattr } for  pid=289 exe=/usr/sbin/gpm path=/dev/gpmctl dev=03:02 ino=4091 scontext=system_u:system_r:gpm_t tcontext=system_u:object_r:device_t tclass=sock_file

avc:  denied  { getattr } for  pid=267 exe=/usr/bin/perl path=socket:[521] dev=00:00 ino=521 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=udp_socket

avc:  denied  { read } for  pid=356 exe=/sbin/modprobe path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:insmod_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { getattr } for  pid=356 exe=/sbin/modprobe path=/etc/ld.so.cache dev=03:02 ino=31 scontext=system_u:system_r:insmod_t tcontext=maxb:object_r:etc_t tclass=file

avc:  denied  { execute } for  pid=358 exe=/sbin/start-stop-daemon path=/share/webmin/miniserv.pl dev=03:08 ino=383591 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:usr_t tclass=file

avc:  denied  { execute_no_trans } for  pid=358 exe=/sbin/start-stop-daemon path=/share/webmin/miniserv.pl dev=03:08 ino=383591 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:usr_t tclass=file
NET4: AppleTalk 0.18a for Linux NET4.0

avc:  denied  { read } for  pid=358 exe=/usr/bin/perl path=/etc/shadow dev=03:02 ino=40 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { ioctl } for  pid=376 exe=/usr/sbin/atalkd path=socket:[669] dev=00:00 ino=669 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=socket

avc:  denied  { search } for  pid=393 exe=/usr/sbin/apache path=/tmp dev=03:02 ino=1153 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=dir

avc:  denied  { write } for  pid=393 exe=/usr/sbin/apache path=/tmp dev=03:02 ino=1153 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=dir

avc:  denied  { add_name } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=dir

avc:  denied  { create } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { setattr } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem dev=03:02 ino=15 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { write } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem dev=03:02 ino=15 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { read } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem dev=03:02 ino=15 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { lock } for  pid=393 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.sem dev=03:02 ino=33 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { remove_name } for  pid=394 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem dev=03:02 ino=15 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=dir

avc:  denied  { unlink } for  pid=394 exe=/usr/sbin/apache path=/tmp/session_mm_apache0.mem dev=03:02 ino=15 scontext=system_u:system_r:httpd_t tcontext=system_u:object_r:tmp_t tclass=file

avc:  denied  { read } for  pid=404 exe=/usr/bin/fetchmail path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file

avc:  denied  { getattr } for  pid=411 exe=/sbin/getty path=/dev/tty3 dev=03:02 ino=6419 scontext=system_u:system_r:getty_t tcontext=root:object_r:unlabeled_t tclass=chr_file

avc:  denied  { read write } for  pid=411 exe=/sbin/getty path=/dev/tty3 dev=03:02 ino=6419 scontext=system_u:system_r:getty_t tcontext=root:object_r:unlabeled_t tclass=chr_file

avc:  denied  { ioctl } for  pid=411 exe=/sbin/getty path=/dev/tty3 dev=03:02 ino=6419 scontext=system_u:system_r:getty_t tcontext=root:object_r:unlabeled_t tclass=chr_file

avc:  denied  { setattr } for  pid=411 exe=/sbin/getty path=/dev/tty3 dev=03:02 ino=6419 scontext=system_u:system_r:getty_t tcontext=root:object_r:unlabeled_t tclass=chr_file

avc:  denied  { read } for  pid=404 exe=/usr/bin/fetchmail path=socket:[930] dev=00:00 ino=930 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

avc:  denied  { write } for  pid=404 exe=/usr/bin/fetchmail path=socket:[930] dev=00:00 ino=930 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

--=-WNO6d4mTLJReNsyzUx5g--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
