Subject: Re: a few questions about selinux, update on progress
From: max barwell <maxb@paradise.net.nz>
To: SElinux list <SELinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
In-Reply-To: <200307101451.29370.russell@coker.com.au>
References: <1057807940.1029.2.camel@orac.lite.net.nz>
	 <200307101451.29370.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-5mfOTqqyeKQJJQgSJ78N"
Message-Id: <1058168071.500.50.camel@orac.lite.net.nz>
Mime-Version: 1.0
Date: 14 Jul 2003 19:34:31 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5mfOTqqyeKQJJQgSJ78N
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-07-10 at 16:51, Russell Coker wrote:

> /etc/ld.so.cache has the wrong type, it's context should be 
> system_u:object_r:ld_so_cache_t (it's etc_t on your system).

fixed

> insmod is being run before /var is mounted (a common occurance, many modules 
> may be loaded early in the boot process, and the file system module for the 
> /var file system may be a module), in my latest policy tree I have the 
> following:
> dontaudit insmod_t file_t:dir search;

fixed

> For mounting the /tmp file system add the following to your policy (I'll add 
> it to my tree too):
> allow mount_t tmp_t:dir mounton;

fixed

> Not sure about the route lines, I'll have to look into that.

Ok, still have avc messages there, but not to worry

> For ntpdate add the following to your policy (I've just added it to my tree):
> allow ntpd_t self:process setsched;

fixed

> What is ttya0?

I don't know, I deleted all /dev/ttya* entries but now get errors about
/dev/ttyb0, I assume it's something to do with the setattr, and read
denied avc messages for /dev.

> For /dev/xconsole the best thing to do is to remove it from /etc/syslog.conf 
> and remove it from /etc/init.d/sysklogd.

fixed

> It looks like you are running a daemon as part of the Razor spam catching 
> system.  You need to write a policy for this based on the daemon_domain() 
> macro.

I was using razor, but I ditched it, I am using spamassassin, this gives
me errors, and then get errors relating to procmail, I think this is
because procmail is called from the spamassassin config, not sure
though, because procmail does have a policy loaded.

I have attached these as a file mail_errors.txt

> For gpm change this:
> file_type_auto_trans(gpm_t, device_t, gpmctl_t, fifo_file)
> To this:
> file_type_auto_trans(gpm_t, device_t, gpmctl_t, { sock_file fifo_file })

fixed

> miniserv.pl looks like another daemon that needs a policy.

Thats the daemon that webmin runs, I have removed webmin anyway so it
doesn't matter.

> What is atalkd?  It's another daemon that needs policy.

atalkd is the apple talk daemon, run by netatalk, as you mention further
on I need to write a policy for netatalk.

> For apache add the following:
> tmp_domain(httpd)

fixed

> Fetchmail needs policy.

just starting to read about creating my own policies, so either i'll
eventually make one, or someone else will.

> /dev/tty3 is not labeled.  At a guess you had a user with context 
> user:foo_r:foo_t who logged in on /dev/tty3, then you loaded a new policy 
> with no foo_t defined.  NB  The current Debian setup does not have the 
> terminal device relabeled on logout, this is something we have to fix.  
> However the same bad result would be achieved if you loaded the new policy 
> while the user was logged in.

I think this is fixed, well dont appear to have the problem anymore.

> 
> I haven't dealt with cups.  Let's sort out the other things first.  BTW  
> Having non-standard device names such as /dev/par1 will cause you pain with 
> SE Linux...

Yes I see cups is still a problem, unfortunately I need cups for my
printer, a canon i320, I had to use the turboprint drivers to get this
going, perhaps turboprint made the /dev/par1 devices, I am using a
standard Debian sid install otherwise.

> > psidfile_init : contexts did not exist, initialisation failed, error 2
> >
> > and
> >
> > id: can't get process context

still have these erorrs, but like you say below, if I sort out
everything else they should go away.
> 
> They correspond to errors reported in the dmesg.  Solve the dmesg problems and 
> they will go away.
> 
> > Also I must have changed something unwittingly, because it worked in the
> > beginning, the default context in /etc/security/default_contexts are not
> > being honoured, because when sshing into this machine, you still get a
> > choice of role, and can change role.
> 
> If sshing gives you a choice of role then you must have sshd configured to run 
> /bin/login.

no ssh is set /bin/false, so at a loss for this one

> > A couple more things, are there policies for apache php modules, and/or
> > netatalk, or are these things you have to write yourself. I also can't
> > start X, being told a number of things depending on role and user.
> 
> There is no policy for netatalk, look to the samba policy for ideas.

will do

> php should mostly just work when run via the Apache shared objects.  If you 
> run it as a cgi-bin script then there is policy, not sure whether it works.

ok will look into this, it's not essential

> > As sysadm_r there are errors about xauth and Xauthority being denied,
> > and as user_r i get an error about /dev/tty0 not existing.
> 
> After most of the errors discussed above are fixed, please tell us about the 
> details of these.

OK

> Also please CC me on messages related to Debian.  Messages about 
> Debian/unstable tend to be delayed on the list as the mailing list software 
> thinks that they are unsubscribe requests...

have cc'ed you this as requested.

Ok now for my new problems, these are regarding users, if you have
existing users do they have to have anything done to them, I added one
of them to /etc/selinux/users because I wanted to specify multiple
roles, but that's all I've done.

I tried to add a new user, suseradd jdoe, will add this user, but when I
do sadminpasswd jdoe, it says 

passwd: Module is unknown
Child returned an error.

and these are the errors in /var/log/messages

Jul 14 18:02:15 orac kernel:
Jul 14 18:02:15 orac kernel: avc:  denied  { read } for  pid=768
exe=/usr/bin/passwd path=/self dev=00:02 ino=2
scontext=maxb:sysadm_r:sysadm_passwd_t tcontext=system_u:object_r:proc_t
tclass=lnk_file
Jul 14 18:02:15 orac kernel:
Jul 14 18:02:15 orac kernel: avc:  denied  { lock } for  pid=768
exe=/usr/bin/passwd path=/run/utmp dev=03:07 ino=6664
scontext=maxb:sysadm_r:sysadm_passwd_t
tcontext=system_u:object_r:initrc_var_run_t tclass=file
Jul 14 18:02:46 orac kernel:
Jul 14 18:02:46 orac kernel: avc:  denied  { read write } for  pid=770
exe=/usr/sbin/useradd path=/log/faillog dev=03:07 ino=3814
scontext=maxb:sysadm_r:useradd_t tcontext=system_u:object_r:faillog_t
tclass=file
Jul 14 18:02:46 orac kernel:
Jul 14 18:02:46 orac kernel: avc:  denied  { read write } for  pid=770
exe=/usr/sbin/useradd path=/log/lastlog dev=03:07 ino=3793
scontext=maxb:sysadm_r:useradd_t tcontext=system_u:object_r:lastlog_t
tclass=file

I have also attached my a new dmesg, which has alot less errors than the
last time.

I have set up alot of things using Linux before, ldap, samba, web
servers, proxies etc, but am finding selinux about 1000 times more
challenging, with most things you can generally find answers on the web,
newsgroups etc, but I guess the small user base of selinux makes this
different.

I am trying to understand it all, have read most of the docs available
etc, but still feel like I can't solve alot of my problems by myself,
its frustrating. anyway keep up the good work all, and thanks for your
help.

max









--=-5mfOTqqyeKQJJQgSJ78N
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.4.20 (root@orac.lite.net.nz) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Sun Jul 6 01:29:07 NZST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1460.173 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2916.35 BogoMIPS
Memory: 512776k/524224k available (1088k kernel code, 11060k reserved, 407k data, 100k init, 0k highmem)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1700+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1460.1958 MHz.
..... host bus clock speed is 265.4902 MHz.
cpu: 0, clocks: 2654902, slice: 1327451
CPU0<T0:2654896,T1:1327440,D:5,S:1327451,C:2654902>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3020 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
Freeing initrd memory: 3020k freed
VFS: Mounted root (cramfs filesystem).
SELinux:  Completing initialization.
SELinux:  Unable to load the policy.
Freeing unused kernel memory: 100k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS730
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380023A, ATA DISK drive
hdc: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW SW-252B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue e0838d24, I/O limit 4095Mb (mask 0xffffffff)
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [9729/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Completing initialization.
security:  loading policy configuration from /etc/security/selinux/policy.12
security:  policydb is compressed, decompressing...
security:  decompressed 2297285 bytes
security:  4 users, 5 roles, 852 types
security:  29 classes, 93832 rules
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

avc:  denied  { read } for  pid=105 exe=/bin/bash path=/dev dev=03:02 ino=5585 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:device_t tclass=dir
hub.c: new USB device 00:01.2-3, assigned address 2
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with IntelliEye] on usb2:2.0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev 03:05, type ext3), uses PSIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
psidfiles_init:  contexts did not exist
psidfiles_init:  initialization failed, error 2
superblock_doinit: psid_init returned 2... (filesystem=/, pid=122)
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

avc:  denied  { ioctl } for  pid=147 exe=/sbin/route path=socket:[177] dev=00:00 ino=177 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=udp_socket

avc:  denied  { setattr } for  pid=211 exe=/bin/chmod path=/dev/ttyb0 dev=03:02 ino=6280 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { read } for  pid=241 exe=/usr/bin/perl path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file

avc:  denied  { ioctl } for  pid=241 exe=/usr/bin/perl path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file

avc:  denied  { read } for  pid=241 exe=/usr/bin/perl path=/etc/shadow dev=03:02 ino=150 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { ioctl } for  pid=241 exe=/usr/bin/perl path=socket:[326] dev=00:00 ino=326 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).

avc:  denied  { read } for  pid=247 exe=/usr/lib/cups/backend/parallel path=/sys/dev/parport/parport0/autoprobe dev=00:02 ino=4527 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:sysctl_dev_t tclass=file

avc:  denied  { getattr } for  pid=247 exe=/usr/lib/cups/backend/parallel path=/sys/dev/parport/parport0/autoprobe dev=00:02 ino=4527 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:sysctl_dev_t tclass=file

avc:  denied  { write } for  pid=247 exe=/usr/lib/cups/backend/parallel path=/dev/par1 dev=03:02 ino=6615 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { write } for  pid=253 exe=/usr/lib/cups/backend/serial path=/dev/ttyS0 dev=03:02 ino=6602 scontext=system_u:system_r:cupsd_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { read } for  pid=344 exe=/bin/hostname path=/etc/resolv.conf dev=03:02 ino=1161 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:resolv_conf_t tclass=file
NET4: AppleTalk 0.18a for Linux NET4.0

avc:  denied  { ioctl } for  pid=348 exe=/usr/sbin/atalkd path=socket:[623] dev=00:00 ino=623 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

avc:  denied  { ioctl } for  pid=348 exe=/usr/sbin/atalkd path=socket:[622] dev=00:00 ino=622 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=socket

avc:  denied  { read } for  pid=374 exe=/bin/su path=/etc/shadow dev=03:02 ino=150 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { getattr } for  pid=375 exe=/usr/bin/fetchmail path=socket:[854] dev=00:00 ino=854 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=udp_socket

avc:  denied  { read } for  pid=375 exe=/usr/bin/fetchmail path=socket:[857] dev=00:00 ino=857 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

avc:  denied  { write } for  pid=375 exe=/usr/bin/fetchmail path=socket:[857] dev=00:00 ino=857 scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t tclass=tcp_socket

--=-5mfOTqqyeKQJJQgSJ78N
Content-Disposition: attachment; filename=mail_errors.txt
Content-Type: text/plain; name=mail_errors.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jul 14 17:54:24 orac kernel: avc:  denied  { write } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin dev=03:0a ino=41455 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { add_name } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { create } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { write } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 dev=03:0a ino=33589 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { link } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 dev=03:0a ino=33589 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { remove_name } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 dev=03:0a ino=33589 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { unlink } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes.lock.orac.lite.net.nz.602 dev=03:0a ino=33589 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { append } for  pid=602 exe=/usr/bin/perl path=/maxb/.spamassassin/bayes_msgcount dev=03:0a ino=41460 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:user_home_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { write } for  pid=599 exe=/usr/bin/procmail path=/mail dev=03:07 ino=6705 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { add_name } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { create } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { write } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz dev=03:07 ino=386 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { link } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz dev=03:07 ino=386 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { remove_name } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz dev=03:07 ino=386 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=dir
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { unlink } for  pid=599 exe=/usr/bin/procmail path=/mail/_XJ.QWkE_.orac.lite.net.nz dev=03:07 ino=386 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { append } for  pid=599 exe=/usr/bin/procmail path=/mail/maxb dev=03:07 ino=6706 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file
Jul 14 17:54:24 orac kernel: 
Jul 14 17:54:24 orac kernel: avc:  denied  { lock } for  pid=599 exe=/usr/bin/procmail path=/mail/maxb dev=03:07 ino=6706 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:mail_spool_t tclass=file

--=-5mfOTqqyeKQJJQgSJ78N--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
