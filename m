Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GJZprT001479
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 15:35:53 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GJZSbx002077
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 19:35:29 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 16 Jul 2004 21:35:39 +0200
Date: Fri, 16 Jul 2004 21:35:18 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: nfs policy fixes
Message-Id: <20040716193517.GA4940@obadja.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ADZbWkCsHQ7r3kzd
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds some permissions for nfs homedirs. It only adds
permissions which were already there for non-nfs homedirs.
Additionally it dontaudits a small denial in gpg_macros.te.

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfs-fixes.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/macros/program/gpg_macros.te
+++ mod/macros/program/gpg_macros.te
@@ -34,7 +34,7 @@
 can_network($1_gpg_t)
=20
 # for a bug in kmail
-dontaudit $1_gpg_t $1_t:unix_stream_socket { read write };
+dontaudit $1_gpg_t $1_t:unix_stream_socket { getattr read write };
=20
 # The user role is authorized for this domain.
 role $1_r types $1_gpg_t;
@@ -84,6 +84,10 @@
 # allow the usual access to /tmp
 file_type_auto_trans($1_gpg_t, tmp_t, $1_tmp_t)
=20
+ifdef(`nfs_home_dirs', `
+create_dir_file($1_gpg_t, nfs_t)
+')dnl end if nfs_home_dirs
+
 allow $1_gpg_t self:capability { ipc_lock setuid };
 allow $1_gpg_t devtty_t:chr_file rw_file_perms;
=20
--- orig/macros/program/lpr_macros.te
+++ mod/macros/program/lpr_macros.te
@@ -79,6 +79,9 @@
 allow sysadm_lpr_t $1_home_t:{ file lnk_file } r_file_perms; =20
 allow $1_lpr_t { home_root_t $1_home_t $1_home_dir_t }:dir search; =20
 allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms; =20
+ifdef(`nfs_home_dirs', `
+r_dir_file($1_lpr_t, nfs_t)
+')dnl end if nfs_home_dirs
=20
 # Read and write shared files in the spool directory.
 allow $1_lpr_t print_spool_t:file rw_file_perms;
--- orig/macros/program/mta_macros.te
+++ mod/macros/program/mta_macros.te
@@ -95,6 +95,9 @@
=20
 # Create dead.letter in user home directories.
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t, file)
+ifdef(`nfs_home_dirs', `
+rw_dir_create_file($1_mail_t, nfs_t)
+')dnl end if nfs_home_dirs
=20
 # if you do not want to allow dead.letter then use the following instead
 #allow $1_mail_t { $1_home_dir_t $1_home_t }:dir r_dir_perms;
--- orig/macros/program/screen_macros.te
+++ mod/macros/program/screen_macros.te
@@ -50,6 +50,9 @@
 allow $1_screen_t $1_home_screen_t:{ file lnk_file } r_file_perms;
 allow $1_t $1_home_screen_t:{ file lnk_file } create_file_perms;
 allow $1_t $1_home_screen_t:{ file lnk_file } { relabelfrom relabelto };
+ifdef(`nfs_home_dirs', `
+r_dir_file($1_screen_t, nfs_t)
+')dnl end if nfs_home_dirs
=20
 allow $1_screen_t privfd:fd use;
=20

--Kj7319i9nmIyA2yE--

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+C31xWIrrrL0q+cRAn4IAKCN26kyUzsdc28VPvpOFxroeVPQjgCdEEPk
9ZxRG1O/iOg2NPlm0jqS1Ug=
=EvGW
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
