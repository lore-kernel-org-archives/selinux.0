Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HDVIi013976
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:13:32 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HDYEj000884
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:13:35 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 18:13:33 +0100
Date: Thu, 9 Dec 2004 18:13:34 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: stricter /tmp handling
Message-Id: <20041209171333.GD5074@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Pd0ReVV5GZGQvF3a
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patches uses my latest changes to file_type_auto_trans() to make
/tmp more strict.
Right now, any process with tmp_domain() can create any file type under
/tmp except chr_file and blk_file. But most domains only need file and
dir.
This patch changes tmp_domain() so that normally, only file and dir
access is allowed. It also adds a third parameter to the macro, so
domains which need more access can get it.
I have run this patch for a few weeks on all my machines so most things
should work, but I don't have any server machines running SELinux ATM,
so some daemons probably need additional permissions.
This patch also removes the tmpfile attribute from tetex_data_t, since
these are not really tmpfiles.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tmp_domain.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/ssh.te mod/domains/program/ssh.te
--- orig/domains/program/ssh.te	2004-11-18 09:57:21.000000000 +0100
+++ mod/domains/program/ssh.te	2004-12-09 17:57:30.000000000 +0100
@@ -203,7 +203,7 @@
 # so a tunnel can point to another ssh tunnel...
 can_tcp_connect(sshd_t, sshd_t)
=20
-tmp_domain(sshd)
+tmp_domain(sshd, `', { dir file sock_file })
 ifdef(`pam.te', `
 can_exec(sshd_t, pam_exec_t)
 ')
diff -urN orig/domains/program/unused/kudzu.te mod/domains/program/unused/k=
udzu.te
--- orig/domains/program/unused/kudzu.te	2004-12-09 17:05:15.000000000 +0100
+++ mod/domains/program/unused/kudzu.te	2004-12-09 17:57:30.000000000 +0100
@@ -84,8 +84,7 @@
 allow kudzu_t sysfs_t:lnk_file read;
 file_type_auto_trans(kudzu_t, etc_t, etc_runtime_t, file)
 allow kudzu_t tape_device_t:chr_file r_file_perms;
-tmp_domain(kudzu)
-file_type_auto_trans(kudzu_t, tmp_t, kudzu_tmp_t, chr_file)
+tmp_domain(kudzu, `', `{ file dir chr_file }')
=20
 # for file systems that are not yet mounted
 dontaudit kudzu_t file_t:dir search;
diff -urN orig/domains/program/unused/postgresql.te mod/domains/program/unu=
sed/postgresql.te
--- orig/domains/program/unused/postgresql.te	2004-12-04 00:46:50.000000000=
 +0100
+++ mod/domains/program/unused/postgresql.te	2004-12-09 17:57:30.000000000 =
+0100
@@ -48,7 +48,7 @@
 system_crond_entry(postgresql_exec_t, postgresql_t)
 ')
=20
-tmp_domain(postgresql);
+tmp_domain(postgresql, `', `{ dir file sock_file }')
 file_type_auto_trans(postgresql_t, tmpfs_t, postgresql_tmp_t)
=20
 # Use the network.
diff -urN orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm=
=2Ete
--- orig/domains/program/unused/xdm.te	2004-11-20 10:04:13.000000000 +0100
+++ mod/domains/program/unused/xdm.te	2004-12-09 17:57:30.000000000 +0100
@@ -31,7 +31,7 @@
 file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file)
 file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, dir)
=20
-tmp_domain(xdm)
+tmp_domain(xdm, `', `{ file dir sock_file }')
 var_lib_domain(xdm)
 # NB we do NOT allow xdm_xserver_t xdm_var_lib_t:dir, only access to an op=
en
 # handle of a file inside the dir!!!
diff -urN orig/domains/program/unused/xfs.te mod/domains/program/unused/xfs=
=2Ete
--- orig/domains/program/unused/xfs.te	2004-10-17 13:07:14.000000000 +0200
+++ mod/domains/program/unused/xfs.te	2004-12-09 17:57:30.000000000 +0100
@@ -20,7 +20,7 @@
 allow xfs_t tmp_t:dir search;
 file_type_auto_trans(xfs_t, initrc_tmp_t, xfs_tmp_t, sock_file)
 ', `
-tmp_domain(xfs)
+tmp_domain(xfs, `', sock_file)
 ')
=20
 allow xfs_t { etc_t etc_runtime_t }:file { getattr read };
diff -urN orig/domains/program/unused/zebra.te mod/domains/program/unused/z=
ebra.te
--- orig/domains/program/unused/zebra.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/domains/program/unused/zebra.te	2004-12-09 17:57:30.000000000 +0100
@@ -20,8 +20,7 @@
 logdir_domain(zebra)
=20
 # /tmp/.bgpd is such a bad idea!
-type zebra_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(zebra_t, tmp_t, zebra_tmp_t, sock_file)
+tmp_domain(zebra, `', sock_file)
=20
 allow zebra_t self:unix_dgram_socket create_socket_perms;
 allow zebra_t self:unix_stream_socket { connectto create_stream_socket_per=
ms };
diff -urN orig/macros/admin_macros.te mod/macros/admin_macros.te
--- orig/macros/admin_macros.te	2004-12-04 00:46:50.000000000 +0100
+++ mod/macros/admin_macros.te	2004-12-09 17:57:30.000000000 +0100
@@ -22,7 +22,7 @@
 # Type and access for pty devices.
 can_create_pty($1)
=20
-tmp_domain($1)
+tmp_domain($1, `, $1_file_type', `{ file dir lnk_file sock_file fifo_file =
}')
=20
 # Type for tty devices.
 type $1_tty_device_t, sysadmfile, ttyfile, dev_fs;
diff -urN orig/macros/global_macros.te mod/macros/global_macros.te
--- orig/macros/global_macros.te	2004-12-09 17:05:15.000000000 +0100
+++ mod/macros/global_macros.te	2004-12-09 17:59:50.000000000 +0100
@@ -396,10 +396,14 @@
 allow $2_t device_t:dir getattr;
 ')
=20
-
+# grant access to /tmp
+# by default, only plain files and dirs may be stored there.
+# This can be overridden with a third parameter
 define(`tmp_domain', `
 type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
-file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
+ifelse($3, `',
+`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `{ file dir }')',
+`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `$3')')
 ')
=20
 define(`tmpfs_domain', `
diff -urN orig/macros/program/gpg_agent_macros.te mod/macros/program/gpg_ag=
ent_macros.te
--- orig/macros/program/gpg_agent_macros.te	2004-11-20 10:04:13.000000000 +=
0100
+++ mod/macros/program/gpg_agent_macros.te	2004-12-09 17:58:59.000000000 +0=
100
@@ -56,7 +56,7 @@
 allow $1_gpg_agent_t self:fifo_file { getattr read write };
=20
 # create /tmp files
-tmp_domain($1_gpg_agent)
+tmp_domain($1_gpg_agent, `', `{ file dir sock_file }')
=20
 # gpg connect
 allow $1_gpg_t $1_gpg_agent_tmp_t:dir search;
diff -urN orig/macros/program/screen_macros.te mod/macros/program/screen_ma=
cros.te
--- orig/macros/program/screen_macros.te	2004-11-30 16:19:26.000000000 +0100
+++ mod/macros/program/screen_macros.te	2004-12-09 17:57:30.000000000 +0100
@@ -27,7 +27,7 @@
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
=20
-tmp_domain($1_screen)
+tmp_domain($1_screen, `', `{ dir file fifo_file }')
 base_file_read_access($1_screen_t)
 # The user role is authorized for this domain.
 role $1_r types $1_screen_t;
diff -urN orig/macros/program/xserver_macros.te mod/macros/program/xserver_=
macros.te
--- orig/macros/program/xserver_macros.te	2004-12-04 00:46:50.000000000 +01=
00
+++ mod/macros/program/xserver_macros.te	2004-12-09 17:57:30.000000000 +0100
@@ -138,7 +138,7 @@
 allow $1_xserver_t zero_device_t:chr_file { read write execute };
=20
 # Type for temporary files.
-tmp_domain($1_xserver)
+tmp_domain($1_xserver, `', `{ dir file sock_file }')
 file_type_auto_trans($1_xserver_t, xdm_xserver_tmp_t, $1_xserver_tmp_t, so=
ck_file)
=20
 ifelse($1, xdm, `
diff -urN orig/macros/user_macros.te mod/macros/user_macros.te
--- orig/macros/user_macros.te	2004-12-09 17:05:15.000000000 +0100
+++ mod/macros/user_macros.te	2004-12-09 17:57:30.000000000 +0100
@@ -21,7 +21,7 @@
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_=
home_dir_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_=
type;
=20
-tmp_domain($1, `, user_tmpfile, $1_file_type')
+tmp_domain($1, `, user_tmpfile, $1_file_type', `{ file lnk_file dir sock_f=
ile fifo_file }')
=20
 # Type and access for pty devices.
 can_create_pty($1, `, userpty_type, user_tty_type')
diff -urN orig/types/file.te mod/types/file.te
--- orig/types/file.te	2004-12-04 00:46:51.000000000 +0100
+++ mod/types/file.te	2004-12-09 17:57:30.000000000 +0100
@@ -178,7 +178,7 @@
 type var_lock_t, file_type, sysadmfile, lockfile;
 type var_lib_t, file_type, sysadmfile;
 # for /var/{spool,lib}/texmf index files
-type tetex_data_t, file_type, sysadmfile, tmpfile;
+type tetex_data_t, file_type, sysadmfile;
 type var_spool_t, file_type, sysadmfile;
 type var_yp_t, file_type, sysadmfile;
=20

--6c2NcOVqGQ03X4Wi--

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuIe9xWIrrrL0q+cRAr6aAKCubQxpHFPPFaT7+dBNlXTNGokYoACeLzrE
LQni8RTw6Kqd6Lcoc5ijE6s=
=vbAG
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
