Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFEJ0Ii023041
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:19:01 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFEHYvq020133
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 14:17:34 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id iAFELnqm024652
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:21:49 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id iAFELnfh024651
	for selinux@tycho.nsa.gov; Mon, 15 Nov 2004 09:21:49 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAC07mIi008224
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2004 19:07:48 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAC06Mq2007980
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 00:06:22 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 12 Nov 2004 01:07:45 +0100
Date: Fri, 12 Nov 2004 01:07:33 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: cleanup patch: fix wrong use of dot in file_contexts
Message-Id: <20041112000732.GE2544@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--wtjvnLv0o8UUzur2
Content-Type: multipart/mixed; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In a lot of places, a simple . was used in the file_contexts file, when
\. was intended. Attached patch fixes this.
It also fixes one or two places where a path specification was
duplicated.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dot-cleanup.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/file_contexts/distros.fc mod/file_contexts/distros.fc
--- orig/file_contexts/distros.fc	2004-10-06 22:21:13.000000000 +0200
+++ mod/file_contexts/distros.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,34 +1,34 @@
 ifdef(`distro_redhat', `
-/usr/share/system-config-network(/netconfig)?/[^/]+.py -- system_u:object_=
r:bin_t
-/etc/sysconfig/networking/profiles/.*/resolv.conf -- system_u:object_r:net=
_conf_t
-/etc/sysconfig/network-scripts/.*resolv.conf -- system_u:object_r:net_conf=
_t
-/usr/share/rhn/rhn_applet/applet.py -- system_u:object_r:bin_t
-/usr/share/rhn/rhn_applet/eggtrayiconmodule.so -- system_u:object_r:shlib_t
-/usr/share/rhn/rhn_applet/needed-packages.py	--	system_u:object_r:bin_t
-/usr/share/authconfig/authconfig-gtk.py -- system_u:object_r:bin_t
+/usr/share/system-config-network(/netconfig)?/[^/]+\.py -- system_u:object=
_r:bin_t
+/etc/sysconfig/networking/profiles/.*/resolv\.conf -- system_u:object_r:ne=
t_conf_t
+/etc/sysconfig/network-scripts/.*resolv\.conf -- system_u:object_r:net_con=
f_t
+/usr/share/rhn/rhn_applet/applet\.py -- system_u:object_r:bin_t
+/usr/share/rhn/rhn_applet/eggtrayiconmodule\.so -- system_u:object_r:shlib=
_t
+/usr/share/rhn/rhn_applet/needed-packages\.py	--	system_u:object_r:bin_t
+/usr/share/authconfig/authconfig-gtk\.py -- system_u:object_r:bin_t
 /usr/share/hwbrowser/hwbrowser -- system_u:object_r:bin_t
 /usr/share/system-config-httpd/system-config-httpd -- system_u:object_r:bi=
n_t
 /usr/share/system-config-services/system-config-services -- system_u:objec=
t_r:bin_t
-/usr/share/system-logviewer/system-logviewer.py -- system_u:object_r:bin_t
-/usr/share/system-config-date/system-config-date.py -- system_u:object_r:b=
in_t
+/usr/share/system-logviewer/system-logviewer\.py -- system_u:object_r:bin_t
+/usr/share/system-config-date/system-config-date\.py -- system_u:object_r:=
bin_t
 /usr/share/system-config-display/system-config-display -- system_u:object_=
r:bin_t
 /usr/share/system-config-keyboard/system-config-keyboard -- system_u:objec=
t_r:bin_t
 /usr/share/system-config-language/system-config-language -- system_u:objec=
t_r:bin_t
 /usr/share/system-config-mouse/system-config-mouse -- system_u:object_r:bi=
n_t
-/usr/share/system-config-netboot/system-config-netboot.py -- system_u:obje=
ct_r:bin_t
-/usr/share/system-config-netboot/pxeos.py -- system_u:object_r:bin_t
-/usr/share/system-config-netboot/pxeboot.py -- system_u:object_r:bin_t
-/usr/share/system-config-nfs/system-config-nfs.py -- system_u:object_r:bin=
_t
+/usr/share/system-config-netboot/system-config-netboot\.py -- system_u:obj=
ect_r:bin_t
+/usr/share/system-config-netboot/pxeos\.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeboot\.py -- system_u:object_r:bin_t
+/usr/share/system-config-nfs/system-config-nfs\.py -- system_u:object_r:bi=
n_t
 /usr/share/system-config-rootpassword/system-config-rootpassword -- system=
_u:object_r:bin_t
-/usr/share/system-config-samba/system-config-samba.py -- system_u:object_r=
:bin_t
-/usr/share/system-config-securitylevel/system-config-securitylevel.py -- s=
ystem_u:object_r:bin_t
-/usr/share/system-config-services/serviceconf.py -- system_u:object_r:bin_t
+/usr/share/system-config-samba/system-config-samba\.py -- system_u:object_=
r:bin_t
+/usr/share/system-config-securitylevel/system-config-securitylevel\.py -- =
system_u:object_r:bin_t
+/usr/share/system-config-services/serviceconf\.py -- system_u:object_r:bin=
_t
 /usr/share/system-config-soundcard/system-config-soundcard -- system_u:obj=
ect_r:bin_t
 /usr/share/system-config-users/system-config-users -- system_u:object_r:bi=
n_t
-/usr/share/switchdesk/switchdesk-gui.py	--	system_u:object_r:bin_t
-/usr/share/system-config-network/neat-control.py	--	system_u:object_r:bin_t
-/usr/share/system-config-nfs/nfs-export.py	--	system_u:object_r:bin_t
-/usr/share/pydict/pydict.py	--	system_u:object_r:bin_t
+/usr/share/switchdesk/switchdesk-gui\.py	--	system_u:object_r:bin_t
+/usr/share/system-config-network/neat-control\.py	--	system_u:object_r:bin=
_t
+/usr/share/system-config-nfs/nfs-export\.py	--	system_u:object_r:bin_t
+/usr/share/pydict/pydict\.py	--	system_u:object_r:bin_t
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
 ')
=20
diff -ur orig/file_contexts/program/apache.fc mod/file_contexts/program/apa=
che.fc
--- orig/file_contexts/program/apache.fc	2004-10-17 13:07:14.000000000 +0200
+++ mod/file_contexts/program/apache.fc	2004-11-12 00:59:53.000000000 +0100
@@ -22,16 +22,16 @@
 /usr/lib(64)?/apache(2)?/suexec(2)? -- system_u:object_r:httpd_suexec_exec=
_t
 /var/log/httpd(/.*)?		system_u:object_r:httpd_log_t
 /var/log/apache(2)?(/.*)?	system_u:object_r:httpd_log_t
-/var/log/cgiwrap.log.*	--	system_u:object_r:httpd_log_t
+/var/log/cgiwrap\.log.*	--	system_u:object_r:httpd_log_t
 /var/cache/ssl.*\.sem	--	system_u:object_r:httpd_cache_t
 /var/cache/mod_ssl(/.*)?	system_u:object_r:httpd_cache_t
-/var/run/apache(2)?.pid.* --	system_u:object_r:httpd_var_run_t
+/var/run/apache(2)?\.pid.* --	system_u:object_r:httpd_var_run_t
 /var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
 /usr/lib/apache-ssl(/.*)? --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
-/var/run/apache-ssl(2)?.pid.* -- system_u:object_r:httpd_var_run_t
+/var/run/apache-ssl(2)?\.pid.* -- system_u:object_r:httpd_var_run_t
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
 ifdef(`distro_suse', `
 # suse puts shell scripts there :-(
diff -ur orig/file_contexts/program/apmd.fc mod/file_contexts/program/apmd.=
fc
--- orig/file_contexts/program/apmd.fc	2004-02-13 19:53:37.000000000 +0100
+++ mod/file_contexts/program/apmd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -3,5 +3,5 @@
 /usr/sbin/acpid		--	system_u:object_r:apmd_exec_t
 /usr/bin/apm		--	system_u:object_r:apm_exec_t
 /var/run/apmd\.pid	--	system_u:object_r:apmd_var_run_t
-/var/run/.?acpid.socket	-s	system_u:object_r:apmd_var_run_t
+/var/run/\.?acpid\.socket	-s	system_u:object_r:apmd_var_run_t
 /var/log/acpid		--	system_u:object_r:apmd_log_t
diff -ur orig/file_contexts/program/bootloader.fc mod/file_contexts/program=
/bootloader.fc
--- orig/file_contexts/program/bootloader.fc	2004-09-11 14:31:47.000000000 =
+0200
+++ mod/file_contexts/program/bootloader.fc	2004-11-12 00:59:53.000000000 +=
0100
@@ -9,4 +9,4 @@
 /etc/mkinitrd/scripts/.* --	system_u:object_r:bootloader_exec_t
 /sbin/ybin.*		--	system_u:object_r:bootloader_exec_t
 /etc/yaboot\.conf.*	--	system_u:object_r:bootloader_etc_t
-/boot/grub/menu.lst	--	system_u:object_r:boot_runtime_t
+/boot/grub/menu\.lst	--	system_u:object_r:boot_runtime_t
diff -ur orig/file_contexts/program/cardmgr.fc mod/file_contexts/program/ca=
rdmgr.fc
--- orig/file_contexts/program/cardmgr.fc	2004-06-19 10:31:43.000000000 +02=
00
+++ mod/file_contexts/program/cardmgr.fc	2004-11-12 00:59:53.000000000 +0100
@@ -2,6 +2,6 @@
 /sbin/cardmgr		--	system_u:object_r:cardmgr_exec_t
 /sbin/cardctl		--	system_u:object_r:cardctl_exec_t
 /var/run/stab		--	system_u:object_r:cardmgr_var_run_t
-/var/run/cardmgr.pid	--	system_u:object_r:cardmgr_var_run_t
+/var/run/cardmgr\.pid	--	system_u:object_r:cardmgr_var_run_t
 /etc/apm/event\.d/pcmcia --	system_u:object_r:cardmgr_exec_t
 /var/lib/pcmcia(/.*)?		system_u:object_r:cardmgr_var_run_t
diff -ur orig/file_contexts/program/clamav.fc mod/file_contexts/program/cla=
mav.fc
--- orig/file_contexts/program/clamav.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/clamav.fc	2004-11-12 00:59:53.000000000 +0100
@@ -4,9 +4,9 @@
 /usr/sbin/clamav-freshclam-handledaemon	-- system_u:object_r:freshclam_exe=
c_t
 /usr/sbin/clamd		--	system_u:object_r:clamd_exec_t
 /var/lib/clamav(/.*)?		system_u:object_r:clamav_var_lib_t
-/var/log/clam-update.log --	system_u:object_r:freshclam_log_t
-/var/log/clamav-freshclam.log.* -- system_u:object_r:freshclam_log_t
-/var/run/clamd.ctl	-s	system_u:object_r:clamd_var_run_t
-/var/run/clamd.pid	--	system_u:object_r:clamd_var_run_t
+/var/log/clam-update\.log --	system_u:object_r:freshclam_log_t
+/var/log/clamav-freshclam\.log.* -- system_u:object_r:freshclam_log_t
+/var/run/clamd\.ctl	-s	system_u:object_r:clamd_var_run_t
+/var/run/clamd\.pid	--	system_u:object_r:clamd_var_run_t
 /var/log/clamav(/.*)?		system_u:object_r:freshclam_log_t
 /var/run/clamav(/.*)?		system_u:object_r:clamd_var_run_t
diff -ur orig/file_contexts/program/comsat.fc mod/file_contexts/program/com=
sat.fc
--- orig/file_contexts/program/comsat.fc	2004-09-27 21:04:36.000000000 +0200
+++ mod/file_contexts/program/comsat.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,2 +1,2 @@
 # biff server
-/usr/sbin/in.comsat	--	system_u:object_r:comsat_exec_t
+/usr/sbin/in\.comsat	--	system_u:object_r:comsat_exec_t
diff -ur orig/file_contexts/program/courier.fc mod/file_contexts/program/co=
urier.fc
--- orig/file_contexts/program/courier.fc	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/file_contexts/program/courier.fc	2004-11-12 00:59:53.000000000 +0100
@@ -8,7 +8,7 @@
 /usr/lib(64)?/courier/courier/pcpd	--	system_u:object_r:courier_pcp_exec_t
 /usr/lib(64)?/courier/imapd		--	system_u:object_r:courier_pop_exec_t
 /usr/lib(64)?/courier/pop3d		--	system_u:object_r:courier_pop_exec_t
-/usr/lib(64)?/courier/sqwebmail/cleancache.pl -- system_u:object_r:sqwebma=
il_cron_exec_t
+/usr/lib(64)?/courier/sqwebmail/cleancache\.pl -- system_u:object_r:sqwebm=
ail_cron_exec_t
 /var/lib/courier(/.*)?			system_u:object_r:courier_var_lib_t
 /usr/bin/imapd			--	system_u:object_r:courier_pop_exec_t
 /usr/sbin/courierlogger		--	system_u:object_r:courier_exec_t
diff -ur orig/file_contexts/program/crond.fc mod/file_contexts/program/cron=
d.fc
--- orig/file_contexts/program/crond.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/crond.fc	2004-11-12 00:59:53.000000000 +0100
@@ -16,9 +16,9 @@
 /usr/sbin/fcron		--	system_u:object_r:crond_exec_t
 /var/spool/fcron	-d	system_u:object_r:cron_spool_t
 /var/spool/fcron/.*		<<none>>
-/var/spool/fcron/systab.orig --	system_u:object_r:system_cron_spool_t
+/var/spool/fcron/systab\.orig --	system_u:object_r:system_cron_spool_t
 /var/spool/fcron/systab	 --	system_u:object_r:system_cron_spool_t
-/var/spool/fcron/new.systab --	system_u:object_r:system_cron_spool_t
+/var/spool/fcron/new\.systab --	system_u:object_r:system_cron_spool_t
 /var/run/fcron\.fifo	-s	system_u:object_r:crond_var_run_t
 /var/run/fcron\.pid	--	system_u:object_r:crond_var_run_t
 # atd
diff -ur orig/file_contexts/program/cups.fc mod/file_contexts/program/cups.=
fc
--- orig/file_contexts/program/cups.fc	2004-10-17 13:07:14.000000000 +0200
+++ mod/file_contexts/program/cups.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,18 +1,18 @@
 # cups printing
 /etc/cups(/.*)?			system_u:object_r:cupsd_etc_t
 /usr/share/cups(/.*)?		system_u:object_r:cupsd_etc_t
-/etc/alchemist/namespace/printconf/local.adl system_u:object_r:cupsd_rw_et=
c_t
+/etc/alchemist/namespace/printconf/local\.adl system_u:object_r:cupsd_rw_e=
tc_t
 /var/cache/alchemist/printconf.* system_u:object_r:cupsd_rw_etc_t
 /etc/cups/client\.conf	--	system_u:object_r:etc_t
-/etc/cups/cupsd.conf.* --	system_u:object_r:cupsd_rw_etc_t
+/etc/cups/cupsd\.conf.* --	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/lpoptions	--	system_u:object_r:cupsd_rw_etc_t
-/etc/cups/printers.conf.* --	system_u:object_r:cupsd_rw_etc_t
+/etc/cups/printers\.conf.* --	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/ppd/.*	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/certs		-d	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/certs/.*	--	system_u:object_r:cupsd_rw_etc_t
 /var/lib/cups/certs	-d	system_u:object_r:cupsd_rw_etc_t
 /var/lib/cups/certs/.*	--	system_u:object_r:cupsd_rw_etc_t
-/etc/cups/ppds.dat	--	system_u:object_r:cupsd_rw_etc_t
+/etc/cups/ppds\.dat	--	system_u:object_r:cupsd_rw_etc_t
 /etc/cups/lpoptions.* 	--	system_u:object_r:cupsd_rw_etc_t
 /etc/printcap.* 	--	system_u:object_r:cupsd_rw_etc_t
 /usr/lib(64)?/cups/backend/.* --	system_u:object_r:cupsd_exec_t
@@ -26,9 +26,9 @@
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
 /usr/lib(64)?/cups/filter/.*	--	system_u:object_r:bin_t
 /usr/lib(64)?/cups/cgi-bin/.* --	system_u:object_r:bin_t
-/usr/bin/lpr.cups	--	system_u:object_r:lpr_exec_t
-/usr/bin/lpq.cups	--	system_u:object_r:lpr_exec_t
-/usr/bin/lprm.cups	--	system_u:object_r:lpr_exec_t
+/usr/bin/lpr\.cups	--	system_u:object_r:lpr_exec_t
+/usr/bin/lpq\.cups	--	system_u:object_r:lpr_exec_t
+/usr/bin/lprm\.cups	--	system_u:object_r:lpr_exec_t
 /usr/sbin/ptal-printd	--	system_u:object_r:ptal_exec_t
 /usr/sbin/ptal-mlcd	--	system_u:object_r:ptal_exec_t
 /var/run/ptal-printd(/.*)?	system_u:object_r:ptal_var_run_t
diff -ur orig/file_contexts/program/ddclient.fc mod/file_contexts/program/d=
dclient.fc
--- orig/file_contexts/program/ddclient.fc	2004-10-29 20:33:17.000000000 +0=
200
+++ mod/file_contexts/program/ddclient.fc	2004-11-12 00:59:53.000000000 +01=
00
@@ -1,5 +1,5 @@
 # ddclient
-/etc/ddclient.conf		--	system_u:object_r:ddclient_etc_t
+/etc/ddclient\.conf		--	system_u:object_r:ddclient_etc_t
 /usr/sbin/ddclient		--	system_u:object_r:ddclient_exec_t
 /var/cache/ddclient(/.*)?	--	system_u:object_r:ddclient_var_t
 /var/run/ddclient\.pid		--	system_u:object_r:ddclient_var_run_t
diff -ur orig/file_contexts/program/dhcpc.fc mod/file_contexts/program/dhcp=
c.fc
--- orig/file_contexts/program/dhcpc.fc	2004-07-12 23:41:14.000000000 +0200
+++ mod/file_contexts/program/dhcpc.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,5 +1,5 @@
 # dhcpcd=20
-/etc/dhcpc.*(/.*)?		system_u:object_r:dhcp_etc_t
+/etc/dhcpc.*			system_u:object_r:dhcp_etc_t
 /etc/dhcp3?/dhclient.*		system_u:object_r:dhcp_etc_t
 /etc/dhclient.*conf	--	system_u:object_r:dhcp_etc_t
 /etc/dhclient-script	--	system_u:object_r:dhcp_etc_t
@@ -7,7 +7,7 @@
 /sbin/dhclient.*	--	system_u:object_r:dhcpc_exec_t
 /var/lib/dhcp(3)?/dhclient.*	system_u:object_r:dhcpc_state_t
 /var/run/dhclient.*\.pid --	system_u:object_r:dhcpc_var_run_t
-/var/run/dhclient.*.leases --	system_u:object_r:dhcpc_var_run_t
+/var/run/dhclient.*\.leases --	system_u:object_r:dhcpc_var_run_t
 # pump
 /sbin/pump		--	system_u:object_r:dhcpc_exec_t
 ifdef(`dhcp_defined', `', `
diff -ur orig/file_contexts/program/dhcpd.fc mod/file_contexts/program/dhcp=
d.fc
--- orig/file_contexts/program/dhcpd.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/dhcpd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,5 +1,5 @@
 # dhcpd
-/etc/dhcpd.conf		--	system_u:object_r:dhcp_etc_t
+/etc/dhcpd\.conf	--	system_u:object_r:dhcp_etc_t
 /etc/dhcp3(/.*)?		system_u:object_r:dhcp_etc_t
 /usr/sbin/dhcpd.*	--	system_u:object_r:dhcpd_exec_t
 /var/lib/dhcp(3)?/dhcpd\.leases.* -- system_u:object_r:dhcpd_state_t
diff -ur orig/file_contexts/program/dictd.fc mod/file_contexts/program/dict=
d.fc
--- orig/file_contexts/program/dictd.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/dictd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,4 +1,4 @@
 # dictd
-/etc/dictd.conf		--	system_u:object_r:dictd_etc_t
+/etc/dictd\.conf		--	system_u:object_r:dictd_etc_t
 /usr/sbin/dictd		--	system_u:object_r:dictd_exec_t
 /var/lib/dictd(/.*)?		system_u:object_r:var_lib_dictd_t
diff -ur orig/file_contexts/program/dovecot.fc mod/file_contexts/program/do=
vecot.fc
--- orig/file_contexts/program/dovecot.fc	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/file_contexts/program/dovecot.fc	2004-11-12 00:59:53.000000000 +0100
@@ -5,9 +5,8 @@
 ')
 ifdef(`distro_debian', `
 /usr/lib/dovecot/dovecot-auth	--	system_u:object_r:dovecot_auth_exec_t
-/usr/lib/dovecot/.+		--	system_u:object_r:bin_t
 ')
-/usr/share/ssl/certs/dovecot.pem --	system_u:object_r:dovecot_cert_t
-/usr/share/ssl/private/dovecot.pem --	system_u:object_r:dovecot_cert_t
+/usr/share/ssl/certs/dovecot\.pem --	system_u:object_r:dovecot_cert_t
+/usr/share/ssl/private/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
 /usr/lib/dovecot/.+	--		system_u:object_r:bin_t
diff -ur orig/file_contexts/program/dpkg.fc mod/file_contexts/program/dpkg.=
fc
--- orig/file_contexts/program/dpkg.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/dpkg.fc	2004-11-12 00:59:53.000000000 +0100
@@ -37,8 +37,8 @@
 /var/run/update-menus\.pid --	system_u:object_r:install_menu_var_run_t
 /usr/share/openoffice\.org-debian-files/install-hook -- system_u:object_r:=
bin_t
 /usr/share/dlint/digparse --	system_u:object_r:bin_t
-/usr/share/gimp/1.2/user_install -- system_u:object_r:bin_t
-/usr/share/openoffice.org-debian-files/install-hook -- system_u:object_r:b=
in_t
+/usr/share/gimp/1\.2/user_install -- system_u:object_r:bin_t
+/usr/share/openoffice\.org-debian-files/install-hook -- system_u:object_r:=
bin_t
 /var/lib/defoma(/.*)?		system_u:object_r:fonts_t
 /usr/lib(64)?/doc-rfc/register-doc-rfc-docs -- system_u:object_r:bin_t
 /usr/share/intltool-debian/.* -- system_u:object_r:bin_t
diff -ur orig/file_contexts/program/fingerd.fc mod/file_contexts/program/fi=
ngerd.fc
--- orig/file_contexts/program/fingerd.fc	2004-03-03 21:53:51.000000000 +01=
00
+++ mod/file_contexts/program/fingerd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,6 +1,6 @@
 # fingerd
 /usr/sbin/in\.fingerd	--	system_u:object_r:fingerd_exec_t
 /usr/sbin/[cef]fingerd	--	system_u:object_r:fingerd_exec_t
-/etc/cron.weekly/(c)?fingerd -- system_u:object_r:fingerd_exec_t
+/etc/cron\.weekly/(c)?fingerd -- system_u:object_r:fingerd_exec_t
 /etc/cfingerd(/.*)?		system_u:object_r:fingerd_etc_t
 /var/log/cfingerd\.log.* --	system_u:object_r:fingerd_log_t
diff -ur orig/file_contexts/program/firstboot.fc mod/file_contexts/program/=
firstboot.fc
--- orig/file_contexts/program/firstboot.fc	2004-09-11 14:31:47.000000000 +=
0200
+++ mod/file_contexts/program/firstboot.fc	2004-11-12 00:59:53.000000000 +0=
100
@@ -1,4 +1,4 @@
 # firstboot
 /usr/sbin/firstboot	-- system_u:object_r:firstboot_exec_t
 /usr/share/firstboot	system_u:object_r:firstboot_rw_t
-/usr/share/firstboot/firstboot.py --	system_u:object_r:firstboot_exec_t
+/usr/share/firstboot/firstboot\.py --	system_u:object_r:firstboot_exec_t
diff -ur orig/file_contexts/program/fs_daemon.fc mod/file_contexts/program/=
fs_daemon.fc
--- orig/file_contexts/program/fs_daemon.fc	2004-10-14 13:09:54.000000000 +=
0200
+++ mod/file_contexts/program/fs_daemon.fc	2004-11-12 00:59:53.000000000 +0=
100
@@ -1,4 +1,4 @@
 # fs admin daemons
 /usr/sbin/smartd	--	system_u:object_r:fsdaemon_exec_t
-/var/run/smartd.pid	--	system_u:object_r:fsdaemon_var_run_t
-/etc/smartd.conf	--	system_u:object_r:etc_runtime_t
+/var/run/smartd\.pid	--	system_u:object_r:fsdaemon_var_run_t
+/etc/smartd\.conf	--	system_u:object_r:etc_runtime_t
diff -ur orig/file_contexts/program/ftpd.fc mod/file_contexts/program/ftpd.=
fc
--- orig/file_contexts/program/ftpd.fc	2004-10-19 21:15:26.000000000 +0200
+++ mod/file_contexts/program/ftpd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -7,7 +7,7 @@
 /usr/sbin/vsftpd	--	system_u:object_r:ftpd_exec_t
 /etc/proftpd\.conf	--	system_u:object_r:ftpd_etc_t
 /var/run/proftpd/proftpd-inetd -- system_u:object_r:ftpd_var_run_t
-/var/run/proftpd/proftpd.scoreboard -- system_u:object_r:ftpd_var_run_t
+/var/run/proftpd/proftpd\.scoreboard -- system_u:object_r:ftpd_var_run_t
 /var/log/muddleftpd\.log.* --	system_u:object_r:xferlog_t
 /var/log/xferlog.*	--	system_u:object_r:xferlog_t
 /var/log/xferreport.*	--	system_u:object_r:xferlog_t
diff -ur orig/file_contexts/program/hald.fc mod/file_contexts/program/hald.=
fc
--- orig/file_contexts/program/hald.fc	2004-09-23 11:38:29.000000000 +0200
+++ mod/file_contexts/program/hald.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,5 +1,5 @@
 # hald - hardware information daemon
 /usr/sbin/hald		--	system_u:object_r:hald_exec_t
 /usr/libexec/hal-hotplug-map -- system_u:object_r:hald_exec_t
-/etc/hal/device.d/printer_remove.hal -- system_u:object_r:hald_exec_t
-/etc/hal/capability.d/printer_update.hal -- system_u:object_r:hald_exec_t
+/etc/hal/device\.d/printer_remove\.hal -- system_u:object_r:hald_exec_t
+/etc/hal/capability\.d/printer_update\.hal -- system_u:object_r:hald_exec_t
diff -ur orig/file_contexts/program/hotplug.fc mod/file_contexts/program/ho=
tplug.fc
--- orig/file_contexts/program/hotplug.fc	2004-10-19 21:15:26.000000000 +02=
00
+++ mod/file_contexts/program/hotplug.fc	2004-11-12 00:59:53.000000000 +0100
@@ -6,5 +6,5 @@
 /etc/netplug.d(/.*)? 	 	system_u:object_r:sbin_t
 /etc/hotplug/.*agent	--	system_u:object_r:sbin_t
 /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
-/etc/hotplug/hotplug.functions --	system_u:object_r:sbin_t
+/etc/hotplug/hotplug\.functions --	system_u:object_r:sbin_t
 /var/run/usb(/.*)?		system_u:object_r:hotplug_var_run_t
diff -ur orig/file_contexts/program/howl.fc mod/file_contexts/program/howl.=
fc
--- orig/file_contexts/program/howl.fc	2004-08-06 14:23:52.000000000 +0200
+++ mod/file_contexts/program/howl.fc	2004-11-12 00:59:53.000000000 +0100
@@ -1,3 +1,3 @@
 /usr/bin/nifd	--	system_u:object_r:howl_exec_t
 /usr/bin/mDNSResponder	--	system_u:object_r:howl_exec_t
-/var/run/nifd.pid --	system_u:object_r:howl_var_run_t
+/var/run/nifd\.pid --	system_u:object_r:howl_var_run_t
diff -ur orig/file_contexts/program/imazesrv.fc mod/file_contexts/program/i=
mazesrv.fc
--- orig/file_contexts/program/imazesrv.fc	2004-02-11 20:11:28.000000000 +0=
100
+++ mod/file_contexts/program/imazesrv.fc	2004-11-12 00:59:53.000000000 +01=
00
@@ -1,4 +1,4 @@
 #  imazesrv
 /usr/share/games/imaze(/.*)?	system_u:object_r:imazesrv_data_t
 /usr/games/imazesrv --	system_u:object_r:imazesrv_exec_t
-/var/log/imaze.log --	system_u:object_r:imazesrv_log_t
+/var/log/imaze\.log --	system_u:object_r:imazesrv_log_t
diff -ur orig/file_contexts/program/initrc.fc mod/file_contexts/program/ini=
trc.fc
--- orig/file_contexts/program/initrc.fc	2004-10-17 13:07:14.000000000 +0200
+++ mod/file_contexts/program/initrc.fc	2004-11-12 00:59:53.000000000 +0100
@@ -20,8 +20,8 @@
 ifdef(`distro_gentoo', `
 /sbin/rc		--	system_u:object_r:initrc_exec_t
 /sbin/runscript		--      system_u:object_r:initrc_exec_t
-/sbin/runscript.sh	--	system_u:object_r:initrc_exec_t
-/var/lib/init.d(/.*)?		system_u:object_r:initrc_state_t
+/sbin/runscript\.sh	--	system_u:object_r:initrc_exec_t
+/var/lib/init\.d(/.*)?		system_u:object_r:initrc_state_t
 ')
=20
 # run_init
diff -ur orig/file_contexts/program/innd.fc mod/file_contexts/program/innd.=
fc
--- orig/file_contexts/program/innd.fc	2004-11-09 08:45:55.000000000 +0100
+++ mod/file_contexts/program/innd.fc	2004-11-12 00:59:53.000000000 +0100
@@ -7,7 +7,7 @@
 /var/log/news(/.*)?		system_u:object_r:innd_log_t
 /var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
 /var/run/news(/.*)?	 	system_u:object_r:innd_var_run_t
-/usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
+/usr/sbin/in\.nnrpd	--	system_u:object_r:innd_exec_t
 /usr/bin/inews		--	system_u:object_r:innd_exec_t
 /usr/bin/rnews		--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin(/.*)?		system_u:object_r:bin_t
diff -ur orig/file_contexts/program/irc.fc mod/file_contexts/program/irc.fc
--- orig/file_contexts/program/irc.fc	2004-03-09 16:31:36.000000000 +0100
+++ mod/file_contexts/program/irc.fc	2004-11-12 00:59:53.000000000 +0100
@@ -2,4 +2,4 @@
 /usr/bin/[st]irc	--	system_u:object_r:irc_exec_t
 /usr/bin/ircII		--	system_u:object_r:irc_exec_t
 /usr/bin/tinyirc	--	system_u:object_r:irc_exec_t
-HOME_DIR/.ircmotd	--	system_u:object_r:ROLE_home_irc_t
+HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_home_irc_t
diff -ur orig/file_contexts/program/kerberos.fc mod/file_contexts/program/k=
erberos.fc
--- orig/file_contexts/program/kerberos.fc	2004-10-19 21:15:26.000000000 +0=
200
+++ mod/file_contexts/program/kerberos.fc	2004-11-12 00:59:53.000000000 +01=
00
@@ -6,7 +6,7 @@
 /usr/local/var/krb5kdc(/.*)?		system_u:object_r:krb5kdc_conf_t
 /var/kerberos/krb5kdc/principal.*	system_u:object_r:krb5kdc_principal_t
 /usr/local/var/krb5kdc/principal.*	system_u:object_r:krb5kdc_principal_t
-/var/log/krb5kdc.log			system_u:object_r:krb5kdc_log_t
-/var/log/kadmind.log			system_u:object_r:kadmind_log_t
+/var/log/krb5kdc\.log			system_u:object_r:krb5kdc_log_t
+/var/log/kadmind\.log			system_u:object_r:kadmind_log_t
 /usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
-/usr/kerberos/sbin/login.krb5	--	system_u:object_r:login_exec_t
+/usr/kerberos/sbin/login\.krb5	--	system_u:object_r:login_exec_t
diff -ur orig/file_contexts/program/logrotate.fc mod/file_contexts/program/=
logrotate.fc
--- orig/file_contexts/program/logrotate.fc	2004-09-11 14:31:47.000000000 +=
0200
+++ mod/file_contexts/program/logrotate.fc	2004-11-12 01:00:09.000000000 +0=
100
@@ -5,7 +5,7 @@
 /usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
 ')
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
-/var/lib/logrotate.status --	system_u:object_r:logrotate_var_lib_t
+/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
 /var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
 # using a hard-coded name under /var/tmp is a bug - new version fixes it
 /var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t
diff -ur orig/file_contexts/program/lvm.fc mod/file_contexts/program/lvm.fc
--- orig/file_contexts/program/lvm.fc	2004-09-15 19:01:07.000000000 +0200
+++ mod/file_contexts/program/lvm.fc	2004-11-12 01:00:09.000000000 +0100
@@ -38,7 +38,7 @@
 /sbin/vgcfgbackup	--	system_u:object_r:lvm_exec_t
 /sbin/vgcfgrestore	--	system_u:object_r:lvm_exec_t
 /sbin/vgchange		--	system_u:object_r:lvm_exec_t
-/sbin/vgchange.static	--	system_u:object_r:lvm_exec_t
+/sbin/vgchange\.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgck		--	system_u:object_r:lvm_exec_t
 /sbin/vgcreate		--	system_u:object_r:lvm_exec_t
 /sbin/vgdisplay		--	system_u:object_r:lvm_exec_t
@@ -51,14 +51,14 @@
 /sbin/vgremove		--	system_u:object_r:lvm_exec_t
 /sbin/vgrename		--	system_u:object_r:lvm_exec_t
 /sbin/vgscan		--	system_u:object_r:lvm_exec_t
-/sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
+/sbin/vgscan\.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
 /sbin/cryptsetup	--	system_u:object_r:lvm_exec_t
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
-/sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
+/sbin/dmsetup\.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t
-/sbin/lvm.static   --      system_u:object_r:lvm_exec_t
+/sbin/lvm\.static   --      system_u:object_r:lvm_exec_t
 /usr/sbin/lvm		--	system_u:object_r:lvm_exec_t
 /sbin/lvresize     --      system_u:object_r:lvm_exec_t
 /sbin/lvs          --      system_u:object_r:lvm_exec_t
diff -ur orig/file_contexts/program/modutil.fc mod/file_contexts/program/mo=
dutil.fc
--- orig/file_contexts/program/modutil.fc	2004-03-17 19:26:06.000000000 +01=
00
+++ mod/file_contexts/program/modutil.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,7 +1,7 @@
 # module utilities
 /etc/modules\.conf.*	--	system_u:object_r:modules_conf_t
 /etc/modprobe\.conf.*	--	system_u:object_r:modules_conf_t
-/lib(64)?/modules/modprobe.conf --	system_u:object_r:modules_conf_t
+/lib(64)?/modules/modprobe\.conf --	system_u:object_r:modules_conf_t
 /lib(64)?/modules(/.*)?		system_u:object_r:modules_object_t
 /lib(64)?/modules/[^/]+/modules\..+ -- system_u:object_r:modules_dep_t
 /lib(64)?/modules/modprobe\.conf.* -- system_u:object_r:modules_conf_t
@@ -11,4 +11,4 @@
 /sbin/insmod_ksymoops_clean --	system_u:object_r:sbin_t
 /sbin/rmmod.*		--	system_u:object_r:insmod_exec_t
 /sbin/update-modules	--	system_u:object_r:update_modules_exec_t
-/sbin/generate-modprobe.conf -- system_u:object_r:update_modules_exec_t
+/sbin/generate-modprobe\.conf -- system_u:object_r:update_modules_exec_t
diff -ur orig/file_contexts/program/monopd.fc mod/file_contexts/program/mon=
opd.fc
--- orig/file_contexts/program/monopd.fc	2004-02-11 20:11:28.000000000 +0100
+++ mod/file_contexts/program/monopd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,4 +1,4 @@
 # monopd
-/etc/monopd.conf	--	system_u:object_r:etc_monopd_t
+/etc/monopd\.conf	--	system_u:object_r:etc_monopd_t
 /usr/sbin/monopd	--	system_u:object_r:monopd_exec_t
 /usr/share/monopd/games(/.*)?	system_u:object_r:share_monopd_t
diff -ur orig/file_contexts/program/mozilla.fc mod/file_contexts/program/mo=
zilla.fc
--- orig/file_contexts/program/mozilla.fc	2004-10-11 10:03:25.000000000 +02=
00
+++ mod/file_contexts/program/mozilla.fc	2004-11-12 01:00:09.000000000 +0100
@@ -12,7 +12,7 @@
 /usr/bin/epiphany-bin   --	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-[0-9].* --	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-bin-[0-9].* --	system_u:object_r:mozilla_exec_t
-/usr/lib(64)?/netscape/.+/communicator/communicator-smotif.real -- system_=
u:object_r:mozilla_exec_t
+/usr/lib(64)?/netscape/.+/communicator/communicator-smotif\.real -- system=
_u:object_r:mozilla_exec_t
 /usr/lib(64)?/netscape/base-4/wrapper -- system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/mozilla[^/]*/reg.+	--	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
diff -ur orig/file_contexts/program/mrtg.fc mod/file_contexts/program/mrtg.=
fc
--- orig/file_contexts/program/mrtg.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/mrtg.fc	2004-11-12 01:00:09.000000000 +0100
@@ -3,5 +3,5 @@
 /var/lib/mrtg(/.*)?		system_u:object_r:var_lib_mrtg_t
 /var/lock/mrtg(/.*)?		system_u:object_r:mrtg_lock_t
 /etc/mrtg.*			system_u:object_r:mrtg_etc_t
-/etc/mrtg/mrtg.ok	--	system_u:object_r:mrtg_lock_t
+/etc/mrtg/mrtg\.ok	--	system_u:object_r:mrtg_lock_t
 /var/log/mrtg(/.*)?		system_u:object_r:mrtg_log_t
diff -ur orig/file_contexts/program/mysqld.fc mod/file_contexts/program/mys=
qld.fc
--- orig/file_contexts/program/mysqld.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/mysqld.fc	2004-11-12 01:00:09.000000000 +0100
@@ -4,7 +4,7 @@
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
 /var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
-/var/lib/mysql/mysql.sock -s	system_u:object_r:mysqld_var_run_t
+/var/lib/mysql/mysql\.sock -s	system_u:object_r:mysqld_var_run_t
 /etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
 /etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t
 ifdef(`distro_debian', `
diff -ur orig/file_contexts/program/nrpe.fc mod/file_contexts/program/nrpe.=
fc
--- orig/file_contexts/program/nrpe.fc	2004-06-16 19:38:16.000000000 +0200
+++ mod/file_contexts/program/nrpe.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,5 +1,5 @@
 # nrpe
 /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
-/etc/nagios/nrpe.cfg	--	system_u:object_r:nrpe_etc_t
+/etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
 /usr/lib/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
 /usr/lib/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
diff -ur orig/file_contexts/program/nsd.fc mod/file_contexts/program/nsd.fc
--- orig/file_contexts/program/nsd.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/nsd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -2,9 +2,9 @@
 /etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
 /etc/nsd/primary(/.*)?		system_u:object_r:nsd_zone_t
 /etc/nsd/secondary(/.*)?	system_u:object_r:nsd_zone_t
-/etc/nsd/nsd.db		--	system_u:object_r:nsd_db_t
+/etc/nsd/nsd\.db		--	system_u:object_r:nsd_db_t
 /var/lib/nsd(/.*)?		system_u:object_r:nsd_zone_t
-/var/lib/nsd/nsd.db	--	system_u:object_r:nsd_db_t
+/var/lib/nsd/nsd\.db	--	system_u:object_r:nsd_db_t
 /usr/sbin/nsd      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsdc      	--	system_u:object_r:nsd_exec_t
 /usr/sbin/nsd-notify	--	system_u:object_r:nsd_exec_t
diff -ur orig/file_contexts/program/ntpd.fc mod/file_contexts/program/ntpd.=
fc
--- orig/file_contexts/program/ntpd.fc	2004-10-11 10:03:25.000000000 +0200
+++ mod/file_contexts/program/ntpd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -7,6 +7,6 @@
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
 /var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
-/var/run/ntpd.pid		--	system_u:object_r:ntpd_var_run_t
+/var/run/ntpd\.pid		--	system_u:object_r:ntpd_var_run_t
 /etc/cron\.(daily|weekly)/ntp-simple -- system_u:object_r:ntpd_exec_t
 /etc/cron\.(daily|weekly)/ntp-server -- system_u:object_r:ntpd_exec_t
diff -ur orig/file_contexts/program/portslave.fc mod/file_contexts/program/=
portslave.fc
--- orig/file_contexts/program/portslave.fc	2004-02-02 16:17:23.000000000 +=
0100
+++ mod/file_contexts/program/portslave.fc	2004-11-12 01:00:09.000000000 +0=
100
@@ -2,4 +2,4 @@
 /usr/sbin/portslave	--	system_u:object_r:portslave_exec_t
 /usr/sbin/ctlportslave	--	system_u:object_r:portslave_exec_t
 /etc/portslave(/.*)?		system_u:object_r:portslave_etc_t
-/var/run/radius.((id)|(seq)) -- system_u:object_r:pppd_var_run_t
+/var/run/radius\.(id|seq) -- system_u:object_r:pppd_var_run_t
diff -ur orig/file_contexts/program/pppd.fc mod/file_contexts/program/pppd.=
fc
--- orig/file_contexts/program/pppd.fc	2004-10-30 10:30:04.000000000 +0200
+++ mod/file_contexts/program/pppd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -16,5 +16,5 @@
 /etc/ppp/ip-up.*	--	system_u:object_r:bin_t
 /etc/ppp/ipv6-up	--	system_u:object_r:bin_t
 /etc/ppp/ipv6-down	--	system_u:object_r:bin_t
-/etc/ppp/plugins/rp-pppoe.so 	--	system_u:object_r:shlib_t
+/etc/ppp/plugins/rp-pppoe\.so 	--	system_u:object_r:shlib_t
 /etc/ppp/resolv\.conf 	--   system_u:object_r:pppd_etc_rw_t
diff -ur orig/file_contexts/program/prelink.fc mod/file_contexts/program/pr=
elink.fc
--- orig/file_contexts/program/prelink.fc	2004-09-11 14:31:47.000000000 +02=
00
+++ mod/file_contexts/program/prelink.fc	2004-11-12 01:00:09.000000000 +0100
@@ -3,6 +3,6 @@
 ifdef(`distro_debian', `
 /usr/sbin/prelink\.bin		--	system_u:object_r:prelink_exec_t
 ')
-/etc/prelink.conf		--	system_u:object_r:etc_prelink_t
-/var/log/prelink.log		--	system_u:object_r:prelink_log_t
-/etc/prelink.cache		--	system_u:object_r:prelink_cache_t
+/etc/prelink\.conf		--	system_u:object_r:etc_prelink_t
+/var/log/prelink\.log		--	system_u:object_r:prelink_log_t
+/etc/prelink\.cache		--	system_u:object_r:prelink_cache_t
diff -ur orig/file_contexts/program/pxe.fc mod/file_contexts/program/pxe.fc
--- orig/file_contexts/program/pxe.fc	2004-03-17 19:26:06.000000000 +0100
+++ mod/file_contexts/program/pxe.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,5 +1,5 @@
 # pxe network boot server
 /usr/sbin/pxe		--	system_u:object_r:pxe_exec_t
-/var/log/pxe.log	--	system_u:object_r:pxe_log_t
-/var/run/pxe.pid	--	system_u:object_r:pxe_var_run_t
+/var/log/pxe\.log	--	system_u:object_r:pxe_log_t
+/var/run/pxe\.pid	--	system_u:object_r:pxe_var_run_t
=20
diff -ur orig/file_contexts/program/quota.fc mod/file_contexts/program/quot=
a.fc
--- orig/file_contexts/program/quota.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/quota.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,5 +1,5 @@
 # quota system
 /var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)	--	system_u:object_r:quota_exec_t
-HOME_ROOT/a?quota.(user|group) -- system_u:object_r:quota_db_t
-/var/a?quota.(user|group) -- system_u:object_r:quota_db_t
+HOME_ROOT/a?quota\.(user|group) -- system_u:object_r:quota_db_t
+/var/a?quota\.(user|group) -- system_u:object_r:quota_db_t
diff -ur orig/file_contexts/program/resmgrd.fc mod/file_contexts/program/re=
smgrd.fc
--- orig/file_contexts/program/resmgrd.fc	2004-10-29 20:33:17.000000000 +02=
00
+++ mod/file_contexts/program/resmgrd.fc	2004-11-12 01:01:07.000000000 +0100
@@ -2,5 +2,5 @@
 /sbin/resmgrd		--	system_u:object_r:resmgrd_exec_t
 /etc/resmgr\.conf	--	system_u:object_r:resmgrd_etc_t
 /var/run/resmgr\.pid	--	system_u:object_r:resmgrd_var_run_t
-/var/run/\.resmgr_socket	system_u:object_r:resmgrd_var_run_t
+/var/run/\.resmgr_socket	-s	system_u:object_r:resmgrd_var_run_t
=20
diff -ur orig/file_contexts/program/rpcd.fc mod/file_contexts/program/rpcd.=
fc
--- orig/file_contexts/program/rpcd.fc	2004-07-12 23:41:19.000000000 +0200
+++ mod/file_contexts/program/rpcd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -4,6 +4,6 @@
 /usr/sbin/rpc\.nfsd	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/exportfs	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/rpc\.mountd	--	system_u:object_r:nfsd_exec_t
-/var/run/rpc.statd.pid	--	system_u:object_r:rpcd_var_run_t
-/var/run/rpc.statd(/.*)?	system_u:object_r:rpcd_var_run_t
+/var/run/rpc\.statd\.pid	--	system_u:object_r:rpcd_var_run_t
+/var/run/rpc\.statd(/.*)?	system_u:object_r:rpcd_var_run_t
 /etc/exports		--	system_u:object_r:exports_t
diff -ur orig/file_contexts/program/rpm.fc mod/file_contexts/program/rpm.fc
--- orig/file_contexts/program/rpm.fc	2004-10-11 10:03:25.000000000 +0200
+++ mod/file_contexts/program/rpm.fc	2004-11-12 01:00:09.000000000 +0100
@@ -11,7 +11,7 @@
 /usr/lib(64)?/rpm/rpmk	-- 	system_u:object_r:bin_t
 /usr/lib(64)?/rpm/rpmv	-- 	system_u:object_r:bin_t
 /var/log/rpmpkgs.*	--	system_u:object_r:rpm_log_t
-/var/log/yum.log	--	system_u:object_r:rpm_log_t
+/var/log/yum\.log	--	system_u:object_r:rpm_log_t
 ifdef(`distro_redhat', `
 /usr/sbin/up2date	--	system_u:object_r:rpm_exec_t
 /usr/sbin/rhn_check	--	system_u:object_r:rpm_exec_t
diff -ur orig/file_contexts/program/sendmail.fc mod/file_contexts/program/s=
endmail.fc
--- orig/file_contexts/program/sendmail.fc	2004-10-11 10:03:25.000000000 +0=
200
+++ mod/file_contexts/program/sendmail.fc	2004-11-12 01:00:09.000000000 +01=
00
@@ -3,5 +3,5 @@
 /var/spool/(client)?mqueue(/.*)?	system_u:object_r:mqueue_spool_t
 /var/log/sendmail\.st		--	system_u:object_r:sendmail_log_t
 /var/log/mail(/.*)?			system_u:object_r:sendmail_log_t
-/var/run/sendmail.pid		--	system_u:object_r:sendmail_var_run_t
-/var/run/sm-client.pid		--	system_u:object_r:sendmail_var_run_t
+/var/run/sendmail\.pid		--	system_u:object_r:sendmail_var_run_t
+/var/run/sm-client\.pid		--	system_u:object_r:sendmail_var_run_t
diff -ur orig/file_contexts/program/seuser.fc mod/file_contexts/program/seu=
ser.fc
--- orig/file_contexts/program/seuser.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/seuser.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,4 +1,4 @@
 # seuser
 /usr/bin/seuser	--	system_u:object_r:seuser_exec_t
-/usr/apol/seuser.conf system_u:object_r:seuser_conf_t
+/usr/apol/seuser\.conf system_u:object_r:seuser_conf_t
=20
diff -ur orig/file_contexts/program/slapd.fc mod/file_contexts/program/slap=
d.fc
--- orig/file_contexts/program/slapd.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/slapd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -4,5 +4,4 @@
 /var/lib/ldap/replog(/.*)?	system_u:object_r:slapd_replog_t
 /var/run/slapd\.args	--	system_u:object_r:slapd_var_run_t
 /etc/ldap/slapd\.conf	--	system_u:object_r:slapd_etc_t
-/usr/lib(64)?/ldap/back.*so.* --	system_u:object_r:shlib_t
 /var/run/slapd\.pid	--	system_u:object_r:slapd_var_run_t
diff -ur orig/file_contexts/program/slocate.fc mod/file_contexts/program/sl=
ocate.fc
--- orig/file_contexts/program/slocate.fc	2004-06-19 10:31:43.000000000 +02=
00
+++ mod/file_contexts/program/slocate.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,4 +1,4 @@
 # locate - file locater
 /usr/bin/slocate		--	system_u:object_r:locate_exec_t
 /var/lib/slocate(/.*)?			system_u:object_r:var_lib_locate_t
-/etc/updatedb.conf		--	system_u:object_r:locate_etc_t
+/etc/updatedb\.conf		--	system_u:object_r:locate_etc_t
diff -ur orig/file_contexts/program/snmpd.fc mod/file_contexts/program/snmp=
d.fc
--- orig/file_contexts/program/snmpd.fc	2004-10-19 21:15:26.000000000 +0200
+++ mod/file_contexts/program/snmpd.fc	2004-11-12 01:00:09.000000000 +0100
@@ -6,4 +6,4 @@
 /var/run/snmpd\.pid	--	system_u:object_r:snmpd_var_run_t
 /var/run/snmpd		-d	system_u:object_r:snmpd_var_run_t
 /var/net-snmp(/.*)		system_u:object_r:snmpd_var_lib_t
-/var/log/snmpd.log	--	system_u:object_r:snmpd_log_t
+/var/log/snmpd\.log	--	system_u:object_r:snmpd_log_t
diff -ur orig/file_contexts/program/udev.fc mod/file_contexts/program/udev.=
fc
--- orig/file_contexts/program/udev.fc	2004-10-14 13:09:55.000000000 +0200
+++ mod/file_contexts/program/udev.fc	2004-11-12 01:00:09.000000000 +0100
@@ -6,7 +6,7 @@
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
 /etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
-/etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
+/etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
 /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
diff -ur orig/file_contexts/program/uptimed.fc mod/file_contexts/program/up=
timed.fc
--- orig/file_contexts/program/uptimed.fc	2004-02-02 17:58:19.000000000 +01=
00
+++ mod/file_contexts/program/uptimed.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,4 +1,4 @@
 # uptimed
-/etc/uptimed.conf	--	system_u:object_r:etc_uptimed_t
+/etc/uptimed\.conf	--	system_u:object_r:etc_uptimed_t
 /usr/sbin/uptimed	--	system_u:object_r:uptimed_exec_t
 /var/spool/uptimed(/.*)?        system_u:object_r:uptimed_spool_t
diff -ur orig/file_contexts/program/ypserv.fc mod/file_contexts/program/yps=
erv.fc
--- orig/file_contexts/program/ypserv.fc	2004-02-02 17:58:19.000000000 +0100
+++ mod/file_contexts/program/ypserv.fc	2004-11-12 01:00:09.000000000 +0100
@@ -1,3 +1,3 @@
 # ypserv
 /usr/sbin/ypserv		--	system_u:object_r:ypserv_exec_t
-/etc/ypserv.conf		--	system_u:object_r:ypserv_conf_t
+/etc/ypserv\.conf		--	system_u:object_r:ypserv_conf_t
diff -ur orig/file_contexts/program/zebra.fc mod/file_contexts/program/zebr=
a.fc
--- orig/file_contexts/program/zebra.fc	2004-10-11 10:03:25.000000000 +0200
+++ mod/file_contexts/program/zebra.fc	2004-11-12 01:00:09.000000000 +0100
@@ -3,8 +3,8 @@
 /usr/sbin/bgpd		--	system_u:object_r:zebra_exec_t
 /var/log/zebra(/.*)?		system_u:object_r:zebra_log_t
 /etc/zebra(/.*)?		system_u:object_r:zebra_conf_t
-/var/run/.zserv		-s	system_u:object_r:zebra_var_run_t
-/var/run/.zebra		-s	system_u:object_r:zebra_var_run_t
+/var/run/\.zserv	-s	system_u:object_r:zebra_var_run_t
+/var/run/\.zebra	-s	system_u:object_r:zebra_var_run_t
 # Quagga
 /usr/sbin/rip.*  	--	system_u:object_r:zebra_exec_t
 /usr/sbin/ospf.*  	--	system_u:object_r:zebra_exec_t
diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-11-09 08:45:55.000000000 +0100
+++ mod/file_contexts/types.fc	2004-11-12 01:00:09.000000000 +0100
@@ -54,7 +54,7 @@
 HOME_DIR		-d	system_u:object_r:ROLE_home_dir_t
 HOME_DIR/.+			system_u:object_r:ROLE_home_t
=20
-/root/.default_contexts	-- 	system_u:object_r:default_context_t
+/root/\.default_contexts	-- 	system_u:object_r:default_context_t
=20
 #
 # Mount points; do not relabel subdirectories, since
@@ -283,7 +283,7 @@
 /etc/issue		--	system_u:object_r:etc_runtime_t
 /etc/issue\.net		--	system_u:object_r:etc_runtime_t
 /etc/sysconfig/hwconf	--	system_u:object_r:etc_runtime_t
-/etc/sysconfig/iptables.save -- system_u:object_r:etc_runtime_t
+/etc/sysconfig/iptables\.save -- system_u:object_r:etc_runtime_t
 /etc/sysconfig/firstboot --	system_u:object_r:etc_runtime_t
 /etc/asound\.state	--	system_u:object_r:etc_runtime_t
 /etc/ptal/ptal-printd-like -- 	system_u:object_r:etc_runtime_t

--tVmo9FyGdCe4F4YN--

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBk/7ExWIrrrL0q+cRAjFkAJ9O/f6ojGymKnGfuu+KaCdWc9uQ8wCgt9pg
6Th6aGVOm5mT9l6NH6vkIi4=
=ddIt
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
