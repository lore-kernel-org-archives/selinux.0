Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4NIDeRb006397
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 14:13:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4NIBBB2027690
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 18:11:11 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
	by jazzswing.ncsc.mil  with ESMTP id i4NIBAwi027687
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 18:11:10 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 23 May 2004 20:13:32 +0200
Date: Sun, 23 May 2004 20:13:19 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Bootup problems
Message-Id: <20040523181318.GA2104@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ylS2wUBXLOxYXZFQ
Content-Type: multipart/mixed; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached dmesg (non-relevant lines before and after snipped) is the
bootlog of a 2.6.6er-kernel on a SuSE 9.0 system. No initrd, no special
modules (only sound as module, everything else compiled in).
The system works fine afterwards, the filesystem is properly labeled.
It just seems like it is the file labels are initialized to late.
Anyone knows why this is happening or where I should look?

Thomas

re: the last audit deny: /soft is the root of an nfs-mount. Later in the
process it is correctly treated as nfs_t.
PS: This also happend with 2.6.5, it is no new problem of 2.6.6
--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 484k freed
usb 2-2: new low speed USB device using address 2
security:  22 users, 5 roles, 577 types, 1 bools
security:  30 classes, 60011 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev , type selinuxfs), uses genfs_contexts
audit(1085334438.959:0): avc:  denied  { execute_no_trans } for  pid=141 comm=khelper path=/sbin/hotplug dev=hda3 ino=1589274 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=file
audit(1085334438.963:0): avc:  denied  { read } for  pid=141 comm=khelper path=/sbin/hotplug dev=hda3 ino=1589274 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=file
audit(1085334438.968:0): avc:  denied  { execute } for  pid=141 comm=khelper name=bash dev=hda3 ino=671755 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=file
audit(1085334438.974:0): avc:  denied  { getattr } for  pid=141 exe=/bin/bash path=/etc/ld.so.cache dev=hda3 ino=213295 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:unlabeled_t tclass=file
input: USB HID v1.10 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-2
SELinux: initialized (dev hda3, type ext3), uses xattr
audit(1085334439.166:0): avc:  denied  { read write } for  pid=137 exe=/bin/bash name=tty dev=hda3 ino=69775 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:devtty_t tclass=chr_file
SELinux: initialized (dev , type usbfs), uses genfs_contexts
SELinux: initialized (dev , type usbdevfs), uses genfs_contexts
audit(1085334439.298:0): avc:  denied  { read } for  pid=137 exe=/bin/bash name=mtab dev=hda3 ino=213423 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_runtime_t tclass=file
audit(1085334439.298:0): avc:  denied  { getattr } for  pid=137 exe=/bin/bash path=/etc/mtab dev=hda3 ino=213423 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_runtime_t tclass=file
SELinux: initialized (dev , type devpts), uses transition SIDs
SELinux: initialized (dev , type eventpollfs), uses genfs_contexts
SELinux: initialized (dev , type pipefs), uses task SIDs
SELinux: initialized (dev , type tmpfs), uses transition SIDs
SELinux: initialized (dev , type futexfs), uses genfs_contexts
SELinux: initialized (dev , type sockfs), uses task SIDs
SELinux: initialized (dev , type proc), uses genfs_contexts
SELinux: initialized (dev , type bdev), uses genfs_contexts
SELinux: initialized (dev , type rootfs), uses genfs_contexts
SELinux: initialized (dev , type sysfs), uses genfs_contexts
audit(1085334439.441:0): avc:  denied  { read } for  pid=137 exe=/bin/bash name=nsswitch.conf dev=hda3 ino=213031 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=file
audit(1085334439.449:0): avc:  denied  { getattr } for  pid=137 exe=/bin/bash path=/etc/nsswitch.conf dev=hda3 ino=213031 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=file
audit(1085334439.616:0): avc:  denied  { ioctl } for  pid=140 exe=/bin/bash path=/sbin/hotplug dev=hda3 ino=1589274 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:hotplug_exec_t tclass=file
audit(1085334440.578:0): avc:  denied  { search } for  pid=337 exe=/sbin/showconsole name=proc dev=hda3 ino=32769 scontext=system_u:system_r:showconsole_t tcontext=system_u:object_r:file_t tclass=dir
audit(1085334440.664:0): avc:  denied  { getattr } for  pid=337 exe=/sbin/showconsole path=/dev/pts dev=hda3 ino=98305 scontext=system_u:system_r:showconsole_t tcontext=system_u:object_r:file_t tclass=dir
audit(1085334440.674:0): avc:  denied  { read } for  pid=337 exe=/sbin/showconsole name=pts dev=hda3 ino=98305 scontext=system_u:system_r:showconsole_t tcontext=system_u:object_r:file_t tclass=dir
Adding 1534196k swap on /dev/hda2.  Priority:42 extents:1
EXT3 FS on hda3, internal journal
SELinux: initialized (dev , type tmpfs), uses transition SIDs
Disabled Privacy Extensions on device c05cfd40(lo)
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
HTB init, kernel part version 3.16
HTB: quantum of class 10001 is big. Consider r2q change.
HTB: quantum of class 10011 is big. Consider r2q change.
audit(1085334473.044:0): avc:  denied  { getattr } for  pid=1741 exe=/bin/mount path=/mnt/storage01 dev=hda3 ino=1507869 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:file_t tclass=dir
SELinux: initialized (dev , type rpc_pipefs), uses genfs_contexts
SELinux: initialized (dev 0:e, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:10, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:11, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:12, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:13, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:14, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
audit(1085334477.241:0): avc:  denied  { search } for  pid=1753 exe=/sbin/ldconfig name=soft dev=hda3 ino=8700040 scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:file_t tclass=dir
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49289 usecs
intel8x0: clocking to 48000

--zCKi3GIZzVBPywwA--

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsOm+xWIrrrL0q+cRAoCdAJwPP2uNTsgZxewPkvH4ifgvvo0tKgCffdyE
a3HZfSNcCBzU6lgEogsKryY=
=n+mD
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
