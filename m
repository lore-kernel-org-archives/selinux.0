Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6NVWIi025048
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 18:31:32 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6NTtHW015658
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 23:29:56 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 7 Dec 2004 00:31:34 +0100
Date: Tue, 7 Dec 2004 00:31:35 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: proc cleanup
Message-Id: <20041206233135.GC3678@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--E/DnYTRukya0zdZ1
Content-Type: multipart/mixed; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A pure cleanup patch to make some proc stuff easier to read.
Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/macros/global_macros.te
+++ mod/macros/global_macros.te
@@ -169,10 +169,9 @@
 #=20
 define(`general_proc_read_access',`
 # Read system information files in /proc.
-allow $1 proc_t:dir r_dir_perms;
-allow $1 proc_t:notdevfile_class_set r_file_perms;
-allow $1 proc_mdstat_t:file r_file_perms;
+r_dir_file($1, proc_t)
 r_dir_file($1, proc_net_t)
+allow $1 proc_mdstat_t:file r_file_perms;
=20
 # Stat /proc/kmsg and /proc/kcore.
 allow $1 proc_fs:file stat_file_perms;
--- orig/domains/program/unused/hotplug.te
+++ mod/domains/program/hotplug.te
@@ -27,9 +28,7 @@
 allow hotplug_t sysctl_net_t:file { getattr read };
=20
 # get info from /proc
-allow hotplug_t proc_t:dir r_dir_perms;
-allow hotplug_t proc_t:file r_file_perms;
-allow hotplug_t proc_t:lnk_file read;
+r_dir_file(hotplug_t, proc_t)
 allow hotplug_t self:file { getattr read };
=20
 allow hotplug_t devtty_t:chr_file rw_file_perms;
--- orig/domains/program/init.te
+++ mod/domains/program/init.te
@@ -87,12 +87,8 @@
 var_run_domain(init)
=20
 # Shutdown permissions
-allow init_t proc_t:dir r_dir_perms;
-allow init_t proc_t:lnk_file r_file_perms;
-allow init_t proc_t:file r_file_perms;
-allow init_t self:dir r_dir_perms;
-allow init_t self:lnk_file r_file_perms;
-allow init_t self:file r_file_perms;
+r_dir_file(init_t, proc_t)
+r_dir_file(init_t, self)
 allow init_t devpts_t:dir r_dir_perms;
=20
 # Modify wtmp.
--- orig/domains/program/initrc.te
+++ mod/domains/program/initrc.te
@@ -34,8 +43,7 @@
 r_dir_file(initrc_t, usr_t)
=20
 # Read system information files in /proc.
-allow initrc_t proc_t:dir r_dir_perms;
-allow initrc_t proc_t:{ file lnk_file } r_file_perms;
+r_dir_file(initrc_t, { proc_t proc_net_t })
 allow initrc_t proc_mdstat_t:file { getattr read };
=20
 # Allow IPC with self
--- orig/domains/program/login.te
+++ mod/domains/program/login.te
@@ -23,8 +23,7 @@
 general_domain_access($1_login_t);
=20
 # Read system information files in /proc.
-allow $1_login_t proc_t:dir r_dir_perms;
-allow $1_login_t proc_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_login_t, proc_t)
=20
 base_file_read_access($1_login_t)
=20
--- orig/domains/program/sulogin.te
+++ mod/domains/program/sulogin.te
@@ -32,8 +33,7 @@
 r_dir_file(sulogin_t, etc_t)
=20
 allow sulogin_t bin_t:dir r_dir_perms;
-allow sulogin_t proc_t:dir r_dir_perms;
-allow sulogin_t proc_t:notdevfile_class_set r_file_perms;
+r_dir_file(sulogin_t, proc_t)
 allow sulogin_t root_t:dir search;
=20
 allow sulogin_t sysadm_devpts_t:chr_file { getattr ioctl read write };
--- orig/macros/user_macros.te
+++ mod/macros/user_macros.te
@@ -39,7 +39,7 @@
=20
 # for ls -l /proc
 dontaudit $1_t { sysctl_irq_t sysctl_t }:dir getattr;
-dontaudit $1_t { mtrr_device_t proc_kcore_t proc_kmsg_t }:file getattr;
+dontaudit $1_t proc_fs:file getattr;
=20
 allow $1_t boot_t:dir { getattr search };
 dontaudit $1_t boot_t:dir read;
@@ -133,8 +133,7 @@
=20
 attribute $1_file_type;
 # Grant read/search permissions to some of /proc.
-allow $1_t proc_t:dir r_dir_perms;
-allow $1_t proc_t:{ file lnk_file } r_file_perms;
+r_dir_file($1_t, proc_t)
=20
 base_file_read_access($1_t)
=20

--s/l3CgOIzMHHjg/5--

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtOvXxWIrrrL0q+cRAgvqAJ42VXCrFPKoVXpDRR+6S09cC39iFACgiR/V
7gc+G/dLAPDnb79Ty/9COMM=
=j5cC
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
