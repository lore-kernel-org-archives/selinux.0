Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NKP3Wt011957
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 16:25:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9NKOnIS014985
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:24:49 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9NKOlDc014982
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:24:48 GMT
Date: Thu, 23 Oct 2003 22:24:47 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policy-1
Message-ID: <20031023202447.GA31857@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QKdGvSO+nmPlgiQ/
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

this patch fixes the following problems:
- fix type for shlibs in /usr/local/lib
files: file_contexts/types.fc

bastian

--=20
The heart is not a logical organ.
		-- Dr. Janet Wallace, "The Deadly Years", stardate 3479.4

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=policy-1
Content-Transfer-Encoding: quoted-printable

Index: file_contexts/types.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- file_contexts/types.fc	(.../upstream/current/policy)	(revision 46)
+++ file_contexts/types.fc	(.../trunk/policy)	(revision 46)
@@ -322,7 +322,7 @@
 # /usr/local/lib
 #
 /usr/local/lib(/.*)?		system_u:object_r:lib_t
-/usr/local/lib/.*\.so		system_u:object_r:shlib_t
+/usr/local/lib/.*\.so.*		system_u:object_r:shlib_t
=20
 #
 # /usr/sbin

--7JfCtLOvnd9MIVvH--

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj+YOQ8ACgkQLkAIIn9ODhEPLwCg2AKMQMVAag0IhIdCRHtaws/h
178An2yVovl5DpiqTSDaCBsNSRqebfuk
=QryG
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
