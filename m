Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAA1A2Ii026989
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 20:10:02 -0500 (EST)
Received: from sccrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAA18dxp027589
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 01:08:39 GMT
Subject: [patch] libselinux/utils/selinuxconfig.c
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3pi+tmBcWKHnjOtFRRuv"
Date: Tue, 09 Nov 2004 20:09:14 -0500
Message-Id: <1100048954.24818.3.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3pi+tmBcWKHnjOtFRRuv
Content-Type: multipart/mixed; boundary="=-XJxJyAMkaE8I3LNVGqp8"


--=-XJxJyAMkaE8I3LNVGqp8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here's a trivial patch to display the file_contexts path in
selinuxconfig.  Gentoo has a script to relabel individual packages using
setfiles, and this is useful rather than having a hard-coded path for
file_contexts.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-XJxJyAMkaE8I3LNVGqp8
Content-Disposition: attachment; filename=selinuxconfig.c.diff
Content-Type: text/x-patch; name=selinuxconfig.c.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IHV0aWxzL3NlbGludXhjb25maWcuYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNy
b290L3NlbGludXgvbnNhL3NlbGludXgtdXNyL2xpYnNlbGludXgvdXRpbHMvc2VsaW51eGNvbmZp
Zy5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4yDQpkaWZmIC11IC1yMS4yIHNlbGludXhjb25m
aWcuYw0KLS0tIHV0aWxzL3NlbGludXhjb25maWcuYwkxNSBKdW4gMjAwNCAxMzoxNjozMCAtMDAw
MAkxLjINCisrKyB1dGlscy9zZWxpbnV4Y29uZmlnLmMJMTAgTm92IDIwMDQgMDE6MDQ6NDEgLTAw
MDANCkBAIC0yOCw2ICsyOCw3IEBADQogCXByaW50ZigiYmluYXJ5X3BvbGljeV9wYXRoPVwiJXNc
IlxuIiwgc2VsaW51eF9iaW5hcnlfcG9saWN5X3BhdGgoKSk7DQogCXByaW50ZigidXNlcl9jb250
ZXh0c19wYXRoPVwiJXNcIlxuIiwgc2VsaW51eF91c2VyX2NvbnRleHRzX3BhdGgoKSk7DQogCXBy
aW50ZigiY29udGV4dHNfcGF0aD1cIiVzXCJcbiIsIHNlbGludXhfY29udGV4dHNfcGF0aCgpKTsN
CisJcHJpbnRmKCJmaWxlX2NvbnRleHRzX3BhdGg9XCIlc1wiXG4iLCBzZWxpbnV4X2ZpbGVfY29u
dGV4dF9wYXRoKCkpOw0KIAlleGl0KDApOw0KIA0KIH0NCg==


--=-XJxJyAMkaE8I3LNVGqp8--

--=-3pi+tmBcWKHnjOtFRRuv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBkWo6vI7kLeavkkMRAicsAJ9APUg4jt3/GWLjvm241kzcu25JzgCgpuHt
VyirFy7kUtxk73IlYoTxY94=
=4REy
-----END PGP SIGNATURE-----

--=-3pi+tmBcWKHnjOtFRRuv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
