Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA9KloIi025516
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 15:47:50 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA9Klpsi023471
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 20:47:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 9 Nov 2004 21:47:51 +0100
Date: Tue, 9 Nov 2004 21:47:40 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: file_contexts fixes
Message-Id: <20041109204739.GB2543@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--GZVR6ND4mMseVXL/
Content-Type: multipart/mixed; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached patch fixes some file contexts and adds new ones. It should be
pretty self-explanatory.
The only place where I was not sure was vmware.fc. I just saw that the
old contexts were wrong.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="context_fixes.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/file_contexts/distros.fc mod/file_contexts/distros.fc
--- orig/file_contexts/distros.fc	2004-10-06 22:21:13.000000000 +0200
+++ mod/file_contexts/distros.fc	2004-11-09 21:41:33.000000000 +0100
@@ -32,3 +32,11 @@
 /usr/share/cvs/contrib/rcs2log	--	system_u:object_r:bin_t
 ')
=20
+ifdef(`distro_suse', `
+/var/lib/samba/bin(/.*)?				system_u:object_r:bin_t
+/var/lib/samba/bin/.*\.so(\.[^/]*)*		-l	system_u:object_r:lib_t
+/usr/lib/samba/classic/.*			--	system_u:object_r:bin_t
+/usr/lib/samba/classic/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/success					--	system_u:object_r:etc_runtime_t
+/etc/defkeymap\.map				--	system_u:object_r:etc_runtime_t
+')
diff -urN orig/file_contexts/program/crond.fc mod/file_contexts/program/cro=
nd.fc
--- orig/file_contexts/program/crond.fc	2004-06-19 10:31:43.000000000 +0200
+++ mod/file_contexts/program/crond.fc	2004-11-09 21:41:33.000000000 +0100
@@ -11,7 +11,7 @@
 /var/spool/cron/[^/]*	--	<<none>>
 /var/log/cron.*		--	system_u:object_r:crond_log_t
 /var/run/crond\.reboot	--	system_u:object_r:crond_var_run_t
-/var/run/crond\.pid	--	system_u:object_r:crond_var_run_t
+/var/run/crond?\.pid	--	system_u:object_r:crond_var_run_t
 # fcron
 /usr/sbin/fcron		--	system_u:object_r:crond_exec_t
 /var/spool/fcron	-d	system_u:object_r:cron_spool_t
diff -urN orig/file_contexts/program/cups.fc mod/file_contexts/program/cups=
=2Efc
--- orig/file_contexts/program/cups.fc	2004-10-17 13:07:14.000000000 +0200
+++ mod/file_contexts/program/cups.fc	2004-11-09 21:41:33.000000000 +0100
@@ -18,9 +18,12 @@
 /usr/lib(64)?/cups/backend/.* --	system_u:object_r:cupsd_exec_t
 /usr/lib(64)?/cups/daemon/.*	 --	system_u:object_r:cupsd_exec_t
 /usr/sbin/cupsd		--	system_u:object_r:cupsd_exec_t
+ifdef(`hald.te', `
+# cupsd_config depends on hald
 /usr/bin/cups-config-daemon --	system_u:object_r:cupsd_config_exec_t
 /usr/sbin/hal_lpadmin --	system_u:object_r:cupsd_config_exec_t
 /usr/sbin/printconf-backend --	system_u:object_r:cupsd_config_exec_t
+')
 /var/log/cups(/.*)?		system_u:object_r:cupsd_log_t
 /var/spool/cups(/.*)?		system_u:object_r:print_spool_t
 /var/run/cups/printcap	--	system_u:object_r:cupsd_var_run_t
diff -urN orig/file_contexts/program/hotplug.fc mod/file_contexts/program/h=
otplug.fc
--- orig/file_contexts/program/hotplug.fc	2004-10-19 21:15:26.000000000 +02=
00
+++ mod/file_contexts/program/hotplug.fc	2004-11-09 21:41:33.000000000 +0100
@@ -1,6 +1,7 @@
 # hotplug
 /etc/hotplug(/.*)?		system_u:object_r:hotplug_etc_t
 /sbin/hotplug		--	system_u:object_r:hotplug_exec_t
+/etc/hotplug\.d/.*	--	system_u:object_r:hotplug_exec_t
 /sbin/netplugd		--	system_u:object_r:hotplug_exec_t
 /etc/hotplug.d/default/default.* system_u:object_r:sbin_t
 /etc/netplug.d(/.*)? 	 	system_u:object_r:sbin_t
@@ -8,3 +9,4 @@
 /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
 /etc/hotplug/hotplug.functions --	system_u:object_r:sbin_t
 /var/run/usb(/.*)?		system_u:object_r:hotplug_var_run_t
+/var/run/hotplug(/.*)?		system_u:object_r:hotplug_var_run_t
diff -urN orig/file_contexts/program/ifconfig.fc mod/file_contexts/program/=
ifconfig.fc
--- orig/file_contexts/program/ifconfig.fc	2004-02-02 16:17:23.000000000 +0=
100
+++ mod/file_contexts/program/ifconfig.fc	2004-11-09 21:41:33.000000000 +01=
00
@@ -3,6 +3,7 @@
 /sbin/iwconfig		--	system_u:object_r:ifconfig_exec_t
 /sbin/ip		--	system_u:object_r:ifconfig_exec_t
 /sbin/tc		--	system_u:object_r:ifconfig_exec_t
+/usr/sbin/tc		--	system_u:object_r:ifconfig_exec_t
 /bin/ip			--	system_u:object_r:ifconfig_exec_t
 /sbin/ethtool		--	system_u:object_r:ifconfig_exec_t
 /sbin/mii-tool		--	system_u:object_r:ifconfig_exec_t
diff -urN orig/file_contexts/program/inetd.fc mod/file_contexts/program/ine=
td.fc
--- orig/file_contexts/program/inetd.fc	2004-09-11 14:31:47.000000000 +0200
+++ mod/file_contexts/program/inetd.fc	2004-11-09 21:41:33.000000000 +0100
@@ -6,3 +6,4 @@
 /usr/sbin/in\..*d	--	system_u:object_r:inetd_child_exec_t
 /usr/sbin/stunnel	--	system_u:object_r:inetd_child_exec_t
 /var/log/(x)?inetd\.log	--	system_u:object_r:inetd_log_t
+/var/run/inetd\.pid	--	system_u:object_r:inetd_var_run_t
diff -urN orig/file_contexts/program/ssh.fc mod/file_contexts/program/ssh.fc
--- orig/file_contexts/program/ssh.fc	2004-10-17 13:07:14.000000000 +0200
+++ mod/file_contexts/program/ssh.fc	2004-11-09 21:41:33.000000000 +0100
@@ -8,6 +8,7 @@
 /etc/ssh/ssh_host_rsa_key --	system_u:object_r:sshd_key_t
 /usr/sbin/sshd	        --	system_u:object_r:sshd_exec_t
 HOME_DIR/\.ssh(/.*)?		system_u:object_r:ROLE_home_ssh_t
+/var/run/sshd\.init\.pid	--	system_u:object_r:sshd_var_run_t
 # subsystems
 /usr/lib(64)?/misc/sftp-server --	system_u:object_r:bin_t
 /usr/libexec/openssh/sftp-server -- system_u:object_r:bin_t
diff -urN orig/file_contexts/program/syslogd.fc mod/file_contexts/program/s=
yslogd.fc
--- orig/file_contexts/program/syslogd.fc	2003-11-26 19:01:08.000000000 +01=
00
+++ mod/file_contexts/program/syslogd.fc	2004-11-09 21:41:33.000000000 +0100
@@ -5,4 +5,7 @@
 /sbin/syslog-ng		--	system_u:object_r:syslogd_exec_t
 /dev/log		-s	system_u:object_r:devlog_t
 /var/run/log		-s	system_u:object_r:devlog_t
+ifdef(`distro_suse', `
+/var/lib/stunnel/dev/log	-s	system_u:object_r:devlog_t
+')
 /var/run/syslogd\.pid	--	system_u:object_r:syslogd_var_run_t
diff -urN orig/file_contexts/program/vmware.fc mod/file_contexts/program/vm=
ware.fc
--- orig/file_contexts/program/vmware.fc	2004-09-25 19:52:50.000000000 +0200
+++ mod/file_contexts/program/vmware.fc	2004-11-09 21:42:51.000000000 +0100
@@ -38,5 +38,5 @@
 # ~/vmware, and the preferences and license files are in ~/.vmware.
 #
 HOME_DIR/\.vmware(/.*)?	system_u:object_r:ROLE_vmware_file_t
-HOME_DIR/\vmware(/.*)?	system_u:object_r:ROLE_vmware_file_t
-HOME_DIR/\vmware[^/]*/.*\.cfg	--	system_u:object_r:ROLE_vmware_conf_t
+HOME_DIR/vmware(/.*)?	system_u:object_r:ROLE_vmware_file_t
+HOME_DIR/\.vmware[^/]*/.*\.cfg	--	system_u:object_r:ROLE_vmware_conf_t
diff -urN orig/file_contexts/program/xdm.fc mod/file_contexts/program/xdm.fc
--- orig/file_contexts/program/xdm.fc	2004-09-15 19:01:07.000000000 +0200
+++ mod/file_contexts/program/xdm.fc	2004-11-09 21:42:27.000000000 +0100
@@ -16,7 +16,11 @@
 /etc/X11/[wx]dm/Xsession	--	system_u:object_r:xsession_exec_t
 /etc/kde/kdm/Xsession	--	system_u:object_r:xsession_exec_t
 /var/run/xdmctl(/.*)?		system_u:object_r:xdm_var_run_t
+/var/run/xdm\.pid	--	system_u:object_r:xdm_var_run_t
 /var/lib/[xkw]dm(/.*)?		system_u:object_r:xdm_var_lib_t
+ifdef(`distro_suse', `
+/var/lib/pam_devperm/:0	--	system_u:object_r:xdm_var_lib_t
+')
 /usr/lib/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t
=20
 #
diff -urN orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-11-09 08:45:55.000000000 +0100
+++ mod/file_contexts/types.fc	2004-11-09 21:41:33.000000000 +0100
@@ -260,6 +260,7 @@
 /opt/.*/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /opt/.*/libexec(/.*)?	system_u:object_r:bin_t
 /opt/.*/bin(/.*)?		system_u:object_r:bin_t
+/opt/.*/sbin(/.*)?		system_u:object_r:sbin_t
 /opt/.*/man(/.*)?		system_u:object_r:man_t
 /opt/.*/var/lib(64)?(/.*)?		system_u:object_r:var_lib_t
=20
@@ -380,6 +381,7 @@
 /var/lib/msttcorefonts(/.*)?		system_u:object_r:fonts_t
 ')
 /usr/share/fonts(/.*)?			system_u:object_r:fonts_t
+/usr/share/ghostscript/fonts(/.*)?	system_u:object_r:fonts_t
 /usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
=20
 #
@@ -451,6 +453,6 @@
=20
 #
 #  The krb5.conf file is always being tested for writability, so
-#  we defined a type to dontautit
+#  we defined a type to dontaudit
 #
 /etc/krb5\.conf		--	system_u:object_r:krb5_conf_t

--uZ3hkaAS1mZxFaxD--

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkSzrxWIrrrL0q+cRArZMAKCjL0nBbbrwdRcm52fNgktixjUmzQCfVO/6
QYp0eY86ZCd7ANvSjqMZfQg=
=Zy5w
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
