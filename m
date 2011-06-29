Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5TBHOU9001064
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 07:17:24 -0400
Received: from mail.gw90.de (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5TBHNwX017088
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 11:17:23 GMT
Subject: Linux kernel 2.6.32 from Debian Squeeze and Xen: SELinux seems to
 hang around 10 minutes during boot
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JpUtpDr5JqFwPPSCYL+L"
Date: Wed, 29 Jun 2011 13:17:19 +0200
Message-ID: <1309346239.4648.23.camel@mattotaupa>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JpUtpDr5JqFwPPSCYL+L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SELinux folks,


I hope this is the correct list for users to report problems.

Running a Xen dom0 with Debian Squeeze with

        ii  linux-image-2.6.32-5-xen-amd64          2.6.32-35              =
      Linux 2.6.32 for 64-bit PCs, Xen dom0 support

and passing `selinux=3D1` (from `/proc/cmdline`) to the command line the bo=
ot hangs for around ten minutes.

`dmesg` has the following messages.

        [=E2=80=A6]
        [    2.204014] Calibrating delay loop (skipped), value calculated u=
sing timer frequency.. 5346.75 BogoMIPS (lpj=3D10693504)
        [    2.204026] Security Framework initialized
        [    2.204031] SELinux:  Initializing.
        [    2.204037] SELinux:  Starting in permissive mode
        [    2.205178] Dentry cache hash table entries: 1048576 (order: 11,=
 8388608 bytes)
        [    2.207298] Inode-cache hash table entries: 524288 (order: 10, 4=
194304 bytes)
        [    2.208088] Mount-cache hash table entries: 256
        [    2.208212] Initializing cgroup subsys ns
        [    2.208215] Initializing cgroup subsys cpuacct
        [    2.208219] Initializing cgroup subsys devices
        [    2.208222] Initializing cgroup subsys freezer
        [    2.208224] Initializing cgroup subsys net_cls
        [    2.208255] CPU: L1 I cache: 32K, L1 D cache: 32K
        [    2.208257] CPU: L2 cache: 256K
        [    2.208258] CPU: L3 cache: 8192K
        [    2.208262] CPU 0/0x0 -> Node 0
        [    2.208264] CPU: Unsupported number of siblings 16
        [    2.208267] mce: CPU supports 9 MCE banks
        [    2.208288] Performance Events: unsupported p6 CPU model 26 no P=
MU driver, software events only.
        [    2.208300] SMP alternatives: switching to UP code
        [    2.229476] ACPI: Core revision 20090903
        [    2.260346]   alloc irq_desc for 2302 on node -1
        [    2.260348]   alloc kstat_irqs on node -1
        [    2.260355]   alloc irq_desc for 2301 on node -1
        [    2.260357]   alloc kstat_irqs on node -1
        [    2.260361]   alloc irq_desc for 2300 on node -1
        [    2.260362]   alloc kstat_irqs on node -1
        [    2.260366]   alloc irq_desc for 2299 on node -1
        [    2.260367]   alloc kstat_irqs on node -1
        [    2.260512] installing Xen timer for CPU 1
        [    2.260515]   alloc irq_desc for 2298 on node -1
        [    2.260517]   alloc kstat_irqs on node -1
        [    2.260538] SMP alternatives: switching to SMP code
        [=E2=80=A6]
        [    2.427623] msgmni has been set to 13460
        [    2.427689] SELinux:  Registering netfilter hooks
        [    2.428038] alg: No test for stdrng (krng)
        [    2.428087] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 253)
        [=E2=80=A6]
        [    9.023551] type=3D1404 audit(1309247866.082:2): enforcing=3D1 o=
ld_enforcing=3D0 auid=3D4294967295 ses=3D4294967295
        [    9.137904] SELinux: 8192 avtab hash slots, 26860 rules.
        [    9.142904] SELinux: 8192 avtab hash slots, 26860 rules.
        [    9.143463] SELinux:  6 users, 6 roles, 1240 types, 38 bools, 1 =
sens, 1024 cats
        [    9.143466] SELinux:  77 classes, 26860 rules
        [    9.144719] SELinux:  Completing initialization.
        [    9.144721] SELinux:  Setting up existing superblocks.
        [    9.144859] SELinux: initialized (dev md0, type ext3), uses xatt=
r
        [    9.144936] SELinux: initialized (dev usbfs, type usbfs), uses g=
enfs_contexts
        [    9.144942] SELinux: initialized (dev selinuxfs, type selinuxfs)=
, uses genfs_contexts
        [    9.144951] SELinux: initialized (dev mqueue, type mqueue), uses=
 transition SIDs
        [    9.144956] SELinux: initialized (dev hugetlbfs, type hugetlbfs)=
, uses transition SIDs
        [    9.144960] SELinux: initialized (dev devpts, type devpts), uses=
 transition SIDs
        [    9.144965] SELinux: initialized (dev inotifyfs, type inotifyfs)=
, uses genfs_contexts
        [    9.144969] SELinux: initialized (dev anon_inodefs, type anon_in=
odefs), uses genfs_contexts
        [    9.144971] SELinux: initialized (dev pipefs, type pipefs), uses=
 task SIDs
        [    9.144975] SELinux: initialized (dev debugfs, type debugfs), us=
es genfs_contexts
        [    9.145038] SELinux: initialized (dev sockfs, type sockfs), uses=
 task SIDs
        [    9.145041] SELinux: initialized (dev devtmpfs, type devtmpfs), =
uses transition SIDs
        [    9.145379] SELinux: initialized (dev tmpfs, type tmpfs), uses t=
ransition SIDs
        [    9.145385] SELinux: initialized (dev proc, type proc), uses gen=
fs_contexts
        [    9.145391] SELinux: initialized (dev bdev, type bdev), uses gen=
fs_contexts
        [    9.145394] SELinux: initialized (dev rootfs, type rootfs), uses=
 genfs_contexts
        [    9.145397] SELinux: initialized (dev sysfs, type sysfs), uses g=
enfs_contexts
        [    9.235165] type=3D1403 audit(1309247866.294:3): policy loaded a=
uid=3D4294967295 ses=3D4294967295
        [    9.538501] SELinux: initialized (dev tmpfs, type tmpfs), uses t=
ransition SIDs
        [    9.893428] udev[445]: starting version 164
        [   10.253325] ACPI: WMI: Mapper loaded
        [=E2=80=A6]
        [   11.034386] No connectors reported connected with modes
        [   11.034392] [drm] Initialized nouveau 0.0.15 20090420 for 0000:0=
2:00.0 on minor 0
        [   11.099470] SELinux: initialized (dev tmpfs, type tmpfs), uses t=
ransition SIDs
        [  624.864340] Adding 1048568k swap on /dev/mapper/xkcd-dom0--swap.=
  Priority:-1 extents:1 across:1048568k
        [=E2=80=A6]

Is that a know problem? Can I provide other information? The only
problem is that I cannot test anything since this is a production
system. I even cannot test if passing `selinux=3D0` improves anything.


Thanks,

Paul

--=-JpUtpDr5JqFwPPSCYL+L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4LCb8ACgkQPX1aK2wOHVijWwCaAhFzydthrPYGMnm8jCjD6qMS
+Q8An3GTY9eTbVvK5pfZniI5porOnI7K
=mMcg
-----END PGP SIGNATURE-----

--=-JpUtpDr5JqFwPPSCYL+L--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
