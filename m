Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j390vvtA009789
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 20:57:57 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j390t7UH016090
	for <selinux@tycho.nsa.gov>; Sat, 9 Apr 2005 00:55:08 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 9 Apr 2005 02:51:59 +0200
Date: Sat, 9 Apr 2005 02:51:58 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: file-contexts fixes
Message-Id: <20050409005158.GC7830@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qFgkTsE6LiHkLPZw
Content-Type: multipart/mixed; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds some file_contexts entries, mostly for suse.
It also changes some entries from "(/.*)? --" to "/.* --", a bit
cosmetic, but if we only match on regular files we can add the slash
unconditionally.
Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fc-fixes.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/file_contexts/program/apache.fc mod/file_contexts/program/apa=
che.fc
--- orig/file_contexts/program/apache.fc	2005-04-02 23:33:43.000000000 +0200
+++ mod/file_contexts/program/apache.fc	2005-04-09 02:43:54.508963056 +0200
@@ -36,7 +36,8 @@
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
 ifdef(`distro_suse', `
 # suse puts shell scripts there :-(
-/usr/share/apache2/[^/]*       --      system_u:object_r:bin_t
+/usr/share/apache2/[^/]*	--	system_u:object_r:bin_t
+/usr/sbin/httpd2-.*		--	system_u:object_r:httpd_exec_t
 ')
 /var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_squirrelmail_t
 /var/spool/squirrelmail(/.*)?	system_u:object_r:squirrelmail_spool_t
diff -ur orig/file_contexts/program/apmd.fc mod/file_contexts/program/apmd.=
fc
--- orig/file_contexts/program/apmd.fc	2004-12-09 17:05:15.000000000 +0100
+++ mod/file_contexts/program/apmd.fc	2005-04-09 02:43:54.509962904 +0200
@@ -1,9 +1,12 @@
 # apmd
 /usr/sbin/apmd		--	system_u:object_r:apmd_exec_t
 /usr/sbin/acpid		--	system_u:object_r:apmd_exec_t
+/usr/sbin/powersaved	--	system_u:object_r:apmd_exec_t
 /usr/bin/apm		--	system_u:object_r:apm_exec_t
 /var/run/apmd\.pid	--	system_u:object_r:apmd_var_run_t
 /var/run/\.?acpid\.socket	-s	system_u:object_r:apmd_var_run_t
+/var/run/powersaved\.pid	--	system_u:object_r:apmd_var_run_t
+/var/run/powersave_socket	-s	system_u:object_r:apmd_var_run_t
 /var/log/acpid		--	system_u:object_r:apmd_log_t
 ifdef(`distro_suse', `
 /var/lib/acpi(/.*)?		system_u:object_r:apmd_var_lib_t
diff -ur orig/file_contexts/program/crond.fc mod/file_contexts/program/cron=
d.fc
--- orig/file_contexts/program/crond.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/crond.fc	2005-04-09 02:43:54.510962752 +0200
@@ -27,3 +27,9 @@
 /var/spool/at/spool	-d	system_u:object_r:cron_spool_t
 /var/spool/at/[^/]*	--	<<none>>
 /var/run/atd\.pid	--	system_u:object_r:crond_var_run_t
+ifdef(`distro_suse', `
+/usr/lib/cron/run-crons	--	system_u:object_r:bin_t
+/var/spool/cron/lastrun	-d	system_u:object_r:crond_tmp_t
+/var/spool/cron/lastrun/[^/]*	--	<<none>>
+/var/spool/cron/tabs	-d	system_u:object_r:cron_spool_t
+')
diff -ur orig/file_contexts/program/dhcpc.fc mod/file_contexts/program/dhcp=
c.fc
--- orig/file_contexts/program/dhcpc.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/dhcpc.fc	2005-04-09 02:43:54.512962448 +0200
@@ -6,6 +6,7 @@
 /sbin/dhcpcd		--	system_u:object_r:dhcpc_exec_t
 /sbin/dhclient.*	--	system_u:object_r:dhcpc_exec_t
 /var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
+/var/lib/dhcpcd(/.*)?		system_u:object_r:dhcpc_state_t
 /var/run/dhclient.*\.pid --	system_u:object_r:dhcpc_var_run_t
 /var/run/dhclient.*\.leases --	system_u:object_r:dhcpc_var_run_t
 # pump
diff -ur orig/file_contexts/program/dpkg.fc mod/file_contexts/program/dpkg.=
fc
--- orig/file_contexts/program/dpkg.fc	2005-01-28 10:17:33.000000000 +0100
+++ mod/file_contexts/program/dpkg.fc	2005-04-09 02:43:54.513962296 +0200
@@ -32,7 +32,6 @@
 /var/cache/debconf(/.*)?	system_u:object_r:debconf_cache_t
 /etc/dpkg/.+		--	system_u:object_r:dpkg_etc_t
 /etc/menu-methods/.*	--	system_u:object_r:install_menu_exec_t
-/etc/kde2/.+\.sh	--	system_u:object_r:install_menu_exec_t
 /usr/share/console/getkmapchoice\.pl -- system_u:object_r:bin_t
 /var/run/update-menus\.pid --	system_u:object_r:install_menu_var_run_t
 /usr/share/dlint/digparse --	system_u:object_r:bin_t
diff -ur orig/file_contexts/program/fetchmail.fc mod/file_contexts/program/=
fetchmail.fc
--- orig/file_contexts/program/fetchmail.fc	2004-10-29 20:33:17.000000000 +=
0200
+++ mod/file_contexts/program/fetchmail.fc	2005-04-09 02:43:54.515961992 +0=
200
@@ -1,5 +1,5 @@
 # fetchmail
 /etc/fetchmailrc		--	system_u:object_r:fetchmail_etc_t
 /usr/bin/fetchmail		--	system_u:object_r:fetchmail_exec_t
-/var/run/fetchmail(/.*)?	--	system_u:object_r:fetchmail_var_run_t
+/var/run/fetchmail/.*	--	system_u:object_r:fetchmail_var_run_t
 /var/mail/\.fetchmail-UIDL-cache --	system_u:object_r:fetchmail_uidl_cache=
_t
diff -ur orig/file_contexts/program/fsadm.fc mod/file_contexts/program/fsad=
m.fc
--- orig/file_contexts/program/fsadm.fc	2004-09-23 11:38:29.000000000 +0200
+++ mod/file_contexts/program/fsadm.fc	2005-04-09 02:43:54.516961840 +0200
@@ -22,6 +22,7 @@
 /sbin/swapon.*		--	system_u:object_r:fsadm_exec_t
 /sbin/hdparm		--	system_u:object_r:fsadm_exec_t
 /sbin/raidstart		--	system_u:object_r:fsadm_exec_t
+/sbin/raidautorun	--	system_u:object_r:fsadm_exec_t
 /sbin/mkraid		--	system_u:object_r:fsadm_exec_t
 /sbin/blockdev		--	system_u:object_r:fsadm_exec_t
 /sbin/losetup.*		--	system_u:object_r:fsadm_exec_t
diff -ur orig/file_contexts/program/initrc.fc mod/file_contexts/program/ini=
trc.fc
--- orig/file_contexts/program/initrc.fc	2005-02-04 00:18:19.000000000 +0100
+++ mod/file_contexts/program/initrc.fc	2005-04-09 02:43:54.517961688 +0200
@@ -19,6 +19,9 @@
 /var/run/sysconfig(/.*)?	system_u:object_r:initrc_var_run_t
 /var/run/keymap		--	system_u:object_r:initrc_var_run_t
 /var/run/numlock-on	--	system_u:object_r:initrc_var_run_t
+/var/run/setleds-on	--	system_u:object_r:initrc_var_run_t
+/var/run/bootsplashctl	-p	system_u:object_r:initrc_var_run_t
+/etc/init\.d/\.depend.*	--	system_u:object_r:etc_runtime_t
 ')
=20
 ifdef(`distro_gentoo', `
diff -ur orig/file_contexts/program/lvm.fc mod/file_contexts/program/lvm.fc
--- orig/file_contexts/program/lvm.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/lvm.fc	2005-04-09 02:43:54.519961384 +0200
@@ -14,8 +14,8 @@
 /dev/lvm		-c	system_u:object_r:fixed_disk_device_t
 /dev/mapper/.*		-b	system_u:object_r:fixed_disk_device_t
 /dev/mapper/control	-c	system_u:object_r:lvm_control_t
-/lib/lvm-10(/.*)	--	system_u:object_r:lvm_exec_t
-/lib/lvm-200(/.*)	--	system_u:object_r:lvm_exec_t
+/lib/lvm-10/.*		--	system_u:object_r:lvm_exec_t
+/lib/lvm-200/.*		--	system_u:object_r:lvm_exec_t
 /sbin/e2fsadm		--	system_u:object_r:lvm_exec_t
 /sbin/lvchange		--	system_u:object_r:lvm_exec_t
 /sbin/lvcreate		--	system_u:object_r:lvm_exec_t
diff -ur orig/file_contexts/program/nrpe.fc mod/file_contexts/program/nrpe.=
fc
--- orig/file_contexts/program/nrpe.fc	2005-03-24 22:51:50.000000000 +0100
+++ mod/file_contexts/program/nrpe.fc	2005-04-09 02:43:54.520961232 +0200
@@ -2,6 +2,6 @@
 /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
 /etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
 ifdef(`nagios.te', `', `
-/usr/lib(64)?/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
-/usr/lib(64)?/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib(64)?/netsaint/plugins(/.*)?	system_u:object_r:bin_t
+/usr/lib(64)?/nagios/plugins(/.*)?	system_u:object_r:bin_t
 ')
diff -ur orig/file_contexts/program/openvpn.fc mod/file_contexts/program/op=
envpn.fc
--- orig/file_contexts/program/openvpn.fc	2004-07-26 22:16:11.000000000 +02=
00
+++ mod/file_contexts/program/openvpn.fc	2005-04-09 02:43:54.521961080 +0200
@@ -1,4 +1,4 @@
 # OpenVPN
=20
-/etc/openvpn(/.*)?	--	system_u:object_r:openvpn_etc_t
+/etc/openvpn/.*	--	system_u:object_r:openvpn_etc_t
 /usr/sbin/openvpn	--	system_u:object_r:openvpn_exec_t
diff -ur orig/file_contexts/program/pppd.fc mod/file_contexts/program/pppd.=
fc
--- orig/file_contexts/program/pppd.fc	2004-11-19 09:23:18.000000000 +0100
+++ mod/file_contexts/program/pppd.fc	2005-04-09 02:43:54.523960776 +0200
@@ -11,7 +11,7 @@
 /etc/ppp/.*secrets	--	system_u:object_r:pppd_secret_t
 /var/run/(i)?ppp.*pid	--	system_u:object_r:pppd_var_run_t
 /var/log/ppp-connect-errors.* -- system_u:object_r:pppd_log_t
-/var/log/ppp(/.*)?	--	system_u:object_r:pppd_log_t
+/var/log/ppp/.*	--	system_u:object_r:pppd_log_t
 /etc/ppp/ip-down.*	--	system_u:object_r:bin_t
 /etc/ppp/ip-up.*	--	system_u:object_r:bin_t
 /etc/ppp/ipv6-up	--	system_u:object_r:bin_t
diff -ur orig/file_contexts/program/screen.fc mod/file_contexts/program/scr=
een.fc
--- orig/file_contexts/program/screen.fc	2005-03-24 22:51:51.000000000 +0100
+++ mod/file_contexts/program/screen.fc	2005-04-09 02:43:54.524960624 +0200
@@ -1,5 +1,5 @@
 # screen
 /usr/bin/screen		--	system_u:object_r:screen_exec_t
 HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_screen_ro_home_t
-/var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
-/var/run/screen/S-[^/]+/.*	<<none>>
+/var/run/screens?/S-[^/]+	-d	system_u:object_r:screen_dir_t
+/var/run/screens?/S-[^/]+/.*	<<none>>
diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2005-03-24 22:51:50.000000000 +0100
+++ mod/file_contexts/types.fc	2005-04-09 02:43:54.526960320 +0200
@@ -110,7 +110,7 @@
 # /boot
 #
 /boot(/.*)?			system_u:object_r:boot_t
-/boot/System\.map-.*	--	system_u:object_r:system_map_t
+/boot/System\.map(-.*)?		system_u:object_r:system_map_t
=20
 #
 # /dev

--bajzpZikUji1w+G9--

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCVycuxWIrrrL0q+cRAs49AJ0XZaq81qk3sEfrendkqzjn6u41wQCdF3Pc
n1d/QannAj9CCcoHnBeoCRQ=
=lZap
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
