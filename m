Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UGVMDo016064
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 11:31:22 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UGRWph023379
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:27:32 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 30 Mar 2005 18:30:11 +0200
Date: Wed, 30 Mar 2005 18:30:12 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: Use etc_domain() where possible
Message-Id: <20050330163011.GC5791@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vA66WO2vHvL/CRSR
Content-Type: multipart/mixed; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch uses etc_domain() where possible and makes type-names more
consistent on the way.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup_etc.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/domains/program/unused/monopd.te mod/domains/program/unused/m=
onopd.te
--- orig/domains/program/unused/monopd.te	2004-12-04 00:46:50.000000000 +01=
00
+++ mod/domains/program/unused/monopd.te	2005-03-18 01:16:34.558466168 +0100
@@ -10,9 +10,11 @@
 # Rules for the monopd_t domain.
 #
 daemon_domain(monopd)
+etc_domain(monopd)
+typealias monopd_etc_t alias etc_monopd_t;
=20
-type etc_monopd_t, file_type, sysadmfile;
-type share_monopd_t, file_type, sysadmfile;
+type monopd_share_t, file_type, sysadmfile;
+typealias share_monopd_t alias share_monopd_t;
=20
 # Use the network.
 can_network_server(monopd_t)
@@ -21,7 +23,6 @@
 type monopd_port_t, port_type;
 allow monopd_t monopd_port_t:tcp_socket name_bind;
=20
-r_dir_file(monopd_t,etc_monopd_t)
 r_dir_file(monopd_t,share_monopd_t)
=20
 allow monopd_t self:unix_dgram_socket create_socket_perms;
diff -ur orig/domains/program/unused/uptimed.te mod/domains/program/unused/=
uptimed.te
--- orig/domains/program/unused/uptimed.te	2004-02-02 17:58:19.000000000 +0=
100
+++ mod/domains/program/unused/uptimed.te	2005-03-18 01:19:19.911328712 +01=
00
@@ -10,7 +10,6 @@
 # General Types
 #
=20
-type etc_uptimed_t, file_type, sysadmfile;
 type uptimed_spool_t, file_type, sysadmfile;
=20
 #################################
@@ -18,8 +17,10 @@
 # Rules for the uptimed_t domain.
 #
 daemon_domain(uptimed, `,privmail')
+etc_domain(uptimed)
+typealias uptimed_etc_t alias etc_uptimed_t;
 file_type_auto_trans(uptimed_t, var_spool_t, uptimed_spool_t)
-allow uptimed_t { etc_uptimed_t proc_t }:file { getattr read };
+allow uptimed_t proc_t:file { getattr read };
 read_locale(uptimed_t)
 allow uptimed_t uptimed_spool_t:file create_file_perms;
 allow uptimed_t self:unix_dgram_socket create_socket_perms;
Nur in mod/file_contexts: file_contexts.
Nur in mod/file_contexts: homedir_template.
Nur in mod/file_contexts: misc.
diff -ur orig/file_contexts/program/monopd.fc mod/file_contexts/program/mon=
opd.fc
--- orig/file_contexts/program/monopd.fc	2004-11-19 09:23:17.000000000 +0100
+++ mod/file_contexts/program/monopd.fc	2005-03-18 01:16:46.987576656 +0100
@@ -1,4 +1,4 @@
 # monopd
-/etc/monopd\.conf	--	system_u:object_r:etc_monopd_t
+/etc/monopd\.conf	--	system_u:object_r:monopd_etc_t
 /usr/sbin/monopd	--	system_u:object_r:monopd_exec_t
-/usr/share/monopd/games(/.*)?	system_u:object_r:share_monopd_t
+/usr/share/monopd/games(/.*)?	system_u:object_r:monopd_share_t
diff -ur orig/file_contexts/program/uptimed.fc mod/file_contexts/program/up=
timed.fc
--- orig/file_contexts/program/uptimed.fc	2004-11-19 09:23:18.000000000 +01=
00
+++ mod/file_contexts/program/uptimed.fc	2005-03-18 01:19:38.849449680 +0100
@@ -1,4 +1,4 @@
 # uptimed
-/etc/uptimed\.conf	--	system_u:object_r:etc_uptimed_t
+/etc/uptimed\.conf	--	system_u:object_r:uptimed_etc_t
 /usr/sbin/uptimed	--	system_u:object_r:uptimed_exec_t
 /var/spool/uptimed(/.*)?        system_u:object_r:uptimed_spool_t
Nur in mod: tmp.

--so9zsI5B81VjUb/o--

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCStQTD9qpeVMU938RAuYdAJ4wRkH1VVA0lx4ZDeXOUoVJGLfe3gCeNp5w
6dJMargnnt1lAdIe5oDx5W4=
=mI+f
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
