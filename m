Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8H0darT029226
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 20:39:36 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8H0cd8m021685
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 00:38:39 GMT
Subject: [PATCH] Gentoo-specific initrc
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ass086eClndJ3go88pNT"
Message-Id: <1095381586.735.30.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 20:39:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ass086eClndJ3go88pNT
Content-Type: multipart/mixed; boundary="=-JBVGAf/or7I9OY1aI3Q2"


--=-JBVGAf/or7I9OY1aI3Q2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here's a patch for Gentoo-specific initrc, against sourceforge CVS.

 domains/program/initrc.te       |   15 +++++++++++++++
 file_contexts/program/initrc.fc |    8 ++++++++
 2 files changed, 23 insertions(+)

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

--=-JBVGAf/or7I9OY1aI3Q2
Content-Disposition: attachment; filename=gentoo-initrc.diff
Content-Type: text/x-patch; name=gentoo-initrc.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IGRvbWFpbnMvcHJvZ3JhbS9pbml0cmMudGUNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAv
Y3Zzcm9vdC9zZWxpbnV4L25zYS9zZWxpbnV4LXVzci9wb2xpY3kvZG9tYWlucy9wcm9ncmFtL2lu
aXRyYy50ZSx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjgNCmRpZmYgLXUgLXIxLjI4IGluaXRy
Yy50ZQ0KLS0tIGRvbWFpbnMvcHJvZ3JhbS9pbml0cmMudGUJMTAgU2VwIDIwMDQgMTQ6NDU6NDgg
LTAwMDAJMS4yOA0KKysrIGRvbWFpbnMvcHJvZ3JhbS9pbml0cmMudGUJMTcgU2VwIDIwMDQgMDA6
MzU6MDggLTAwMDANCkBAIC0zMTksMyArMzE5LDE4IEBADQogaWZkZWYoYGRidXNkLnRlJywgYA0K
IGFsbG93IGluaXRyY190IHN5c3RlbV9kYnVzZF90OmRidXMgeyBzZW5kX21zZyBhY3F1aXJlX3N2
YyB9Ow0KICcpDQorDQoraWZkZWYoYGRpc3Ryb19nZW50b28nLCBgDQorIyBnZW50b28tc3BlY2lm
aWMgaW5pdCBzY3JpcHQgc3RhdGUNCit0eXBlIGluaXRyY19zdGF0ZV90LCBmaWxlX3R5cGUsIHN5
c2FkbWZpbGU7DQorYWxsb3cgaW5pdHJjX3QgaW5pdHJjX3N0YXRlX3Q6bG5rX2ZpbGUgeyBjcmVh
dGUgcmVhZCB1bmxpbmsgc2V0YXR0ciB9Ow0KK2FsbG93IGluaXRyY190IGluaXRyY19zdGF0ZV90
OmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7DQorYWxsb3cgaW5pdHJjX3QgaW5pdHJjX3N0YXRlX3Q6
ZGlyIHsgYWRkX25hbWUgcmVtb3ZlX25hbWUgcmVhZCB3cml0ZSBybWRpciBjcmVhdGUgcmVuYW1l
IHNldGF0dHIgfTsNCisNCisjIGVudi11cGRhdGU6DQorYWxsb3cgaW5pdHJjX3QgZXRjX3J1bnRp
bWVfdDpkaXIgcmVhZDsNCithbGxvdyBpbml0cmNfdCBldGNfcnVudGltZV90OmZpbGUgdW5saW5r
Ow0KKw0KKyMgR2VudG9vIGludGVncmF0ZWQgcnVuX2luaXQrb3Blbl9pbml0X3B0eS1ydW5zY3Jp
cHQ6DQorZG9tYWluX2F1dG9fdHJhbnMoc3lzYWRtX3QsaW5pdHJjX2V4ZWNfdCxydW5faW5pdF90
KQ0KKycpDQpJbmRleDogZmlsZV9jb250ZXh0cy9wcm9ncmFtL2luaXRyYy5mYw0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgvbnNhL3NlbGludXgtdXNyL3BvbGljeS9maWxl
X2NvbnRleHRzL3Byb2dyYW0vaW5pdHJjLmZjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS43DQpk
aWZmIC11IC1yMS43IGluaXRyYy5mYw0KLS0tIGZpbGVfY29udGV4dHMvcHJvZ3JhbS9pbml0cmMu
ZmMJMzAgQXVnIDIwMDQgMjA6MTM6MjkgLTAwMDAJMS43DQorKysgZmlsZV9jb250ZXh0cy9wcm9n
cmFtL2luaXRyYy5mYwkxNyBTZXAgMjAwNCAwMDozNTowOSAtMDAwMA0KQEAgLTExLDYgKzExLDE0
IEBADQogL3Zhci9ydW4vcnVubGV2ZWxcLmRpcgkJc3lzdGVtX3U6b2JqZWN0X3I6aW5pdHJjX3Zh
cl9ydW5fdA0KIC92YXIvcnVuL3JhbmRvbS1zZWVkCS0tCXN5c3RlbV91Om9iamVjdF9yOmluaXRy
Y192YXJfcnVuX3QNCiAvdmFyL3J1bi9zZXRtaXhlcl9mbGFnCS0tCXN5c3RlbV91Om9iamVjdF9y
OmluaXRyY192YXJfcnVuX3QNCisNCitpZmRlZihgZGlzdHJvX2dlbnRvbycsIGANCisvc2Jpbi9y
YwkJLS0Jc3lzdGVtX3U6b2JqZWN0X3I6aW5pdHJjX2V4ZWNfdA0KKy9zYmluL3J1bnNjcmlwdAkJ
LS0gICAgICBzeXN0ZW1fdTpvYmplY3Rfcjppbml0cmNfZXhlY190DQorL3NiaW4vcnVuc2NyaXB0
LnNoCS0tCXN5c3RlbV91Om9iamVjdF9yOmluaXRyY19leGVjX3QNCisvdmFyL2xpYi9pbml0LmQo
Ly4qKT8JCXN5c3RlbV91Om9iamVjdF9yOmluaXRyY19zdGF0ZV90DQorJykNCisNCiAjIHJ1bl9p
bml0DQogL3Vzci9zYmluL3J1bl9pbml0CS0tCXN5c3RlbV91Om9iamVjdF9yOnJ1bl9pbml0X2V4
ZWNfdA0KIGlmZGVmKGBkaXN0cm9fZGViaWFuJywgYA0K

--=-JBVGAf/or7I9OY1aI3Q2--

--=-ass086eClndJ3go88pNT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBSjJRvI7kLeavkkMRAqy3AKCmn/ujyw2PLcsWlNFX1DI9MVrK9gCgppyf
OklxRVU6UQQwbFgipQhnWwU=
=XAIA
-----END PGP SIGNATURE-----

--=-ass086eClndJ3go88pNT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
