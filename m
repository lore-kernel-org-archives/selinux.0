Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UGrQDo016278
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 11:53:26 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UGqFo4007218
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:52:15 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 30 Mar 2005 18:52:15 +0200
Date: Wed, 30 Mar 2005 18:52:15 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: cleanup uses of notdevfile_class_set
Message-Id: <20050330165215.GD5791@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xHbokkKX1kTiQeDC
Content-Type: multipart/mixed; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch replaces uses of allow ...:notdevfile_class_set r_file_perms;
with r_dir_file(). This should be no problem normally; user_t used to
have access to sock_file and fifo_file under /var and /var/spool - I
have removed this access, if there are any files where access is really
needed they should probably get extra types.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup_notdevfile.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/fsadm.te mod/domains/program/fsadm.te
--- orig/domains/program/fsadm.te	2004-12-12 17:00:01.000000000 +0100
+++ mod/domains/program/fsadm.te	2005-03-18 02:04:53.914697024 +0100
@@ -34,8 +34,7 @@
 base_file_read_access(fsadm_t)
=20
 # Read /etc.
-allow fsadm_t etc_t:dir r_dir_perms;
-allow fsadm_t etc_t:notdevfile_class_set r_file_perms;
+r_dir_file(fsadm_t, etc_t)
=20
 # Read module-related files.
 allow fsadm_t modules_conf_t:{ file lnk_file } r_file_perms;
diff -ur orig/domains/program/load_policy.te mod/domains/program/load_polic=
y.te
--- orig/domains/program/load_policy.te	2004-10-14 13:09:52.000000000 +0200
+++ mod/domains/program/load_policy.te	2005-03-18 02:06:39.169695832 +0100
@@ -37,8 +37,7 @@
=20
 # only allow read of policy config files
 allow load_policy_t policy_src_t:dir search;
-allow load_policy_t policy_config_t:dir r_dir_perms;
-allow load_policy_t policy_config_t:notdevfile_class_set r_file_perms;
+r_dir_file(load_policy_t, policy_config_t)
=20
 # directory search permissions for path to binary policy files
 allow load_policy_t root_t:dir search;
diff -ur orig/domains/program/login.te mod/domains/program/login.te
--- orig/domains/program/login.te	2005-02-11 12:48:57.000000000 +0100
+++ mod/domains/program/login.te	2005-03-18 02:04:13.546833872 +0100
@@ -37,8 +37,7 @@
 allow $1_login_t var_t:lnk_file read;
=20
 # Read /etc.
-allow $1_login_t etc_t:dir r_dir_perms;
-allow $1_login_t etc_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_login_t, etc_t)
 allow $1_login_t etc_runtime_t:{ file lnk_file } r_file_perms;
=20
 read_locale($1_login_t)
diff -ur orig/macros/base_user_macros.te mod/macros/base_user_macros.te
--- orig/macros/base_user_macros.te	2005-03-01 11:56:39.000000000 +0100
+++ mod/macros/base_user_macros.te	2005-03-18 02:00:48.971933984 +0100
@@ -349,8 +349,7 @@
 # Read the devpts root directory.
 allow $1_t devpts_t:dir r_dir_perms;
=20
-allow $1_t src_t:dir r_dir_perms;
-allow $1_t src_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_t, src_t)
=20
 if (read_default_t) {
 allow $1_t default_t:dir r_dir_perms;
diff -ur orig/macros/program/newrole_macros.te mod/macros/program/newrole_m=
acros.te
--- orig/macros/program/newrole_macros.te	2005-02-04 00:18:21.000000000 +01=
00
+++ mod/macros/program/newrole_macros.te	2005-03-18 02:03:18.029273824 +0100
@@ -60,8 +60,7 @@
 allow $1_t etc_t:file r_file_perms;
=20
 # Read /var.
-allow $1_t var_t:dir r_dir_perms;
-allow $1_t var_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_t, var_t)
=20
 # Read /dev directories and any symbolic links.
 allow $1_t device_t:dir r_dir_perms;
diff -ur orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2005-03-01 11:56:40.000000000 +0100
+++ mod/macros/program/ssh_macros.te	2005-03-18 02:02:23.940496568 +0100
@@ -53,8 +53,7 @@
 base_file_read_access($1_ssh_t)
=20
 # Read /var.
-allow $1_ssh_t var_t:dir r_dir_perms;
-allow $1_ssh_t var_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_ssh_t, var_t)
=20
 # Read /var/run, /var/log.
 allow $1_ssh_t var_run_t:dir r_dir_perms;
@@ -63,8 +62,7 @@
 allow $1_ssh_t var_log_t:{ file lnk_file } r_file_perms;
=20
 # Read /etc.
-allow $1_ssh_t etc_t:dir r_dir_perms;
-allow $1_ssh_t etc_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_ssh_t, etc_t)
 allow $1_ssh_t etc_runtime_t:{ file lnk_file } r_file_perms;
=20
 # Read /dev directories and any symbolic links.
diff -ur orig/macros/program/userhelper_macros.te mod/macros/program/userhe=
lper_macros.te
--- orig/macros/program/userhelper_macros.te	2005-02-04 00:18:22.000000000 =
+0100
+++ mod/macros/program/userhelper_macros.te	2005-03-18 02:07:21.585247688 +=
0100
@@ -76,8 +76,7 @@
 allow $1_userhelper_t etc_t:file r_file_perms;
=20
 # Read /var.
-allow $1_userhelper_t var_t:dir r_dir_perms;
-allow $1_userhelper_t var_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_userhelper_t, var_t)
=20
 # Read /dev directories and any symbolic links.
 allow $1_userhelper_t device_t:dir r_dir_perms;
diff -ur orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2005-03-01 11:56:39.000000000 +0100
+++ mod/macros/user_macros.te	2005-03-18 01:54:57.971294192 +0100
@@ -134,12 +134,10 @@
 allow $1_t lost_found_t:dir getattr;
=20
 # Read /var, /var/spool, /var/run.
-allow $1_t var_t:dir r_dir_perms;
-allow $1_t var_t:notdevfile_class_set r_file_perms;
-allow $1_t var_spool_t:dir r_dir_perms;
-allow $1_t var_spool_t:notdevfile_class_set r_file_perms;
-allow $1_t var_run_t:dir r_dir_perms;
-allow $1_t var_run_t:{ file lnk_file } r_file_perms;
+r_dir_file($1_t, var_t)
+# what about pipes and sockets under /var/spool?
+r_dir_file($1_t, var_spool_t)
+r_dir_file($1_t, var_run_t)
 allow $1_t var_lib_t:dir r_dir_perms;
 allow $1_t var_lib_t:file { getattr read };
=20
@@ -147,16 +145,15 @@
 allow $1_t sysctl_kernel_t:file { getattr read };
=20
 # Read /etc.
-allow $1_t etc_t:dir r_dir_perms;
-allow $1_t etc_t:notdevfile_class_set r_file_perms;
-allow $1_t etc_runtime_t:{ file lnk_file } r_file_perms;
+r_dir_file($1_t, etc_t)
+allow $1_t etc_runtime_t:file r_file_perms;
+allow $1_t etc_runtime_t:lnk_file { getattr read };
=20
 # for running depmod as part of the kernel packaging process
 allow $1_t modules_conf_t:file { getattr read };
=20
 # Read man directories and files.
-allow $1_t man_t:dir r_dir_perms;
-allow $1_t man_t:notdevfile_class_set r_file_perms;
+r_dir_file($1_t, man_t)
=20
 # Allow users to rw usb devices
 if (user_rw_usb) {
@@ -169,13 +166,13 @@
=20
 # Read /dev directories and any symbolic links.
 allow $1_t device_t:dir r_dir_perms;
-allow $1_t device_t:lnk_file r_file_perms;
+allow $1_t device_t:lnk_file { getattr read };
=20
 # Do not audit write denials to /etc/ld.so.cache.
 dontaudit $1_t ld_so_cache_t:file write;
=20
 # Execute from the system shared libraries.
-uses_shlib($1_t);
+uses_shlib($1_t)
=20
 # $1_t is also granted permissions specific to user domains.
 user_domain($1)

--vJguvTgX93MxBIIe--

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCStk/D9qpeVMU938RAmUhAJ9Pekw1DDS5sXFd9aMwULdRPbSKPgCeLkys
1iJngJi97Yu+Ch7MYO72XsU=
=3RcZ
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
