Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9I0HeNs004934
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 20:17:40 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9I0F9up024880
	for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2005 00:15:10 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 18 Oct 2005 02:15:09 +0200
Date: Tue, 18 Oct 2005 02:15:06 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Small policy cleanups
Message-Id: <20051018001506.GD10592@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uZ3hkaAS1mZxFaxD
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some cleanups:
* Use 'self' in a few places where it was missing
* Remove kerberos_master_port_t as it is not used anywhere
* Assign attribute proc_fs to type mtrr_device_t as it is used both for
  /dev/cpu/mtrr and /proc/mtrr
* add reserved_port_t to dontaudit for userdomain name_bind, as it is
  not part of reserved_port_type
* check for xdm.te inside can_pipe_xdm() and remove redundant checks
* Fix a bug in user_macros.te

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="cleanup.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/macros/program/bonobo_macros.te mod/macros/program/bonobo_mac=
ros.te
--- orig/macros/program/bonobo_macros.te	2005-07-05 21:25:49.000000000 +0200
+++ mod/macros/program/bonobo_macros.te	2005-10-18 02:06:03.000000000 +0200
@@ -72,9 +72,7 @@
 # here temporarily, since bonobo runs as ROLE_t by default anyway
 domain_auto_trans($1_bonobo_t, bin_t, $1_t)=20
=20
-ifdef(`xdm.te', `
 can_pipe_xdm($1_bonobo_t)
-')
  =20
 ') dnl ifdef bonobo_domain_args
 ') dnl bonobo_domain
diff -ur orig/macros/program/crontab_macros.te mod/macros/program/crontab_m=
acros.te
--- orig/macros/program/crontab_macros.te	2005-07-06 20:53:56.000000000 +02=
00
+++ mod/macros/program/crontab_macros.te	2005-10-18 02:05:56.000000000 +0200
@@ -40,7 +40,7 @@
=20
 # Use capabilities dac_override is to create the file in the directory
 # under /tmp
-allow $1_crontab_t $1_crontab_t:capability { setuid setgid chown dac_overr=
ide };
+allow $1_crontab_t self:capability { setuid setgid chown dac_override };
=20
 # Type for temporary files.
 file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, { dir file })
diff -ur orig/macros/program/dbusd_macros.te mod/macros/program/dbusd_macro=
s.te
--- orig/macros/program/dbusd_macros.te	2005-07-14 22:16:20.000000000 +0200
+++ mod/macros/program/dbusd_macros.te	2005-10-18 02:06:03.000000000 +0200
@@ -29,9 +29,7 @@
 r_dir_file($1_dbusd_t, etc_dbusd_t)
 tmp_domain($1_dbusd)=20
 allow $1_dbusd_t self:process fork;
-ifdef(`xdm.te', `
 can_pipe_xdm($1_dbusd_t)
-')
=20
 allow $1_dbusd_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_dbusd_t self:unix_dgram_socket create_socket_perms;
@@ -71,11 +69,11 @@
 # For connecting to the bus
 allow $2_t $1_dbusd_t:unix_stream_socket connectto;
=20
-') dnl endif dbusd.te
 ifelse(`system', `$1', `
 allow { $2_t } { var_run_t system_dbusd_var_run_t }:dir search;
 allow { $2_t } system_dbusd_var_run_t:sock_file write;
 ',`') dnl endif system
+') dnl endif dbusd.te
 ')
=20
 # can_dbusd_converse(dbus_type, domain_prefix_a, domain_prefix_b)
diff -ur orig/macros/program/gconf_macros.te mod/macros/program/gconf_macro=
s.te
--- orig/macros/program/gconf_macros.te	2005-08-19 23:23:51.000000000 +0200
+++ mod/macros/program/gconf_macros.te	2005-10-18 02:06:03.000000000 +0200
@@ -31,8 +31,8 @@
 # /tmp/gconfd-USER
 tmp_domain($1_gconfd)
=20
-ifdef(`xdm.te', `
 can_pipe_xdm($1_gconfd_t)
+ifdef(`xdm.te', `
 allow xdm_t $1_gconfd_t:process signal;
 ')
=20
diff -ur orig/macros/program/gift_macros.te mod/macros/program/gift_macros.=
te
--- orig/macros/program/gift_macros.te	2005-07-06 20:53:56.000000000 +0200
+++ mod/macros/program/gift_macros.te	2005-10-18 02:06:03.000000000 +0200
@@ -90,9 +90,7 @@
 r_dir_file($1_giftd_t, usr_t)
=20
 # Connect to xdm
-ifdef(`xdm.te', `
 can_pipe_xdm($1_giftd_t)
-')=20
=20
 ') dnl giftd_domain
=20
diff -ur orig/macros/program/gpg_macros.te mod/macros/program/gpg_macros.te
--- orig/macros/program/gpg_macros.te	2005-10-10 13:24:55.000000000 +0200
+++ mod/macros/program/gpg_macros.te	2005-10-18 02:06:21.000000000 +0200
@@ -108,8 +108,6 @@
 # for nscd
 dontaudit $1_gpg_helper_t var_t:dir search;
=20
-ifdef(`xdm.te', `
 can_pipe_xdm($1_gpg_t)
-')
=20
 ')dnl end gpg_domain definition
diff -ur orig/macros/program/lpr_macros.te mod/macros/program/lpr_macros.te
--- orig/macros/program/lpr_macros.te	2005-07-06 20:53:56.000000000 +0200
+++ mod/macros/program/lpr_macros.te	2005-10-18 02:05:56.000000000 +0200
@@ -39,7 +39,7 @@
 can_ypbind($1_lpr_t)
=20
 # Use capabilities.
-allow $1_lpr_t $1_lpr_t:capability { setuid dac_override net_bind_service =
chown };
+allow $1_lpr_t self:capability { setuid dac_override net_bind_service chow=
n };
=20
 allow $1_lpr_t self:unix_stream_socket create_stream_socket_perms;
=20
diff -ur orig/macros/program/xdm_macros.te mod/macros/program/xdm_macros.te
--- orig/macros/program/xdm_macros.te	2005-07-05 21:25:49.000000000 +0200
+++ mod/macros/program/xdm_macros.te	2005-10-18 02:06:21.000000000 +0200
@@ -6,6 +6,8 @@
 #
=20
 define(`can_pipe_xdm', `
+ifdef(`xdm.te', `
 allow $1 xdm_t:fd use;
 allow $1 xdm_t:fifo_file { getattr read write ioctl };
+')
 ') dnl can_pipe_xdm
diff -ur orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2005-08-19 23:23:51.000000000 +0200
+++ mod/macros/user_macros.te	2005-10-18 02:05:57.000000000 +0200
@@ -143,7 +143,7 @@
 allow $1_t port_t:tcp_socket name_bind;
 }
 # port access is audited even if dac would not have allowed it, so dontaud=
it it here
-dontaudit $1_t reserved_port_type:tcp_socket name_bind;
+dontaudit $1_t { reserved_port_type reserved_port_t }:tcp_socket name_bind;
=20
 # Allow system log read
 if (user_dmesg) {
@@ -203,6 +203,7 @@
=20
 # Grant read/search permissions to some of /proc.
 r_dir_file($1_t, proc_t)
+# netstat needs to access proc_net_t; if you want to hide this info use do=
ntaudit here instead
 r_dir_file($1_t, proc_net_t)
=20
 base_file_read_access($1_t)
@@ -225,7 +226,7 @@
=20
 allow $1_t self:dir search;
 allow $1_t self:file { getattr read };
-allow secadm_t self:fifo_file rw_file_perms;
+allow $1_t self:fifo_file rw_file_perms;
=20
 allow $1_t self:lnk_file read;
 allow $1_t self:unix_stream_socket create_socket_perms;
Nur in mod/macros: user_macros.te.orig.
diff -ur orig/net_contexts mod/net_contexts
--- orig/net_contexts	2005-10-10 13:24:50.000000000 +0200
+++ mod/net_contexts	2005-10-18 02:05:56.000000000 +0200
@@ -111,8 +111,6 @@
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
 portcon tcp 750 system_u:object_r:kerberos_port_t
 portcon udp 750 system_u:object_r:kerberos_port_t
-portcon tcp 4444 system_u:object_r:kerberos_master_port_t
-portcon udp 4444 system_u:object_r:kerberos_master_port_t
 portcon tcp 783 system_u:object_r:spamd_port_t
 portcon tcp 540 system_u:object_r:uucpd_port_t
 portcon tcp 2401 system_u:object_r:cvs_port_t
diff -ur orig/types/device.te mod/types/device.te
--- orig/types/device.te	2005-07-06 20:53:56.000000000 +0200
+++ mod/types/device.te	2005-10-18 02:05:56.000000000 +0200
@@ -131,8 +131,8 @@
 # Type for /dev/.devfsd
 type devfs_control_t, device_type, dev_fs;
=20
-# Type for /dev/cpu/mtrr
-type mtrr_device_t, device_type, dev_fs;
+# Type for /dev/cpu/mtrr and /proc/mtrr
+type mtrr_device_t, device_type, dev_fs, proc_fs;
=20
 # Type for /dev/pmu=20
 type power_device_t, device_type, dev_fs;
diff -ur orig/types/network.te mod/types/network.te
--- orig/types/network.te	2005-10-10 13:24:56.000000000 +0200
+++ mod/types/network.te	2005-10-18 02:05:56.000000000 +0200
@@ -45,7 +45,6 @@
 #
 type kerberos_port_t, port_type, reserved_port_type;
 type kerberos_admin_port_t, port_type, reserved_port_type;
-type kerberos_master_port_t, port_type;
=20
 #
 # Ports used to communicate with portmap server

--45Z9DzgjV8m4Oswq--

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVD6KD9qpeVMU938RAi6MAKCqC51yFORSB1scpBWhTZRht3IZDACgml/4
v+zKxXekzb4BVpQJkwMrPiQ=
=1CEO
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
