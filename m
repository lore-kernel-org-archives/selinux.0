Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GKFtrT001790
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 16:15:55 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GKFVbx003778
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 20:15:32 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 16 Jul 2004 22:15:53 +0200
Date: Fri, 16 Jul 2004 22:15:31 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: file_contexts patch
Message-Id: <20040716201531.GB4940@obadja.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Xm/fll+QQv+hsKip
Content-Type: multipart/mixed; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch adds some file_contexts and most importantly labels
libs under /opt correctly.

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="file_contexts.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/file_contexts/program/hotplug.fc mod/file_contexts/program/h=
otplug.fc
--- orig/file_contexts/program/hotplug.fc	2004-06-19 10:31:43.000000000 +02=
00
+++ mod/file_contexts/program/hotplug.fc	2004-07-16 22:10:08.000000000 +0200
@@ -5,4 +5,5 @@
 /etc/hotplug/.*agent	--	system_u:object_r:sbin_t
 /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
 /etc/hotplug/hotplug.functions --	system_u:object_r:sbin_t
+/var/run/usb(/.*)?		system_u:object_r:hotplug_var_run_t
=20
diff -urN orig/file_contexts/program/screensaver.fc mod/file_contexts/progr=
am/screensaver.fc
--- orig/file_contexts/program/screensaver.fc	2004-05-24 00:55:04.000000000=
 +0200
+++ mod/file_contexts/program/screensaver.fc	2004-07-16 22:10:08.000000000 =
+0200
@@ -1,5 +1,7 @@
 # screensaver
 /usr/X11R6/bin/xscreensaver		--	system_u:object_r:screensaver_exec_t
-/usr/X11R6/bin/xscreensaver-demo		--	system_u:object_r:screensaver_exec_t
+/usr/X11R6/bin/xscreensaver-demo	--      system_u:object_r:screensaver_exe=
c_t
+/opt/kde3/bin/kdesktop_lock		--	system_u:object_r:screensaver_exec_t
+/usr/bin/kdesktop_lock			--	system_u:object_r:screensaver_exec_t
 /usr/X11R6/lib(64)?/xscreensaver(.*)?	system_u:object_r:bin_t
 HOME_DIR/\.xscreensaver	system_u:object_r:ROLE_screensaver_rw_t
diff -urN orig/file_contexts/program/xdm.fc mod/file_contexts/program/xdm.fc
--- orig/file_contexts/program/xdm.fc	2004-06-19 10:31:44.000000000 +0200
+++ mod/file_contexts/program/xdm.fc	2004-07-16 22:12:17.000000000 +0200
@@ -17,7 +17,7 @@
 /etc/kde/kdm/Xsession	--	system_u:object_r:xsession_exec_t
 /var/run/xdmctl(/.*)?		system_u:object_r:xdm_var_run_t
 /var/run/console.*		system_u:object_r:xdm_var_run_t
-/var/lib/[kw]dm(/.*)?		system_u:object_r:xdm_var_lib_t
+/var/lib/[xkw]dm(/.*)?		system_u:object_r:xdm_var_lib_t
 /usr/lib/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t
=20
 #
diff -urN orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-07-12 23:41:14.000000000 +0200
+++ mod/file_contexts/types.fc	2004-07-16 22:10:08.000000000 +0200
@@ -177,6 +177,7 @@
 /u?dev/input/event.*	-c	system_u:object_r:event_device_t
 /u?dev/input/mice	-c	system_u:object_r:mouse_device_t
 /u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
+/u?dev/js.*		-c	system_u:object_r:mouse_device_t
 /u?dev/ptmx		-c	system_u:object_r:ptmx_t
 /u?dev/sequencer	-c	system_u:object_r:misc_device_t
 /u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
@@ -207,6 +208,7 @@
 /u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
 /u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
 /u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
+/u?dev/usbscanner	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
@@ -220,7 +222,10 @@
 /opt(/.*)?			system_u:object_r:usr_t
 /opt/[^/]*/bin(/.*)?		system_u:object_r:bin_t
 /opt/[^/]*/lib(/.*)?		system_u:object_r:lib_t
+/opt/[^/]*/lib/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/opt/[^/]*/lib/.*/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /opt/[^/]*/man(/.*)?		system_u:object_r:man_t
+/opt/[^/]*/libexec(/.*)?	system_u:object_r:bin_t
=20
 #
 # /etc

--YD3LsXFS42OYHhNZ--

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+DdjxWIrrrL0q+cRAgmsAKClqb7nZhubhYRA0oeO/ykmmPmUZACgwNbx
0wRapdKY4cSX1M82SWGGt4Y=
=i7cw
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
