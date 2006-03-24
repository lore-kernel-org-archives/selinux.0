Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2OCPvOT012545
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 07:25:57 -0500
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2OCPtah017617
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 12:25:56 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 24 Mar 2006 13:25:55 +0100
Date: Fri, 24 Mar 2006 13:25:54 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Misc policy fixes
Message-Id: <20060324122554.GB7306@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--SO98HVl1bnMOfKZd
Content-Type: multipart/mixed; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Some fixes for policy:
* CUPS doesn't need inetd to function.
* There are still systems without udev out there.
* Remove .SECONDARY because it causes build failures with current CVS
  make (I already sent a mail about this; I think this is a bug in make,
  but removing this line makes it work and doesn't cause negative side
  effects AFAIK).
* Some Debian/Ubuntu specific paths.

Please apply.

Thomas


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="policy.diff"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D policy/modules/services/xserver.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/services/xserver.fc	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/services/xserver.fc	(/refpolicy/cip)	(revision 7)
@@ -55,6 +55,9 @@
 /usr/bin/Xair		--	gen_context(system_u:object_r:xserver_exec_t,s0)
 /usr/bin/xauth    	--      gen_context(system_u:object_r:xauth_exec_t,s0)
 /usr/bin/Xorg		--	gen_context(system_u:object_r:xserver_exec_t,s0)
+ifdef(`distro_debian', `
+/usr/sbin/gdm		--	gen_context(system_u:object_r:xdm_exec_t,s0)
+')
=20
 /usr/lib(64)?/qt-.*/etc/settings(/.*)?	gen_context(system_u:object_r:xdm_v=
ar_run_t,s0)
=20
=3D=3D=3D policy/modules/services/cups.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/services/cups.te	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/services/cups.te	(/refpolicy/cip)	(revision 7)
@@ -32,7 +32,9 @@
=20
 type cupsd_lpd_t;
 type cupsd_lpd_exec_t;
-inetd_service_domain(cupsd_lpd_t,cupsd_lpd_exec_t)
+optional_policy(`inetd', `
+	inetd_service_domain(cupsd_lpd_t,cupsd_lpd_exec_t)
+')
 role system_r types cupsd_lpd_t;
=20
 type cupsd_lpd_tmp_t;
=3D=3D=3D policy/modules/services/xfs.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/services/xfs.fc	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/services/xfs.fc	(/refpolicy/cip)	(revision 7)
@@ -5,3 +5,4 @@
=20
 /usr/X11R6/bin/xfs	--	gen_context(system_u:object_r:xfs_exec_t,s0)
 /usr/X11R6/bin/xfs-xtt	--	gen_context(system_u:object_r:xfs_exec_t,s0)
+/usr/bin/xfs		--	gen_context(system_u:object_r:xfs_exec_t,s0)
=3D=3D=3D policy/modules/services/postgresql.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/services/postgresql.fc	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/services/postgresql.fc	(/refpolicy/cip)	(revision 7)
@@ -14,6 +14,10 @@
=20
 /usr/lib(64)?/postgresql/bin/.* --	gen_context(system_u:object_r:postgresq=
l_exec_t,s0)
=20
+ifdef(`distro_debian', `
+/usr/lib/postgresql/.*/bin/.*	--	gen_context(system_u:object_r:postgresql_=
exec_t,s0)
+')
+
 ifdef(`distro_redhat', `
 /usr/share/jonas/pgsql(/.*)?		gen_context(system_u:object_r:postgresql_db_=
t,s0)
 ')
=3D=3D=3D policy/modules/system/init.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/system/init.te	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/system/init.te	(/refpolicy/cip)	(revision 7)
@@ -380,7 +380,9 @@
=20
 sysnet_read_config(initrc_t)
=20
-udev_rw_db(initrc_t)
+optional_policy(`udev', `
+	udev_rw_db(initrc_t)
+')
=20
 userdom_read_all_users_home_content_files(initrc_t)
 # Allow access to the sysadm TTYs. Note that this will give access to the=
=20
=3D=3D=3D policy/modules/system/selinuxutil.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/system/selinuxutil.te	(/refpolicy/upstream)	(revision 7)
+++ policy/modules/system/selinuxutil.te	(/refpolicy/cip)	(revision 7)
@@ -395,7 +395,9 @@
 ')
=20
 ifdef(`hide_broken_symptoms',`
-	udev_dontaudit_rw_dgram_sockets(restorecon_t)
+	optional_policy(`udev', `
+		udev_dontaudit_rw_dgram_sockets(restorecon_t)
+	')
 ')
=20
 optional_policy(`hotplug',`
=3D=3D=3D Rules.modular
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- Rules.modular	(/refpolicy/upstream)	(revision 7)
+++ Rules.modular	(/refpolicy/cip)	(revision 7)
@@ -31,8 +31,6 @@
 vpath %.if $(ALL_LAYERS)
 vpath %.fc $(ALL_LAYERS)
=20
-.SECONDARY:
-
 ########################################
 #
 # default action: create all module packages

--yLVHuoLXiP9kZBkt--

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEI+VRD9qpeVMU938RAse+AJ48+devPirZRtmhlffJm1oLr3mFlgCeKY/3
YmBRiH4waMauZ8pnV2ldPDY=
=FOcF
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
