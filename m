Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i958SFrT024421
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 04:28:15 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i958SD7h015286
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 08:28:14 GMT
Message-ID: <41625B74.2090503@gentoo.org>
Date: Tue, 05 Oct 2004 11:29:40 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for mysqld
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3BAB3C63BE6C877C459E56A3"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BAB3C63BE6C877C459E56A3
Content-Type: multipart/mixed;
 boundary="------------030503040801040700000600"

This is a multi-part message in MIME format.
--------------030503040801040700000600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

attached you'll find a diff for the mysql policy.
you might want to use the tmp_domain() for other distros as well (see the reference)

reference:
http://bugs.gentoo.org/show_bug.cgi?id=48772

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------030503040801040700000600
Content-Type: text/plain;
 name="mysql.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mysql.diff"

--- /root/public_html/policy/nsa/file_contexts/program/mysqld.fc	2004-08-22 16:20:06.000000000 +0300
+++ /etc/security/selinux/src/policy/file_contexts/program/mysqld.fc	2004-10-05 04:36:41.722539464 +0300
@@ -3,7 +3,7 @@
 /usr/libexec/mysqld	--	system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
-/var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
+/var/lib(64)?/mysql(/.*)?	system_u:object_r:mysqld_db_t
 /var/lib/mysql/mysql.sock -s	system_u:object_r:mysqld_var_run_t
 /etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
 /etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t
--- /root/public_html/policy/nsa/domains/program/unused/mysqld.te	2004-08-30 23:35:32.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/mysqld.te	2004-10-05 04:46:34.766383096 +0300
@@ -57,10 +57,6 @@
 
 can_unix_connect(sysadm_t, mysqld_t)
 
-# for /root/.my.cnf - should not be needed
-allow mysqld_t sysadm_home_dir_t:dir search;
-allow mysqld_t sysadm_home_t:file { read getattr };
-
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, mysqld_etc_t)
 allow logrotate_t mysqld_db_t:dir search;
@@ -80,3 +76,20 @@
 # because Fedora has the sock_file in the database directory
 file_type_auto_trans(mysqld_t, mysqld_db_t, mysqld_var_run_t, sock_file)
 ')
+
+ifdef(`distro_gentoo', `
+# temporary tables (#sql prefix)
+tmp_domain(mysqld)
+
+# if controled by daemontools
+ifdef(`daemontools.te', `
+domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
+allow svc_start_t mysqld_t:process signal;
+svc_ipc_domain(mysqld_t)
+')dnl end ifdef daemontools
+',`
+# for /root/.my.cnf - should not be needed
+allow mysqld_t sysadm_home_dir_t:dir search;
+allow mysqld_t sysadm_home_t:file { read getattr };
+')dnl end ifdef distro_gentoo
+ 

--------------030503040801040700000600--

--------------enig3BAB3C63BE6C877C459E56A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBYlt0GSBEIeh4AEYRAvOzAJ9c+XKyZI/JIqKUfRZM7Hc9KRCPBgCaA9av
fg4x+jEbizmqI7xTHxq4QSE=
=PDyt
-----END PGP SIGNATURE-----

--------------enig3BAB3C63BE6C877C459E56A3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
