Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4T2V1Lb026320
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 22:31:01 -0400
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4T2V0XH011384
	for <selinux@tycho.nsa.gov>; Thu, 29 May 2008 02:31:00 GMT
Subject: [patch][stable] policycoreutils user_u seuser vs. genhomedircon
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sS2Q8c6nyvfXIJgzK0M7"
Date: Wed, 28 May 2008 22:30:57 -0400
Message-Id: <1212028257.5316.7.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sS2Q8c6nyvfXIJgzK0M7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

In the stable branch, genhomedircon will ignore making home dir contexts
for linux users mapped to user_u.  For a long time, this was fine since
user_u was the default for strict and targeted.  With a merged
strict-targeted policy, a more targeted-like system will have
unconfined_u as the default.  If you then try to make a confined user_u
user, a set of home directory contexts will not be created.  This patch
fixes the behavior.  I made a cursory look through the trunk C
genhomedircon, and did not see this behavior, but someone should
probably doublecheck.

Index: policycoreutils/scripts/genhomedircon
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policycoreutils/scripts/genhomedircon	(revision 2890)
+++ policycoreutils/scripts/genhomedircon	(working copy)
@@ -193,7 +193,7 @@
 		return prefix
 	=09
 	def adduser(self, udict, user, seuser, prefix):
-		if seuser =3D=3D "user_u" or user =3D=3D "__default__" or user =3D=3D "s=
ystem_u":
+		if user =3D=3D "__default__" or user =3D=3D "system_u":
 			return
 		# !!! chooses first prefix in the list to use in the file context !!!
 		try:



--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-sS2Q8c6nyvfXIJgzK0M7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkg+FWEACgkQvI7kLeavkkO4OgCgnmAFbmVBzkBvdtWWwa+2v8Xj
+c0AnipXcRZ28KdCH5esMr7G0pkthh56
=B2dy
-----END PGP SIGNATURE-----

--=-sS2Q8c6nyvfXIJgzK0M7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
