Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9ILvTrT025577
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 17:57:29 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9ILvS5X023830
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 21:57:28 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 18 Oct 2004 23:57:27 +0200
Date: Mon, 18 Oct 2004 23:58:02 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: cdrecord patch [was: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)]
Message-Id: <20041018215802.GD2536@jmh.mhn.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <20041018143842.GP19398@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
In-Reply-To: <20041018143842.GP19398@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--3O1VwFp74L81IIeR
Content-Type: multipart/mixed; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-10-18 17:47]:
> ah ha!  thomas, thank you v. much: i [badly] hacked up something
> for k3b to use some time ago.
>=20
> On Mon, Oct 18, 2004 at 02:43:32PM +0200, Thomas Bleher wrote:
>=20
> > I have just written selinux policy for cdrecord. While writing this=20
> > policy cdrecord constantly locked up the computer (even in permissive
> > mode). When booting with selinux=3D0 the problem went away.

Attached is an updated policy for inclusion into CVS. The previous
version missed some permissions. With the current version I have
successfully burnt a CD in enforcing mode.

Thomas

PS: This patch uses the can_resmgrd_connect() macro which was posted a
while but is not yet in CVS. It can be removed if the other patch is not
merged.

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdrecord.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/unused/cdrecord.te mod/domains/program/unuse=
d/cdrecord.te
--- orig/domains/program/unused/cdrecord.te	1970-01-01 01:00:00.000000000 +=
0100
+++ mod/domains/program/unused/cdrecord.te	2004-10-18 23:51:18.000000000 +0=
200
@@ -0,0 +1,10 @@
+# DESC cdrecord - record audio or data Compact Disks or Digital Versatile =
Disks from a master
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+
+# Type for the cdrecord excutable.
+type cdrecord_exec_t, file_type, sysadmfile, exec_type;
+
+# everything else is in the cdrecord_domain macros in
+# macros/program/cdrecord_macros.te.
+
diff -urN orig/file_contexts/program/cdrecord.fc mod/file_contexts/program/=
cdrecord.fc
--- orig/file_contexts/program/cdrecord.fc	1970-01-01 01:00:00.000000000 +0=
100
+++ mod/file_contexts/program/cdrecord.fc	2004-10-18 23:51:44.000000000 +02=
00
@@ -0,0 +1,3 @@
+# cdrecord
+/usr/bin/cdrecord	--	system_u:object_r:cdrecord_exec_t
+
diff -urN orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2004-10-18 23:50:53.000000000 +0200
+++ mod/macros/base_user_macros.te	2004-10-18 23:37:59.000000000 +0200
@@ -167,6 +167,7 @@
 ifdef(`irc.te', `irc_domain($1)')
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
+ifdef(`cdrecord.te', `cdrecord_domain($1)')
=20
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -urN orig/macros/program/cdrecord_macros.te mod/macros/program/cdrecor=
d_macros.te
--- orig/macros/program/cdrecord_macros.te	1970-01-01 01:00:00.000000000 +0=
100
+++ mod/macros/program/cdrecord_macros.te	2004-10-18 23:51:36.000000000 +02=
00
@@ -0,0 +1,51 @@
+# macros for the cdrecord domain
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+
+define(`cdrecord_domain', `
+type $1_cdrecord_t, domain, privlog;
+
+domain_auto_trans($1_t, cdrecord_exec_t, $1_cdrecord_t)
+
+# The user role is authorized for this domain.
+role $1_r types $1_cdrecord_t;
+
+uses_shlib($1_cdrecord_t)
+read_locale($1_cdrecord_t)
+
+# allow ps to show cdrecord and allow the user to kill it=20
+can_ps($1_t, $1_cdrecord_t)
+allow $1_t $1_cdrecord_t:process signal;
+
+# write to the user domain tty.
+allow $1_cdrecord_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+allow $1_cdrecord_t privfd:fd use;
+
+allow $1_cdrecord_t $1_t:unix_stream_socket { getattr read write };
+
+allow $1_cdrecord_t self:unix_dgram_socket create_socket_perms;
+allow $1_cdrecord_t self:unix_stream_socket create_stream_socket_perms;
+
+can_resmgrd_connect($1_cdrecord_t)
+
+allow $1_cdrecord_t home_root_t:dir { search };
+
+# allow cdrecord to read user files
+r_dir_file($1_cdrecord_t, { $1_home_t $1_tmp_t })
+ifdef(`nfs_home_dirs', `
+r_dir_file($1_cdrecord_t, nfs_t)
+')dnl end if nfs_home_dirs
+
+# allow searching for cdrom-drive
+allow $1_cdrecord_t device_t:dir { getattr search };
+allow $1_cdrecord_t device_t:lnk_file { getattr read };
+
+# allow cdrecord to write the CD
+allow $1_cdrecord_t removable_device_t:blk_file { getattr read write ioctl=
 };
+allow $1_cdrecord_t scsi_generic_device_t:chr_file { getattr read write io=
ctl };
+
+allow $1_cdrecord_t self:capability { ipc_lock sys_nice setuid };
+allow $1_cdrecord_t self:process { getsched setsched fork };
+
+')
+

--oj4kGyHlBMXGt3Le--

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdDxqxWIrrrL0q+cRAlt1AKCtH9UOC07kEsQTxzGjYBSr7dgKewCeNgbZ
U2anz3YWIpGZ+ElIXmEVRmU=
=b8zd
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
