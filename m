Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j390ektA009725
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 20:40:46 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j390bvUH015623
	for <selinux@tycho.nsa.gov>; Sat, 9 Apr 2005 00:37:57 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 9 Apr 2005 02:34:49 +0200
Date: Sat, 9 Apr 2005 02:34:47 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: cleanup old typealiases
Message-Id: <20050409003446.GB7830@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--c3bfwLpm8qysLVxt
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patches cleans up a lot of old typealiases which are no longer used.
Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup_alias.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/getty.te mod/domains/program/getty.te
--- orig/domains/program/getty.te	2005-04-02 23:33:42.000000000 +0200
+++ mod/domains/program/getty.te	2005-04-09 02:30:20.977638616 +0200
@@ -11,7 +11,6 @@
 init_service_domain(getty, `, privfd')
=20
 etcdir_domain(getty)
-typealias getty_etc_t alias etc_getty_t;
=20
 allow getty_t console_device_t:chr_file setattr;
=20
diff -ur orig/domains/program/unused/authbind.te mod/domains/program/unused=
/authbind.te
--- orig/domains/program/unused/authbind.te	2004-03-03 21:53:51.000000000 +=
0100
+++ mod/domains/program/unused/authbind.te	2005-04-09 02:30:20.980638160 +0=
200
@@ -16,7 +16,6 @@
 role system_r types authbind_t;
=20
 etcdir_domain(authbind)
-typealias authbind_etc_t alias etc_authbind_t;
=20
 can_exec(authbind_t, authbind_etc_t)
 allow authbind_t etc_t:dir r_dir_perms;
diff -ur orig/domains/program/unused/bootloader.te mod/domains/program/unus=
ed/bootloader.te
--- orig/domains/program/unused/bootloader.te	2005-03-24 22:51:46.000000000=
 +0100
+++ mod/domains/program/unused/bootloader.te	2005-04-09 02:30:20.972639376 =
+0200
@@ -13,7 +13,6 @@
 type bootloader_t, domain, privlog, privmem, fs_domain, nscd_client_domain=
 ifdef(`direct_sysadm_daemon', `, priv_system_role') ifdef(`distro_debian',=
 `, privowner, admin');
 type bootloader_exec_t, file_type, sysadmfile, exec_type;
 etc_domain(bootloader)
-typealias bootloader_etc_t alias etc_bootloader_t;
=20
 role sysadm_r types bootloader_t;
 role system_r types bootloader_t;
diff -ur orig/domains/program/unused/courier.te mod/domains/program/unused/=
courier.te
--- orig/domains/program/unused/courier.te	2005-03-24 22:51:47.000000000 +0=
100
+++ mod/domains/program/unused/courier.te	2005-04-09 02:30:20.982637856 +02=
00
@@ -9,7 +9,6 @@
 type courier_var_lib_t, file_type, sysadmfile;
=20
 type courier_etc_t, file_type, sysadmfile;
-typealias courier_etc_t alias etc_courier_t;
=20
 # allow start scripts to read the config
 allow initrc_t courier_etc_t:file r_file_perms;
diff -ur orig/domains/program/unused/cups.te mod/domains/program/unused/cup=
s.te
--- orig/domains/program/unused/cups.te	2005-04-02 23:33:43.000000000 +0200
+++ mod/domains/program/unused/cups.te	2005-04-09 02:30:20.974639072 +0200
@@ -14,9 +14,7 @@
 type ipp_port_t, port_type, reserved_port_type;
 daemon_domain(cupsd, `, auth_chkpwd, nscd_client_domain')
 etcdir_domain(cupsd)
-typealias cupsd_etc_t alias etc_cupsd_t;
 type cupsd_rw_etc_t, file_type, sysadmfile, usercanread;
-typealias cupsd_rw_etc_t alias etc_cupsd_rw_t;
=20
 can_network(cupsd_t)
 allow cupsd_t port_type:tcp_socket name_connect;
diff -ur orig/domains/program/unused/devfsd.te mod/domains/program/unused/d=
evfsd.te
--- orig/domains/program/unused/devfsd.te	2005-03-24 22:51:47.000000000 +01=
00
+++ mod/domains/program/unused/devfsd.te	2005-04-09 02:30:20.983637704 +0200
@@ -9,7 +9,6 @@
 # Rules for the devfsd_t domain.
 #
 etcdir_domain(devfsd)
-typealias devfsd_etc_t alias etc_devfsd_t;
=20
 allow kernel_t { device_t root_t }:dir mounton;
=20
diff -ur orig/domains/program/unused/dhcpc.te mod/domains/program/unused/dh=
cpc.te
--- orig/domains/program/unused/dhcpc.te	2005-04-09 02:26:19.708317128 +0200
+++ mod/domains/program/unused/dhcpc.te	2005-04-09 02:30:20.976638768 +0200
@@ -72,7 +72,6 @@
 ifdef(`dhcpd.te', `', `
 type dhcp_state_t, file_type, sysadmfile;
 type dhcp_etc_t, file_type, sysadmfile, usercanread;=20
-typealias dhcp_etc_t alias { etc_dhcp_t etc_dhcpc_t etc_dhcpd_t };
 ')
 type dhcpc_state_t, file_type, sysadmfile;
=20
Nur in mod/domains/program/unused: dhcpc.te.orig.
diff -ur orig/domains/program/unused/dhcpd.te mod/domains/program/unused/dh=
cpd.te
--- orig/domains/program/unused/dhcpd.te	2005-03-24 22:51:47.000000000 +0100
+++ mod/domains/program/unused/dhcpd.te	2005-04-09 02:30:20.985637400 +0200
@@ -26,7 +26,6 @@
 allow dhcpd_t pxe_port_t:udp_socket name_bind;
=20
 type dhcp_etc_t, file_type, sysadmfile, usercanread;
-typealias dhcp_etc_t alias { etc_dhcp_t etc_dhcpc_t etc_dhcpd_t };
=20
 # Use the network.
 can_network(dhcpd_t)
diff -ur orig/domains/program/unused/dpkg.te mod/domains/program/unused/dpk=
g.te
--- orig/domains/program/unused/dpkg.te	2005-03-24 22:51:47.000000000 +0100
+++ mod/domains/program/unused/dpkg.te	2005-04-09 02:30:20.987637096 +0200
@@ -12,7 +12,6 @@
 type dpkg_exec_t, file_type, sysadmfile, exec_type;
 type dpkg_var_lib_t, file_type, sysadmfile;
 type dpkg_etc_t, file_type, sysadmfile, usercanread;
-typealias dpkg_etc_t alias etc_dpkg_t;
 type dpkg_lock_t, file_type, sysadmfile;
 type debconf_cache_t, file_type, sysadmfile;
=20
@@ -176,9 +175,7 @@
 type apt_var_lib_t, file_type, sysadmfile;
 type var_cache_apt_t, file_type, sysadmfile;
 etcdir_domain(apt)
-typealias apt_etc_t alias etc_apt_t;
 type apt_rw_etc_t, file_type, sysadmfile;
-typealias apt_rw_etc_t alias etc_apt_rw_t;
 tmp_domain(apt, `', `{ dir file lnk_file }')
 can_exec(apt_t, apt_tmp_t)
=20
diff -ur orig/domains/program/unused/fingerd.te mod/domains/program/unused/=
fingerd.te
--- orig/domains/program/unused/fingerd.te	2005-03-24 22:51:47.000000000 +0=
100
+++ mod/domains/program/unused/fingerd.te	2005-04-09 02:30:20.988636944 +02=
00
@@ -14,7 +14,6 @@
=20
 type fingerd_port_t, port_type, reserved_port_type;
 etcdir_domain(fingerd)
-typealias fingerd_etc_t alias etc_fingerd_t;
=20
 allow fingerd_t etc_t:lnk_file read;
 allow fingerd_t { etc_t etc_runtime_t }:file { read getattr };
diff -ur orig/domains/program/unused/ftpd.te mod/domains/program/unused/ftp=
d.te
--- orig/domains/program/unused/ftpd.te	2005-04-02 23:33:43.000000000 +0200
+++ mod/domains/program/unused/ftpd.te	2005-04-09 02:30:20.990636640 +0200
@@ -13,7 +13,6 @@
 type ftp_data_port_t, port_type, reserved_port_type;
 daemon_domain(ftpd, `, auth_chkpwd')
 etc_domain(ftpd)
-typealias ftpd_etc_t alias etc_ftpd_t;
=20
 can_network(ftpd_t)
 allow ftpd_t port_type:tcp_socket name_connect;
diff -ur orig/domains/program/unused/gatekeeper.te mod/domains/program/unus=
ed/gatekeeper.te
--- orig/domains/program/unused/gatekeeper.te	2005-03-24 22:51:48.000000000=
 +0100
+++ mod/domains/program/unused/gatekeeper.te	2005-04-09 02:30:20.991636488 =
+0200
@@ -17,7 +17,6 @@
=20
 type gatekeeper_port_t, port_type;
 etc_domain(gatekeeper)
-typealias gatekeeper_etc_t alias etc_gatekeeper_t;
 allow gatekeeper_t gatekeeper_etc_t:lnk_file { getattr read };
 logdir_domain(gatekeeper)
=20
diff -ur orig/domains/program/unused/ircd.te mod/domains/program/unused/irc=
d.te
--- orig/domains/program/unused/ircd.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/domains/program/unused/ircd.te	2005-04-09 02:30:20.993636184 +0200
@@ -16,7 +16,6 @@
 allow ircd_t ircd_port_t:tcp_socket name_bind;
=20
 etcdir_domain(ircd)
-typealias ircd_etc_t alias etc_ircd_t;
=20
 logdir_domain(ircd)
=20
diff -ur orig/domains/program/unused/lrrd.te mod/domains/program/unused/lrr=
d.te
--- orig/domains/program/unused/lrrd.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/domains/program/unused/lrrd.te	2005-04-09 02:30:20.994636032 +0200
@@ -15,7 +15,6 @@
 allow lrrd_t lrrd_var_run_t:sock_file create_file_perms;
=20
 etcdir_domain(lrrd)
-typealias lrrd_etc_t alias etc_lrrd_t;
 type lrrd_var_lib_t, file_type, sysadmfile;
 type lrrd_port_t, port_type;
=20
diff -ur orig/domains/program/unused/mysqld.te mod/domains/program/unused/m=
ysqld.te
--- orig/domains/program/unused/mysqld.te	2005-03-24 22:51:48.000000000 +01=
00
+++ mod/domains/program/unused/mysqld.te	2005-04-09 02:30:20.995635880 +0200
@@ -18,7 +18,6 @@
 allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;
=20
 etcdir_domain(mysqld)
-typealias mysqld_etc_t alias etc_mysqld_t;
 type mysqld_db_t, file_type, sysadmfile;
=20
 log_domain(mysqld)
diff -ur orig/domains/program/unused/nagios.te mod/domains/program/unused/n=
agios.te
--- orig/domains/program/unused/nagios.te	2004-12-04 00:46:50.000000000 +01=
00
+++ mod/domains/program/unused/nagios.te	2005-04-09 02:30:20.997635576 +0200
@@ -14,7 +14,6 @@
 daemon_domain(nagios, `, privmail')
=20
 etcdir_domain(nagios)
-typealias nagios_etc_t alias etc_nagios_t;
=20
 logdir_domain(nagios)
 allow nagios_t nagios_log_t:fifo_file create_file_perms;
diff -ur orig/domains/program/unused/nessusd.te mod/domains/program/unused/=
nessusd.te
--- orig/domains/program/unused/nessusd.te	2005-03-24 22:51:48.000000000 +0=
100
+++ mod/domains/program/unused/nessusd.te	2005-04-09 02:30:20.998635424 +02=
00
@@ -13,7 +13,6 @@
 daemon_domain(nessusd)
=20
 etc_domain(nessusd)
-typealias nessusd_etc_t alias etc_nessusd_t;
 type nessusd_db_t, file_type, sysadmfile;
=20
 type nessus_port_t, port_type;
diff -ur orig/domains/program/unused/perdition.te mod/domains/program/unuse=
d/perdition.te
--- orig/domains/program/unused/perdition.te	2004-12-04 00:46:50.000000000 =
+0100
+++ mod/domains/program/unused/perdition.te	2005-04-09 02:30:20.999635272 +=
0200
@@ -13,7 +13,6 @@
 allow perdition_t pop_port_t:tcp_socket name_bind;
=20
 etc_domain(perdition)
-typealias perdition_etc_t alias etc_perdition_t;
=20
 # Use the network.
 can_network_server(perdition_t)
diff -ur orig/domains/program/unused/postfix.te mod/domains/program/unused/=
postfix.te
--- orig/domains/program/unused/postfix.te	2005-03-24 22:51:48.000000000 +0=
100
+++ mod/domains/program/unused/postfix.te	2005-04-09 02:30:20.979638312 +02=
00
@@ -9,7 +9,6 @@
 type postfix_var_run_t, file_type, sysadmfile, pidfile;
=20
 type postfix_etc_t, file_type, sysadmfile;
-typealias postfix_etc_t alias etc_postfix_t;
 type postfix_exec_t, file_type, sysadmfile, exec_type;
 type postfix_public_t, file_type, sysadmfile;
 type postfix_private_t, file_type, sysadmfile;
diff -ur orig/domains/program/unused/postgresql.te mod/domains/program/unus=
ed/postgresql.te
--- orig/domains/program/unused/postgresql.te	2005-04-09 02:26:19.805302384=
 +0200
+++ mod/domains/program/unused/postgresql.te	2005-04-09 02:30:21.001634968 =
+0200
@@ -37,7 +37,6 @@
 dontaudit postgresql_t self:capability sys_admin;
=20
 etcdir_domain(postgresql)
-typealias postgresql_etc_t alias etc_postgresql_t;
 type postgresql_db_t, file_type, sysadmfile;
=20
 logdir_domain(postgresql)
diff -ur orig/domains/program/unused/qmail.te mod/domains/program/unused/qm=
ail.te
--- orig/domains/program/unused/qmail.te	2005-01-13 20:57:01.000000000 +0100
+++ mod/domains/program/unused/qmail.te	2005-04-09 02:30:21.002634816 +0200
@@ -10,7 +10,6 @@
 type qmail_var_run_t, file_type, sysadmfile, pidfile;
=20
 type qmail_etc_t, file_type, sysadmfile;
-typealias qmail_etc_t alias etc_qmail_t;
=20
 allow inetd_t smtp_port_t:tcp_socket name_bind;
=20
diff -ur orig/domains/program/unused/radius.te mod/domains/program/unused/r=
adius.te
--- orig/domains/program/unused/radius.te	2005-03-24 22:51:49.000000000 +01=
00
+++ mod/domains/program/unused/radius.te	2005-04-09 02:30:21.004634512 +0200
@@ -15,7 +15,6 @@
 daemon_domain(radiusd, `, auth')
=20
 etcdir_domain(radiusd)
-typealias radiusd_etc_t alias etc_radiusd_t;
=20
 system_crond_entry(radiusd_exec_t, radiusd_t)
=20
diff -ur orig/domains/program/unused/samba.te mod/domains/program/unused/sa=
mba.te
--- orig/domains/program/unused/samba.te	2005-04-02 23:33:43.000000000 +0200
+++ mod/domains/program/unused/samba.te	2005-04-09 02:30:21.005634360 +0200
@@ -16,7 +16,6 @@
 type samba_var_t, file_type, sysadmfile;
 type samba_share_t, file_type, sysadmfile, customizable;
 type samba_secrets_t, file_type, sysadmfile;
-typealias samba_var_t alias samba_spool_t;
=20
 # for /var/run/samba/messages.tdb
 allow smbd_t nmbd_var_run_t:file rw_file_perms;
diff -ur orig/domains/program/unused/slapd.te mod/domains/program/unused/sl=
apd.te
--- orig/domains/program/unused/slapd.te	2005-03-24 22:51:49.000000000 +0100
+++ mod/domains/program/unused/slapd.te	2005-04-09 02:30:21.007634056 +0200
@@ -15,7 +15,6 @@
 allow slapd_t ldap_port_t:tcp_socket name_bind;
=20
 etc_domain(slapd)
-typealias slapd_etc_t alias etc_slapd_t;
 type slapd_db_t, file_type, sysadmfile;
 type slapd_replog_t, file_type, sysadmfile;
=20
diff -ur orig/domains/program/unused/snmpd.te mod/domains/program/unused/sn=
mpd.te
--- orig/domains/program/unused/snmpd.te	2005-04-09 02:26:19.857294480 +0200
+++ mod/domains/program/unused/snmpd.te	2005-04-09 02:30:21.023631624 +0200
@@ -20,13 +20,11 @@
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
=20
 etc_domain(snmpd)
-typealias snmpd_etc_t alias etc_snmpd_t;
=20
 # for the .index file
 var_lib_domain(snmpd)
 file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, dir)
 file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
-typealias snmpd_var_lib_t alias snmpd_var_rw_t;
=20
 log_domain(snmpd)
 # for /usr/share/snmp/mibs
diff -ur orig/domains/program/unused/sysstat.te mod/domains/program/unused/=
sysstat.te
--- orig/domains/program/unused/sysstat.te	2004-12-04 00:46:50.000000000 +0=
100
+++ mod/domains/program/unused/sysstat.te	2005-04-09 02:30:21.025631320 +02=
00
@@ -42,7 +42,6 @@
=20
 # Type for files created during execution of sysstatd.
 logdir_domain(sysstat)
-typealias sysstat_log_t alias var_log_sysstat_t;
 allow sysstat_t var_t:dir search;
=20
 allow sysstat_t etc_t:dir r_dir_perms;
diff -ur orig/domains/program/unused/udev.te mod/domains/program/unused/ude=
v.te
--- orig/domains/program/unused/udev.te	2005-04-02 23:33:43.000000000 +0200
+++ mod/domains/program/unused/udev.te	2005-04-09 02:30:21.026631168 +0200
@@ -19,7 +19,6 @@
 }
=20
 etc_domain(udev)
-typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
 can_exec_any(udev_t)
=20
diff -ur orig/macros/global_macros.te mod/macros/global_macros.te
--- orig/macros/global_macros.te	2005-04-09 02:26:20.032267880 +0200
+++ mod/macros/global_macros.te	2005-04-09 02:30:21.029630712 +0200
@@ -444,7 +444,6 @@
=20
 define(`var_lib_domain', `
 type $1_var_lib_t, file_type, sysadmfile;
-typealias $1_var_lib_t alias var_lib_$1_t;
 file_type_auto_trans($1_t, var_lib_t, $1_var_lib_t, file)
 allow $1_t $1_var_lib_t:dir rw_dir_perms;
 ')
Nur in mod/macros: global_macros.te.orig.
diff -ur orig/macros/program/vmware_macros.te mod/macros/program/vmware_mac=
ros.te
--- orig/macros/program/vmware_macros.te	2004-12-09 17:05:16.000000000 +0100
+++ mod/macros/program/vmware_macros.te	2005-04-09 02:30:21.031630408 +0200
@@ -28,11 +28,6 @@
 # The user file type for the VMWare configuration files
 type $1_vmware_conf_t, $1_file_type, file_type, sysadmfile;
=20
-# for compatibility with older policy versions
-typealias $1_vmware_t alias vmware_$1_t;
-typealias $1_vmware_file_t alias vmware_$1_file_t;
-typealias $1_vmware_conf_t alias vmware_$1_conf_t;
-
 #############################################################
 # User rules for running VMWare
 #
diff -ur orig/types/file.te mod/types/file.te
--- orig/types/file.te	2005-04-02 23:33:44.000000000 +0200
+++ mod/types/file.te	2005-04-09 02:30:21.032630256 +0200
@@ -311,7 +311,6 @@
=20
 type cifs_t, fs_type, noexattrfile, sysadmfile;
 allow cifs_t self:filesystem associate;
-typealias cifs_t alias sambafs_t;
=20
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;

--E39vaYmALEf/7YXx--

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCVyMmxWIrrrL0q+cRAtXbAKCyfr3AuImOvNa46UQIMAkdvJRmaQCgrRD7
jodKI9fH9lBHRDt0ftuhROg=
=ApsT
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
