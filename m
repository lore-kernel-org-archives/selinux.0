Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB7081Ii025362
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 19:08:01 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB7082oX028559
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2004 00:08:03 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 7 Dec 2004 01:08:03 +0100
Date: Tue, 7 Dec 2004 01:08:05 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: add can_create() macro, allow file_type_auto_trans(a,b,c, { file dir })
Message-Id: <20041207000805.GH3678@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5VuzLDXibKSJvVYD
Content-Type: multipart/mixed; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After the boring cleanup stuff, now for something a little bit more
interesting :-)

The goal of the following patch is to allow one to write
file_type_auto_trans(foo_t, var_run_t, foo_var_run_t, { dir file sock_file =
})=20

This makes it much easier to eg lock down /tmp (this will follow later
as a separate patch)

How does it work? The m4 magic inside can_create() parses its last=20
parameter via a regex into separate tokens which it passes to=20
can_create_internal() one by one and recurses over the rest.

The interface to file_type_{,auto_}trans() is unchanged, except that the
fourth parameter can now contain multiple object classes.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="can_create.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/macros/core_macros.te
+++ mod/macros/core_macros.te
@@ -445,6 +445,31 @@
 allow $1 $2:file { rx_file_perms execute_no_trans };
 ')
=20
+# this is an internal macro used by can_create
+define(`can_create_internal', `
+ifelse(`$3', `dir', `
+allow $1 $2:$3 create_dir_perms;
+', `$3', `lnk_file', `
+allow $1 $2:$3 create_lnk_perms;
+', `
+allow $1 $2:$3 create_file_perms;
+')dnl end if dir
+')dnl end can_create_internal
+
+
+#################################
+#
+# can_create(domain, file_type, object_class)
+#
+# Permissions for creating files of the specified type and class
+#
+define(`can_create', `
+ifelse(regexp($3, `\w'), -1, `', `
+can_create_internal($1, $2, regexp($3, `\(\w+\)', `\1'))
+
+can_create($1, $2, regexp($3, `\w+\(.*\)', `\1'))
+')
+')
 #################################
 #
 # file_type_trans(domain, dir_type, file_type)
@@ -463,19 +488,9 @@
 # Allow the process to create the file.
 #
 ifelse(`$4', `', `
-allow $1 $3:{ file sock_file fifo_file } create_file_perms;
-allow $1 $3:lnk_file create_lnk_perms;
-allow $1 $3:dir create_dir_perms;
+can_create($1, $3, `{ file lnk_file sock_file fifo_file dir }')
 ', `
-ifelse(`$4', `dir', `
-allow $1 $3:$4 create_dir_perms;
-', `
-ifelse(`$4', `lnk_file', `
-allow $1 $3:$4 create_lnk_perms;
-', `
-allow $1 $3:$4 create_file_perms;
-')dnl end ifelse lnk_file
-')dnl end if dir
+can_create($1, $3, $4)
 ')dnl end if param 4 specified
=20
 ')
--- orig/macros/program/crontab_macros.te
+++ mod/macros/program/crontab_macros.te
@@ -45,8 +45,7 @@
 dontaudit $1_crontab_t selinux_config_t:dir search;
=20
 # Type for temporary files.
-file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, file)
-file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, dir)
+file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, { dir file })
=20
 # Use the type when creating files in /var/spool/cron.
 allow sysadm_crontab_t $1_cron_spool_t:file { getattr read };

--M0YLxmUXciMpOLPE--

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtPRlxWIrrrL0q+cRAsFIAJ0ZYQTHfXkMPJOBVsUF/EBt75EbhgCeO1L8
uI9VagLRmao8XEsuSVGTuQg=
=MhSP
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
