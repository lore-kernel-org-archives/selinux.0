Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6NgMIi025170
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 18:42:22 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB6NgOoX027895
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 23:42:24 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 7 Dec 2004 00:42:24 +0100
Date: Tue, 7 Dec 2004 00:42:26 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: suse stuff
Message-Id: <20041206234226.GF3678@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4LFBTxd4L5NLO6ly
Content-Type: multipart/mixed; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch corrects some issues from a previous patch. I looked over the
acpi package again and noted that the /var/lib/acpi stuff was added by
SuSE and is not included upstream. Thus the ifdefs.
It also corrects the labeling in a few places.
Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="suse.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/ldconfig.te mod/domains/program/ldconfig.te
--- orig/domains/program/ldconfig.te	2004-12-04 00:46:49.000000000 +0100
+++ mod/domains/program/ldconfig.te	2004-12-07 00:27:15.000000000 +0100
@@ -26,6 +26,7 @@
 allow ldconfig_t lib_t:lnk_file create_lnk_perms;
=20
 allow ldconfig_t userdomain:fd use;
+# unlink for when /etc/ld.so.cache is mislabeled
 allow ldconfig_t etc_t:file { getattr read unlink };
 allow ldconfig_t etc_t:lnk_file read;
=20
@@ -39,7 +40,7 @@
=20
 ifdef(`distro_suse', `
 # because of libraries in /var/lib/samba/bin
-allow ldconfig_t { var_lib_t bin_t }:dir search;
+allow ldconfig_t { var_t var_lib_t }:dir search;
 ')
=20
 allow ldconfig_t proc_t:file read;
diff -ur orig/domains/program/unused/apmd.te mod/domains/program/unused/apm=
d.te
--- orig/domains/program/unused/apmd.te	2004-11-20 10:04:13.000000000 +0100
+++ mod/domains/program/unused/apmd.te	2004-12-07 00:27:15.000000000 +0100
@@ -45,7 +45,9 @@
 # acpid also has a logfile
 log_domain(apmd)
=20
+ifdef(`distro_suse', `
 var_lib_domain(apmd)
+')
=20
 allow apmd_t self:file { getattr read ioctl };
 allow apmd_t self:process getsession;
diff -ur orig/file_contexts/distros.fc mod/file_contexts/distros.fc
--- orig/file_contexts/distros.fc	2004-12-04 00:46:50.000000000 +0100
+++ mod/file_contexts/distros.fc	2004-12-07 00:27:15.000000000 +0100
@@ -37,7 +37,7 @@
 ')
=20
 ifdef(`distro_suse', `
-/var/lib/samba/bin(/.*)?				system_u:object_r:bin_t
+/var/lib/samba/bin/.+					system_u:object_r:bin_t
 /var/lib/samba/bin/.*\.so(\.[^/]*)*		-l	system_u:object_r:lib_t
 /usr/lib/samba/classic/.*			--	system_u:object_r:bin_t
 /usr/lib/samba/classic/[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
diff -ur orig/file_contexts/program/apache.fc mod/file_contexts/program/apa=
che.fc
--- orig/file_contexts/program/apache.fc	2004-12-04 00:46:50.000000000 +0100
+++ mod/file_contexts/program/apache.fc	2004-12-07 00:27:15.000000000 +0100
@@ -29,14 +29,14 @@
 /var/lib/httpd(/.*)?		system_u:object_r:httpd_var_lib_t
 /var/lib/php/session(/.*)?	system_u:object_r:httpd_var_run_t
 /etc/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_config_t
-/usr/lib/apache-ssl(/.*)? --	system_u:object_r:httpd_exec_t
+/usr/lib/apache-ssl/.+ --	system_u:object_r:httpd_exec_t
 /usr/sbin/apache-ssl(2)? --	system_u:object_r:httpd_exec_t
 /var/log/apache-ssl(2)?(/.*)?	system_u:object_r:httpd_log_t
 /var/run/apache-ssl(2)?\.pid.* -- system_u:object_r:httpd_var_run_t
 /var/run/gcache_port	-s	system_u:object_r:httpd_var_run_t
 ifdef(`distro_suse', `
 # suse puts shell scripts there :-(
-/usr/share/apache2/.*	--	system_u:object_r:bin_t
+/usr/share/apache2/[^/]*	--	system_u:object_r:bin_t
 ')
 /var/lib/squirrelmail/prefs(/.*)?	system_u:object_r:httpd_squirrelmail_t
 /usr/bin/htsslpass --	system_u:object_r:httpd_helper_exec_t
diff -ur orig/file_contexts/program/apmd.fc mod/file_contexts/program/apmd.=
fc
--- orig/file_contexts/program/apmd.fc	2004-11-20 10:04:13.000000000 +0100
+++ mod/file_contexts/program/apmd.fc	2004-12-07 00:28:04.000000000 +0100
@@ -5,4 +5,7 @@
 /var/run/apmd\.pid	--	system_u:object_r:apmd_var_run_t
 /var/run/\.?acpid\.socket	-s	system_u:object_r:apmd_var_run_t
 /var/log/acpid		--	system_u:object_r:apmd_log_t
+ifdef(`distro_suse', `
 /var/lib/acpi(/.*)?		system_u:object_r:apmd_var_lib_t
+')
+

--Wtrm9ATX0sn6fFKv--

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtO5ixWIrrrL0q+cRAonaAJ0Uqp0WL2oXJDo1q8pPXbOdVw7UQgCgtQv+
ZpLNb0vzmNl3mJOlgeq+aNM=
=MJRc
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
