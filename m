Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UGKjDo015957
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 11:20:45 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UGGtph022770
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:16:56 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 30 Mar 2005 18:19:34 +0200
Date: Wed, 30 Mar 2005 18:19:34 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: change var_lib_DOMAIN_t to DOMAIN_var_lib_t
Message-Id: <20050330161911.GB5791@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--9dgjiU4MmWPVapMU
Content-Type: multipart/mixed; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch changes var_lib_DOMAIN_t to DOMAIN_var_lib_t. It adds
appropriate typealiases, so should be safe. It also adds a few comments
to macros/global_macros.te and removes user_application_domain() since
noone is using it.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup_var_lib.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/unused/dictd.te mod/domains/program/unused/di=
ctd.te
--- orig/domains/program/unused/dictd.te	2004-12-04 00:46:49.000000000 +0100
+++ mod/domains/program/unused/dictd.te	2005-03-30 18:10:19.343147376 +0200
@@ -12,9 +12,9 @@
 #
 type dict_port_t, port_type;
 daemon_base_domain(dictd)
-type var_lib_dictd_t, file_type, sysadmfile;
+type dictd_var_lib_t, file_type, sysadmfile;
+typealias dictd_var_lib_t alias var_lib_dictd_t;
 etc_domain(dictd)
-typealias dictd_etc_t alias etc_dictd_t;
=20
 # for checking for nscd
 dontaudit dictd_t var_run_t:dir search;
@@ -25,8 +25,8 @@
 read_locale(dictd_t)
=20
 allow dictd_t { var_t var_lib_t }:dir search;
-allow dictd_t var_lib_dictd_t:dir r_dir_perms;
-allow dictd_t var_lib_dictd_t:file r_file_perms;
+allow dictd_t dictd_var_lib_t:dir r_dir_perms;
+allow dictd_t dictd_var_lib_t:file r_file_perms;
=20
 allow dictd_t self:capability { setuid setgid };
=20
diff -ur orig/domains/program/unused/mrtg.te mod/domains/program/unused/mrt=
g.te
--- orig/domains/program/unused/mrtg.te	2005-03-24 22:51:48.000000000 +0100
+++ mod/domains/program/unused/mrtg.te	2005-03-30 18:10:19.346146920 +0200
@@ -26,7 +26,8 @@
 logdir_domain(mrtg)
 etcdir_domain(mrtg)
 typealias mrtg_etc_t alias etc_mrtg_t;
-type var_lib_mrtg_t, file_type, sysadmfile;
+type mrtg_var_lib_t, file_type, sysadmfile;
+typealias mrtg_var_lib_t alias var_lib_mrtg_t;
 type mrtg_lock_t, file_type, sysadmfile, lockfile;
 r_dir_file(mrtg_t, lib_t)
=20
@@ -59,7 +60,7 @@
 dontaudit mrtg_t proc_t:file ioctl;
=20
 allow mrtg_t { var_lock_t var_lib_t }:dir search;
-rw_dir_create_file(mrtg_t, var_lib_mrtg_t)
+rw_dir_create_file(mrtg_t, mrtg_var_lib_t)
 rw_dir_create_file(mrtg_t, mrtg_lock_t)
 ifdef(`distro_redhat', `
 file_type_auto_trans(mrtg_t, mrtg_etc_t, mrtg_lock_t, file)
diff -ur orig/domains/program/unused/prelink.te mod/domains/program/unused/=
prelink.te
--- orig/domains/program/unused/prelink.te	2005-02-04 00:18:17.000000000 +0=
100
+++ mod/domains/program/unused/prelink.te	2005-03-30 18:10:19.347146768 +02=
00
@@ -36,7 +36,7 @@
 allow prelink_t file_type:dir rw_dir_perms;
 allow prelink_t file_type:lnk_file r_file_perms;
 allow prelink_t file_type:file getattr;
-allow prelink_t { ifdef(`amanda.te', `amanda_usr_lib_t') admin_passwd_exec=
_t ifdef(`apache.te', `httpd_modules_t') ifdef(`xserver.te', `var_lib_xkb_t=
') ld_so_t su_exec_t texrel_shlib_t shlib_t sbin_t bin_t lib_t exec_type }:=
file { create_file_perms execute relabelto relabelfrom };
+allow prelink_t { ifdef(`amanda.te', `amanda_usr_lib_t') admin_passwd_exec=
_t ifdef(`apache.te', `httpd_modules_t') ifdef(`xserver.te', `xkb_var_lib_t=
') ld_so_t su_exec_t texrel_shlib_t shlib_t sbin_t bin_t lib_t exec_type }:=
file { create_file_perms execute relabelto relabelfrom };
 allow prelink_t ld_so_t:file execute_no_trans;
=20
 allow prelink_t self:capability { chown dac_override fowner fsetid };
diff -ur orig/domains/program/unused/rhgb.te mod/domains/program/unused/rhg=
b.te
--- orig/domains/program/unused/rhgb.te	2005-03-24 22:51:49.000000000 +0100
+++ mod/domains/program/unused/rhgb.te	2005-03-30 18:10:19.349146464 +0200
@@ -47,7 +47,7 @@
 allow rhgb_t usr_t:{ file lnk_file } { getattr read };
=20
 # for running setxkbmap
-r_dir_file(rhgb_t, var_lib_xkb_t)
+r_dir_file(rhgb_t, xkb_var_lib_t)
=20
 # for localization
 allow rhgb_t lib_t:file { getattr read };
diff -ur orig/domains/program/unused/rpm.te mod/domains/program/unused/rpm.=
te
--- orig/domains/program/unused/rpm.te	2005-03-24 22:51:49.000000000 +0100
+++ mod/domains/program/unused/rpm.te	2005-03-30 18:10:19.351146160 +0200
@@ -7,8 +7,8 @@
 #
 # rpm_t is the domain for rpm and related utilities in /usr/lib/rpm
 # rpm_exec_t is the type of the rpm executables.
-# var_log_rpm_t is the type for rpm log files (/var/log/rpmpkgs*)
-# var_lib_rpm_t is the type for rpm files in /var/lib
+# rpm_log_t is the type for rpm log files (/var/log/rpmpkgs*)
+# rpm_var_lib_t is the type for rpm files in /var/lib
 #
 type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_s=
ystem_role, fs_domain, privfd;
 role system_r types rpm_t;
diff -ur orig/domains/program/unused/slocate.te mod/domains/program/unused/=
slocate.te
--- orig/domains/program/unused/slocate.te	2004-12-04 00:46:50.000000000 +0=
100
+++ mod/domains/program/unused/slocate.te	2005-03-30 18:10:19.353145856 +02=
00
@@ -2,7 +2,6 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
-# Depends: inetd.te
=20
 #################################
 #
@@ -36,11 +35,11 @@
=20
 logdir_domain(locate)
 etcdir_domain(locate)
-typealias locate_etc_t alias etc_locate_t;
=20
-type var_lib_locate_t, file_type, sysadmfile;
+type locate_var_lib_t, file_type, sysadmfile;
+typealias locate_var_lib_t alias var_lib_locate_t;
=20
-create_dir_file(locate_t, var_lib_locate_t)
+create_dir_file(locate_t, locate_var_lib_t)
 dontaudit locate_t sysadmfile:file getattr;
=20
 allow locate_t proc_t:file { getattr read };
diff -ur orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm.=
te
--- orig/domains/program/unused/xdm.te	2005-03-24 22:51:50.000000000 +0100
+++ mod/domains/program/unused/xdm.te	2005-03-30 18:10:19.355145552 +0200
@@ -260,8 +260,8 @@
=20
 # Run xkbcomp.
 allow xdm_xserver_t var_lib_t:dir search;
-allow xdm_xserver_t var_lib_xkb_t:lnk_file read;
-can_exec(xdm_xserver_t, var_lib_xkb_t)
+allow xdm_xserver_t xkb_var_lib_t:lnk_file read;
+can_exec(xdm_xserver_t, xkb_var_lib_t)
=20
 # Insert video drivers. =20
 allow xdm_xserver_t self:capability mknod;
diff -ur orig/domains/program/unused/xserver.te mod/domains/program/unused/=
xserver.te
--- orig/domains/program/unused/xserver.te	2004-09-11 14:31:47.000000000 +0=
200
+++ mod/domains/program/unused/xserver.te	2005-03-30 18:10:19.356145400 +02=
00
@@ -11,7 +11,8 @@
 type xserver_log_t, file_type, sysadmfile, logfile;
=20
 # type for /var/lib/xkb
-type var_lib_xkb_t, file_type, sysadmfile, usercanread;
+type xkb_var_lib_t, file_type, sysadmfile, usercanread;
+typealias xkb_var_lib_t alias var_lib_xkb_t;
=20
 # Allow the xserver to check for fonts in ~/.gnome or ~/.kde
 bool allow_xserver_home_fonts false;
diff -ur orig/file_contexts/program/ddclient.fc mod/file_contexts/program/d=
dclient.fc
--- orig/file_contexts/program/ddclient.fc	2005-01-28 10:17:33.000000000 +0=
100
+++ mod/file_contexts/program/ddclient.fc	2005-03-30 18:10:19.358145096 +02=
00
@@ -7,5 +7,5 @@
 /usr/sbin/ddtcd		--	system_u:object_r:ddclient_exec_t
 /var/run/ddtcd\.pid	--	system_u:object_r:ddclient_var_run_t
 /etc/ddtcd\.conf	--	system_u:object_r:ddclient_etc_t
-/var/lib/ddt-client(/.*)?	system_u:object_r:var_lib_ddclient_t
+/var/lib/ddt-client(/.*)?	system_u:object_r:ddclient_var_lib_t
 /var/log/ddtcd\.log.*	--	system_u:object_r:ddclient_log_t
diff -ur orig/file_contexts/program/dictd.fc mod/file_contexts/program/dict=
d.fc
--- orig/file_contexts/program/dictd.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/dictd.fc	2005-03-30 18:10:19.359144944 +0200
@@ -1,4 +1,4 @@
 # dictd
 /etc/dictd\.conf		--	system_u:object_r:dictd_etc_t
 /usr/sbin/dictd		--	system_u:object_r:dictd_exec_t
-/var/lib/dictd(/.*)?		system_u:object_r:var_lib_dictd_t
+/var/lib/dictd(/.*)?		system_u:object_r:dictd_var_lib_t
diff -ur orig/file_contexts/program/mrtg.fc mod/file_contexts/program/mrtg.=
fc
--- orig/file_contexts/program/mrtg.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/mrtg.fc	2005-03-30 18:10:19.360144792 +0200
@@ -1,6 +1,6 @@
 # mrtg - traffic grapher
 /usr/bin/mrtg		--	system_u:object_r:mrtg_exec_t
-/var/lib/mrtg(/.*)?		system_u:object_r:var_lib_mrtg_t
+/var/lib/mrtg(/.*)?		system_u:object_r:mrtg_var_lib_t
 /var/lock/mrtg(/.*)?		system_u:object_r:mrtg_lock_t
 /etc/mrtg.*			system_u:object_r:mrtg_etc_t
 /etc/mrtg/mrtg\.ok	--	system_u:object_r:mrtg_lock_t
diff -ur orig/file_contexts/program/slocate.fc mod/file_contexts/program/sl=
ocate.fc
--- orig/file_contexts/program/slocate.fc	2004-11-19 09:23:18.000000000 +01=
00
+++ mod/file_contexts/program/slocate.fc	2005-03-30 18:10:19.362144488 +0200
@@ -1,4 +1,4 @@
 # locate - file locater
 /usr/bin/slocate		--	system_u:object_r:locate_exec_t
-/var/lib/slocate(/.*)?			system_u:object_r:var_lib_locate_t
+/var/lib/slocate(/.*)?			system_u:object_r:locate_var_lib_t
 /etc/updatedb\.conf		--	system_u:object_r:locate_etc_t
diff -ur orig/file_contexts/program/xserver.fc mod/file_contexts/program/xs=
erver.fc
--- orig/file_contexts/program/xserver.fc	2004-09-15 19:01:07.000000000 +02=
00
+++ mod/file_contexts/program/xserver.fc	2005-03-30 18:10:19.363144336 +0200
@@ -4,9 +4,9 @@
 /usr/X11R6/bin/XFree86	--	system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/Xorg	--	system_u:object_r:xserver_exec_t
 /usr/X11R6/bin/Xipaq	--	system_u:object_r:xserver_exec_t
-/var/lib/xkb(/.*)?		system_u:object_r:var_lib_xkb_t
-/usr/X11R6/lib/X11/xkb	-d	system_u:object_r:var_lib_xkb_t
-/usr/X11R6/lib/X11/xkb/.* --	system_u:object_r:var_lib_xkb_t
+/var/lib/xkb(/.*)?		system_u:object_r:xkb_var_lib_t
+/usr/X11R6/lib/X11/xkb	-d	system_u:object_r:xkb_var_lib_t
+/usr/X11R6/lib/X11/xkb/.* --	system_u:object_r:xkb_var_lib_t
 /usr/X11R6/lib(64)?/X11/xkb/xkbcomp -- system_u:object_r:bin_t
 /var/log/XFree86.*	--	system_u:object_r:xserver_log_t
 /var/log/Xorg.*		--	system_u:object_r:xserver_log_t
diff -ur orig/macros/global_macros.te mod/macros/global_macros.te
--- orig/macros/global_macros.te	2005-03-24 22:51:51.000000000 +0100
+++ mod/macros/global_macros.te	2005-03-30 18:10:19.366143880 +0200
@@ -293,6 +293,8 @@
 # Define a daemon domain with a base set of type declarations
 # and permissions that are common to most daemons.
 # attribs is the list of attributes which must start with "," if it is not=
 empty
+# `nosysadm' may be given as an optional third parameter, to specify that =
the
+# sysadmin should not transition to the domain when directly calling the e=
xecutable
 #
 # Author:  Russell Coker <russell@coker.com.au>
 #
@@ -353,6 +355,14 @@
 allow $1_t var_t:dir search;
 allow $1_t $1_var_run_t:dir rw_dir_perms;
 ')
+
+#######################
+# daemon_domain(domain_prefix, attribs)
+#
+# see daemon_base_domain for calling details
+# daemon_domain defines some additional privileges needed by many domains,
+# like pid files and locale support
+
 define(`daemon_domain', `
 ifdef(`targeted_policy', `
 daemon_base_domain($1, `$2, transitionbool', $3)
@@ -589,12 +599,6 @@
 uses_shlib($1_t)
 ')
=20
-define(`user_application_domain', `
-application_domain($1, `$2')
-in_user_role($1_t)
-domain_auto_trans(userdomain, $1_exec_t, $1_t)
-')
-
 define(`system_domain', `
 type $1_t, domain, privlog $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
diff -ur orig/macros/program/slocate_macros.te mod/macros/program/slocate_m=
acros.te
--- orig/macros/program/slocate_macros.te	2005-03-24 22:51:51.000000000 +01=
00
+++ mod/macros/program/slocate_macros.te	2005-03-30 18:10:19.368143576 +0200
@@ -25,7 +25,7 @@
=20
 allow $1_locate_t etc_t:file { getattr read };
 allow $1_locate_t self:unix_stream_socket create_socket_perms;
-r_dir_file($1_locate_t,var_lib_locate_t)
+r_dir_file($1_locate_t,locate_var_lib_t)
 allow $1_locate_t var_lib_t:dir search;
=20
 # Transition from the user domain to this domain.
diff -ur orig/macros/program/xserver_macros.te mod/macros/program/xserver_m=
acros.te
--- orig/macros/program/xserver_macros.te	2005-03-24 22:51:51.000000000 +01=
00
+++ mod/macros/program/xserver_macros.te	2005-03-30 18:10:19.371143120 +0200
@@ -259,7 +259,7 @@
 dontaudit $1_xserver_t selinux_config_t:dir search;
=20
 allow $1_xserver_t var_lib_t:dir search;
-rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
+rw_dir_create_file($1_xserver_t, xkb_var_lib_t)
=20
 # for fonts
 r_dir_file($1_xserver_t, fonts_t)

--da4uJneut+ArUgXk--

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCStF/D9qpeVMU938RAghIAKCjyWpEX+qQlgzZ4BTh/ME6mfzMZgCgksoE
+0e14SsCAum1mZ5DJygMQUs=
=aj2y
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
