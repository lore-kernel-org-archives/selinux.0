Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MLBDgi005983
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 17:11:13 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MLBCT1021870
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 21:11:12 GMT
Received: by nf-out-0910.google.com with SMTP id b21so915804nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 14:11:11 -0700 (PDT)
Subject: [refpolicy patch]  mozilla replace local policy by interface calls.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CokFjX/MSpa77yW2+81L"
Date: Tue, 22 Jul 2008 23:11:08 +0200
Message-Id: <1216761068.26661.15.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CokFjX/MSpa77yW2+81L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch replaces local policy by interface calls

Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozilla.=
if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozilla.if	=
(revision 2762)
+++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozilla.if	=
(working copy)
@@ -78,10 +78,9 @@
 	userdom_search_user_home_dirs($1,$1_mozilla_t)
=20
 	# Mozpluggerrc
-	allow $1_mozilla_t mozilla_conf_t:file read_file_perms;
+	read_files_pattern($1_mozilla_t, mozilla_conf_t, mozilla_conf_t)
=20
 	allow $1_mozilla_t $2:fd use;
-	allow $1_mozilla_t $2:process sigchld;
 	allow $1_mozilla_t $2:unix_stream_socket connectto;
 	allow $2 $1_mozilla_t:fd use;
 	allow $2 $1_mozilla_t:shm { associate getattr };
@@ -190,6 +189,8 @@
 	userdom_manage_user_tmp_dirs($1,$1_mozilla_t)
 	userdom_manage_user_tmp_files($1,$1_mozilla_t)
 	userdom_manage_user_tmp_sockets($1,$1_mozilla_t)
+
+	userdom_sigchld_all_users($1_mozilla_t)
 =09
 	xserver_user_x_domain_template($1,$1_mozilla,$1_mozilla_t,
$1_mozilla_tmpfs_t)
 	xserver_dontaudit_read_xdm_tmp_files($1_mozilla_t)

--=20
Dominick Grift <domg472@gmail.com>

--=-CokFjX/MSpa77yW2+81L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGTOsACgkQL00QnzrVtlxhyACdE1eqSdFIBh+XDaBBY4o/HXRO
SCAAoJqzCrHD5ymHXYx0rWjnK7Xrrt44
=HPn8
-----END PGP SIGNATURE-----

--=-CokFjX/MSpa77yW2+81L--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
