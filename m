Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UG0hDo015674
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 11:00:43 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UFxWo4002634
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 15:59:33 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 30 Mar 2005 17:59:26 +0200
Date: Wed, 30 Mar 2005 17:59:27 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: Cleanup policy for /var/lock
Message-Id: <20050330155926.GA5791@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--l76fUT7nc3MelDdI
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch replaces direct write access to /var/lock with calls to
lock_domain(). There is a potential for breakage here: if there are any
locks shared between two domains it will break. However, I have tested
this patch on two systems, no problem so far.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup_lock_domain.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/getty.te mod/domains/program/getty.te
--- orig/domains/program/getty.te	2005-02-11 12:48:57.000000000 +0100
+++ mod/domains/program/getty.te	2005-03-18 00:24:53.097959832 +0100
@@ -56,5 +56,5 @@
 # for error condition handling
 allow getty_t fs_t:filesystem getattr;
=20
-rw_dir_create_file(getty_t, var_lock_t)
+lock_domain(getty)
 r_dir_file(getty_t, sysfs_t)
diff -ur orig/domains/program/login.te mod/domains/program/login.te
--- orig/domains/program/login.te	2005-02-11 12:48:57.000000000 +0100
+++ mod/domains/program/login.te	2005-03-18 00:23:09.783665992 +0100
@@ -167,9 +167,7 @@
=20
=20
 # Create lock file.
-allow local_login_t var_lock_t:dir rw_dir_perms;
-allow local_login_t var_lock_t:file create_file_perms;
-
+lock_domain(local_login)
=20
 # Read and write ttys.
 allow local_login_t tty_device_t:chr_file { setattr rw_file_perms };
diff -ur orig/domains/program/logrotate.te mod/domains/program/logrotate.te
--- orig/domains/program/logrotate.te	2005-02-11 12:48:57.000000000 +0100
+++ mod/domains/program/logrotate.te	2005-03-18 00:18:53.608610520 +0100
@@ -46,7 +46,7 @@
 allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr read =
search };
=20
 # create lock files
-rw_dir_create_file(logrotate_t, var_lock_t)
+lock_domain(logrotate)
=20
 # Create temporary files.
 tmp_domain(logrotate)
diff -ur orig/domains/program/unused/apmd.te mod/domains/program/unused/apm=
d.te
--- orig/domains/program/unused/apmd.te	2005-01-13 20:57:00.000000000 +0100
+++ mod/domains/program/unused/apmd.te	2005-03-18 00:25:34.060732544 +0100
@@ -85,7 +85,7 @@
 ifdef(`distro_redhat', `
 can_exec(apmd_t, apmd_var_run_t)
 # for /var/lock/subsys/network
-rw_dir_create_file(apmd_t, var_lock_t)
+lock_domain(apmd)
=20
 # ifconfig_exec_t needs to be run in its own domain for Red Hat
 ifdef(`ifconfig.te', `domain_auto_trans(apmd_t, ifconfig_exec_t, ifconfig_=
t)')
diff -ur orig/domains/program/unused/bluetooth.te mod/domains/program/unuse=
d/bluetooth.te
--- orig/domains/program/unused/bluetooth.te	2004-12-04 00:46:49.000000000 =
+0100
+++ mod/domains/program/unused/bluetooth.te	2005-03-18 00:24:12.248169944 +=
0100
@@ -17,7 +17,7 @@
 # Use capabilities.
 allow bluetooth_t self:capability { net_admin net_raw sys_tty_config };
=20
-rw_dir_create_file(bluetooth_t, var_lock_t)
+lock_domain(bluetooth)
=20
 # Use the network.
 can_network_server(bluetooth_t)
diff -ur orig/domains/program/unused/ftpd.te mod/domains/program/unused/ftp=
d.te
--- orig/domains/program/unused/ftpd.te	2005-03-01 11:56:39.000000000 +0100
+++ mod/domains/program/unused/ftpd.te	2005-03-18 00:31:31.446401664 +0100
@@ -42,10 +42,13 @@
 allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
 allow ftpd_t port_t:tcp_socket name_bind;
=20
+# ftpd_lock_t is only needed when ftpd_is_daemon is true, but we cannot de=
fine types conditionally
+type ftpd_lock_t, file_type, sysadmfile, lockfile;
+
 # Allow ftpd to run directly without inetd.
 bool ftpd_is_daemon false;
 if (ftpd_is_daemon) {
-rw_dir_create_file(ftpd_t, var_lock_t)
+file_type_auto_trans(ftpd_t, var_lock_t, ftpd_lock_t, file)
 allow ftpd_t ftp_port_t:tcp_socket name_bind;
 can_tcp_connect(userdomain, ftpd_t)
 # Allows it to check exec privs on daemon
diff -ur orig/domains/program/unused/ipsec.te mod/domains/program/unused/ip=
sec.te
--- orig/domains/program/unused/ipsec.te	2004-12-12 17:00:02.000000000 +0100
+++ mod/domains/program/unused/ipsec.te	2005-03-18 00:20:48.737108328 +0100
@@ -185,9 +185,8 @@
 allow ipsec_mgmt_t null_device_t:chr_file rw_file_perms;
 allow ipsec_t null_device_t:chr_file rw_file_perms;
=20
-# Allow scripts to use /var/locl/subsys/ipsec
-allow ipsec_mgmt_t var_lock_t:dir rw_dir_perms;
-allow ipsec_mgmt_t var_lock_t:file create_file_perms;
+# Allow scripts to use /var/lock/subsys/ipsec
+lock_domain(ipsec_mgmt)
=20
 # allow tncfg to create sockets
 allow ipsec_mgmt_t self:udp_socket { create ioctl };
diff -ur orig/domains/program/unused/portslave.te mod/domains/program/unuse=
d/portslave.te
--- orig/domains/program/unused/portslave.te	2004-12-04 00:46:50.000000000 =
+0100
+++ mod/domains/program/unused/portslave.te	2005-03-18 00:21:24.287703816 +=
0100
@@ -79,7 +79,7 @@
 allow portslave_t ttyfile:chr_file rw_file_perms;
=20
=20
-rw_dir_create_file(portslave_t, var_lock_t)
+lock_domain(portslave)
 can_exec(portslave_t, pppd_exec_t)
 allow portslave_t { bin_t sbin_t }:dir search;
 allow portslave_t bin_t:lnk_file read;
diff -ur orig/domains/program/unused/postgresql.te mod/domains/program/unus=
ed/postgresql.te
--- orig/domains/program/unused/postgresql.te	2005-01-28 10:17:33.000000000=
 +0100
+++ mod/domains/program/unused/postgresql.te	2005-03-18 00:22:10.619660288 =
+0100
@@ -113,7 +113,7 @@
 allow postgresql_t initrc_var_run_t:file { getattr read lock };
 dontaudit postgresql_t selinux_config_t:dir { search };
 allow postgresql_t mail_spool_t:dir { search };
-rw_dir_create_file(postgresql_t, var_lock_t)
+lock_domain(postgresql)
 can_exec(postgresql_t, { shell_exec_t bin_t postgresql_exec_t ls_exec_t } )
 ifdef(`apache.te', `
 #=20
diff -ur orig/domains/program/unused/pppd.te mod/domains/program/unused/ppp=
d.te
--- orig/domains/program/unused/pppd.te	2004-12-12 17:00:02.000000000 +0100
+++ mod/domains/program/unused/pppd.te	2005-03-18 00:18:18.903886440 +0100
@@ -38,8 +38,7 @@
 # Use capabilities.
 allow pppd_t self:capability { net_admin setuid setgid fsetid };
=20
-allow pppd_t var_lock_t:dir rw_dir_perms;
-allow pppd_t var_lock_t:file create_file_perms;
+lock_domain(pppd)
=20
 # Access secret files
 allow pppd_t pppd_secret_t:file r_file_perms;
diff -ur orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm.=
te
--- orig/domains/program/unused/xdm.te	2005-02-04 00:18:17.000000000 +0100
+++ mod/domains/program/unused/xdm.te	2005-03-18 00:19:55.464207040 +0100
@@ -176,8 +176,8 @@
 # perhaps define derived types.
 allow xdm_t var_lib_t:dir { write search add_name remove_name  create unli=
nk };
 allow xdm_t var_lib_t:file { create write unlink };
-allow xdm_t var_lock_t:dir { write search add_name remove_name };
-allow xdm_t var_lock_t:file { create write unlink };
+
+lock_domain(xdm)
=20
 # Connect to xfs.
 ifdef(`xfs.te', `

--Q68bSM7Ycu6FN28Q--

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCSszeD9qpeVMU938RAk7+AKCo3ehXKbIRpE5z9xqADl0ryFzVXACeKV5d
dg3jUT5cINaYRrl6tlq3JPU=
=JswH
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
