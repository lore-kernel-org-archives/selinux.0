Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9I3jIi014469
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:03:45 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9I3lEj002798
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:03:48 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 19:03:42 +0100
Date: Thu, 9 Dec 2004 19:03:42 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: various stuff
Message-Id: <20041209180342.GB8179@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--P+33d92oIH25kiaB
Content-Type: multipart/mixed; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some stuff that got forgotten from my previous patches. A few comments:

* hostname.te: sysadm_t should run hostname directly, it has the
  necessary privs and makes many things easier (eg redirections in
  scripts). The can_resolve() was necessary because (at least on SuSE)
  hostname does some dns-lookups. If noone else sees this it could be
  put inside an ifdef(`distro_suse',).

* checkpolicy.fc: These labels are unnecessary and just cause
  unnecessary relabels.

* user_macros.te: This may need some discussion. netstat needs to access
  /proc/net in order to work. Not sure if we want to allow this. Maybe a
  boolean?

Thomas
 =20
--
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="various.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/fsadm.te mod/domains/program/fsadm.te
--- orig/domains/program/fsadm.te	2004-12-09 17:05:14.000000000 +0100
+++ mod/domains/program/fsadm.te	2004-12-09 19:00:11.000000000 +0100
@@ -22,8 +22,7 @@
 allow fsadm_t sysfs_t:dir { search getattr };
=20
 # Read system information files in /proc.
-allow fsadm_t proc_t:dir r_dir_perms;
-allow fsadm_t proc_t:notdevfile_class_set r_file_perms;
+r_dir_file(fsadm_t, proc_t)
=20
 # Read system variables in /proc/sys
 allow fsadm_t sysctl_kernel_t:file r_file_perms;
diff -urN orig/domains/program/hostname.te mod/domains/program/hostname.te
--- orig/domains/program/hostname.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/hostname.te	2004-12-09 19:00:11.000000000 +0100
@@ -5,7 +5,6 @@
=20
 # for setting the hostname
 daemon_base_domain(hostname, , nosysadm)
-domain_auto_trans(sysadm_t, hostname_exec_t, hostname_t)
 role sysadm_r types hostname_t;
=20
 allow hostname_t self:capability sys_admin;
@@ -13,6 +12,7 @@
=20
 allow hostname_t { user_tty_type admin_tty_type }:chr_file { getattr read =
write };
 read_locale(hostname_t)
+can_resolve(hostname_t)
 allow hostname_t userdomain:fd use;
 dontaudit hostname_t kernel_t:fd use;
 allow hostname_t net_conf_t:file { getattr read };
diff -urN orig/domains/program/setfiles.te mod/domains/program/setfiles.te
--- orig/domains/program/setfiles.te	2004-11-09 08:45:50.000000000 +0100
+++ mod/domains/program/setfiles.te	2004-12-09 19:00:11.000000000 +0100
@@ -44,6 +44,8 @@
 allow setfiles_t unlabeled_t:dir read;
 allow setfiles_t { device_type device_t }:{ chr_file blk_file } { getattr =
relabelfrom relabelto };
 allow setfiles_t { ttyfile ptyfile }:chr_file getattr;
+# dontaudit access to ttyfile - we do not want setfiles to relabel our ter=
minal
+dontaudit setfiles_t ttyfile:chr_file relabelfrom;
=20
 allow setfiles_t fs_t:filesystem getattr;
 allow setfiles_t fs_type:dir r_dir_perms;
diff -urN orig/file_contexts/program/checkpolicy.fc mod/file_contexts/progr=
am/checkpolicy.fc
--- orig/file_contexts/program/checkpolicy.fc	2004-09-11 14:31:47.000000000=
 +0200
+++ mod/file_contexts/program/checkpolicy.fc	2004-12-09 19:00:10.000000000 =
+0100
@@ -1,4 +1,2 @@
 # checkpolicy
 /usr/bin/checkpolicy		--	system_u:object_r:checkpolicy_exec_t
-/etc/selinux/policy/policy.* -- system_u:object_r:policy_config_t
-/etc/selinux/.*/src/policy/policy.* -- system_u:object_r:policy_config_t=
=09
diff -urN orig/macros/program/cdrecord_macros.te mod/macros/program/cdrecor=
d_macros.te
--- orig/macros/program/cdrecord_macros.te	2004-11-20 10:04:13.000000000 +0=
100
+++ mod/macros/program/cdrecord_macros.te	2004-12-09 19:00:10.000000000 +01=
00
@@ -21,7 +21,7 @@
 allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
 allow $1_cdrecord_t privfd:fd use;
=20
-allow $1_cdrecord_t $1_t:unix_stream_socket { getattr read write };
+allow $1_cdrecord_t $1_t:unix_stream_socket { getattr read write ioctl };
=20
 allow $1_cdrecord_t self:unix_dgram_socket create_socket_perms;
 allow $1_cdrecord_t self:unix_stream_socket create_stream_socket_perms;
diff -urN orig/macros/program/chkpwd_macros.te mod/macros/program/chkpwd_ma=
cros.te
--- orig/macros/program/chkpwd_macros.te	2004-11-25 10:25:09.000000000 +0100
+++ mod/macros/program/chkpwd_macros.te	2004-12-09 19:00:56.000000000 +0100
@@ -66,7 +66,9 @@
 r_dir_file($1_chkpwd_t, selinux_config_t)
=20
 # for nscd
+ifdef(`nscd.te', `', `
 dontaudit $1_chkpwd_t var_t:dir search;
+')
=20
 dontaudit $1_chkpwd_t fs_t:filesystem getattr;
 ')
diff -urN orig/macros/program/irc_macros.te mod/macros/program/irc_macros.te
--- orig/macros/program/irc_macros.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/macros/program/irc_macros.te	2004-12-09 19:00:11.000000000 +0100
@@ -21,12 +21,7 @@
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
 type $1_home_irc_t, file_type, $1_file_type, sysadmfile;
-type $1_irc_exec_t, file_type, sysadmfile;
-
-ifdef(`slocate.te', `
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:dir { getattr search };
-allow $1_locate_t { $1_home_irc_t $1_irc_exec_t }:file { getattr read };
-')
+type $1_irc_exec_t, file_type, sysadmfile, $1_file_type;
=20
 allow $1_t { $1_home_irc_t $1_irc_exec_t }:file { relabelfrom relabelto cr=
eate_file_perms };
=20
diff -urN orig/macros/program/mta_macros.te mod/macros/program/mta_macros.te
--- orig/macros/program/mta_macros.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/macros/program/mta_macros.te	2004-12-09 19:00:11.000000000 +0100
@@ -34,6 +34,7 @@
=20
 uses_shlib($1_mail_t)
 can_network_client_tcp($1_mail_t)
+can_resolve($1_mail_t)
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
diff -urN orig/macros/program/resmgrd_macros.te mod/macros/program/resmgrd_=
macros.te
--- orig/macros/program/resmgrd_macros.te	2004-10-29 20:33:17.000000000 +02=
00
+++ mod/macros/program/resmgrd_macros.te	2004-12-09 19:00:11.000000000 +0100
@@ -3,6 +3,7 @@
 define(`can_resmgrd_connect', `
 ifdef(`resmgrd.te', `=20
 allow $1 resmgrd_t:unix_stream_socket connectto;
+allow $1 { var_t var_run_t }:dir search;
 allow $1 resmgrd_var_run_t:sock_file write;
 allow $1 resmgrd_t:fd use;
 ')
diff -urN orig/macros/program/ssh_macros.te mod/macros/program/ssh_macros.te
--- orig/macros/program/ssh_macros.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/macros/program/ssh_macros.te	2004-12-09 19:01:28.000000000 +0100
@@ -85,6 +85,12 @@
 can_network_client_tcp($1_ssh_t)
 can_resolve($1_ssh_t)
 can_ypbind($1_ssh_t)
+can_kerberos($1_ssh_t)
+
+# for port forwarding
+if (user_tcp_server) {
+allow $1_ssh_t port_t:tcp_socket name_bind;
+}
=20
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_searc=
h };
@@ -152,7 +158,7 @@
 allow $1_ssh_t xdm_xserver_t:shm r_shm_perms;
 allow $1_ssh_t xdm_xserver_t:fd use;
 allow $1_ssh_t xdm_xserver_tmpfs_t:file read;
-can_kerberos($1_ssh_t)
+allow $1_ssh_t xdm_t:fd use;
 ')dnl end if xdm.te
 ')dnl end macro definition
=20
diff -urN orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2004-12-09 17:05:15.000000000 +0100
+++ mod/macros/user_macros.te	2004-12-09 19:00:11.000000000 +0100
@@ -75,6 +75,8 @@
 if (user_tcp_server) {
 allow $1_t port_t:tcp_socket name_bind;
 }
+# port access is audited even if dac would not have allowed it, so dontaud=
it it here
+dontaudit $1_t reserved_port_type:tcp_socket name_bind;
=20
 # Allow system log read
 if (user_dmesg) {
@@ -134,6 +136,8 @@
 attribute $1_file_type;
 # Grant read/search permissions to some of /proc.
 r_dir_file($1_t, proc_t)
+# netstat needs to access proc_net_t; if you want to hide this info use do=
ntaudit here instead
+r_dir_file($1_t, proc_net_t)
=20
 base_file_read_access($1_t)
=20

--Qbvjkv9qwOGw/5Fx--

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuJN+xWIrrrL0q+cRAvE5AKCwEhY05l5NxB6hc5ZYheXQW0tYdwCgvhmj
NiYvlT9vi7yBBrYgUJHBdTs=
=0Zzm
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
