Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QKk9rT028586
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 16:46:09 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QKk8hU011054
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 20:46:09 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 22:46:08 +0200
Date: Sun, 26 Sep 2004 22:46:42 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: policy for resmgrd
Message-Id: <20040926204642.GC2529@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--L1c6L/cjZjI9d0Eq
Content-Type: multipart/mixed; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resmgrd is a daemon which is used on SuSE Linux to mediate access to
devices. Clients can ask resmgrd to open a specific device, resmgrd
checks if the app has appropriate permission and opens the device on
behalf of the client. Resmgrd should probably be a userspace SELinux
enforcer, but for now the attached policy allows it to work on a SELinux
system.

Thomas
--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="resmgrd.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/unused/resmgrd.te mod/domains/program/unused=
/resmgrd.te
--- orig/domains/program/unused/resmgrd.te	1970-01-01 01:00:00.000000000 +0=
100
+++ mod/domains/program/unused/resmgrd.te	2004-09-26 22:30:47.000000000 +02=
00
@@ -0,0 +1,25 @@
+# DESC resmgrd - resource manager daemon
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+=20
+daemon_base_domain(resmgrd)
+var_run_domain(resmgrd, { file sock_file })
+etc_domain(resmgrd)
+read_locale(resmgrd_t)
+allow resmgrd_t self:capability { dac_override dac_read_search sys_admin s=
ys_rawio };
+
+allow resmgrd_t etc_t:file { getattr read };
+allow resmgrd_t self:unix_stream_socket create_stream_socket_perms;=20
+allow resmgrd_t self:unix_dgram_socket { connect create write };
+
+# hardware access
+allow resmgrd_t device_t:lnk_file { getattr read };
+# not sure if it needs write access, needs to be investigated further...
+allow resmgrd_t removable_device_t:blk_file { getattr ioctl read write };
+allow resmgrd_t scsi_generic_device_t:chr_file { getattr ioctl read };
+allow resmgrd_t scanner_device_t:chr_file { getattr };
+# I think a dontaudit should be enough there
+dontaudit resmgrd_t fixed_disk_device_t:blk_file { getattr ioctl read };
+
+# there is a macro can_resmgrd_connect() in macros/program/resmgrd_macros.=
te
+
diff -urN orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm=
=2Ete
--- orig/domains/program/unused/xdm.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/xdm.te	2004-09-26 22:30:06.000000000 +0200
@@ -130,6 +130,7 @@
 allow xdm_t v4l_device_t:chr_file { setattr getattr };
 allow xdm_t scanner_device_t:chr_file { setattr getattr };
 allow xdm_t tty_device_t:chr_file { ioctl read write setattr getattr };
+can_resmgrd_connect(xdm_t)
=20
 # Access xdm log files.
 file_type_auto_trans(xdm_t, var_log_t, xserver_log_t, file)
diff -urN orig/file_contexts/program/resmgrd.fc mod/file_contexts/program/r=
esmgrd.fc
--- orig/file_contexts/program/resmgrd.fc	1970-01-01 01:00:00.000000000 +01=
00
+++ mod/file_contexts/program/resmgrd.fc	2004-09-26 22:30:38.000000000 +0200
@@ -0,0 +1,6 @@
+# resmgrd
+/sbin/resmgrd		--	system_u:object_r:resmgrd_exec_t
+/etc/resmgr\.conf	--	system_u:object_r:resmgrd_etc_t
+/var/run/resmgr\.pid	--	system_u:object_r:resmgrd_var_run_t
+/var/run/\.resmgr_socket	system_u:object_r:resmgrd_var_run_t
+
diff -urN orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2004-09-25 19:52:50.000000000 +0200
+++ mod/macros/base_user_macros.te	2004-09-26 22:30:22.000000000 +0200
@@ -177,6 +177,8 @@
 allow $1_t misc_device_t:{ chr_file blk_file } rw_file_perms;
 allow $1_t device_t:lnk_file { getattr read };
=20
+can_resmgrd_connect($1_t)
+
 #
 # evolution and gnome-session try to create a netlink socket
 #
diff -urN orig/macros/program/resmgrd_macros.te mod/macros/program/resmgrd_=
macros.te
--- orig/macros/program/resmgrd_macros.te	1970-01-01 01:00:00.000000000 +01=
00
+++ mod/macros/program/resmgrd_macros.te	2004-09-26 22:33:31.000000000 +0200
@@ -0,0 +1,10 @@
+# Macro for resmgrd
+
+define(`can_resmgrd_connect', `
+ifdef(`resmgrd.te', `=20
+allow $1 resmgrd_t:unix_stream_socket connectto;
+allow $1 resmgrd_var_run_t:sock_file write;
+allow $1 resmgrd_t:fd use;
+')
+')
+

--Ls2Gy6y7jbHLe9Od--

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVyqyxWIrrrL0q+cRAvdgAJ4iZqkJXl5Eg5WqiFPSEDXx2TfCbwCfcJln
ey9wBCBtUj6t8CwQ5bGMM+o=
=/eSp
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
