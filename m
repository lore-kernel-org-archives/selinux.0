Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k15KehXf028103
	for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2006 15:40:43 -0500 (EST)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k15KdOKI022592
	for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2006 20:39:25 GMT
Subject: [PATCH] fix PPC compile issues
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ux8F0s5qhRo/efOgFd9y"
Date: Sun, 05 Feb 2006 15:40:35 -0500
Message-Id: <1139172035.8084.34.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ux8F0s5qhRo/efOgFd9y
Content-Type: multipart/mixed; boundary="=-A7DysD4k9VPpusic2OPJ"


--=-A7DysD4k9VPpusic2OPJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The attached patch changes variables used to store results of getopt()
from char to int, as int is the return of getopt(), and char is unsigned
by default on PPC, making tests like if (opt =3D=3D -1) always false:

cc -Werror -Wall -W -I/usr/include   -c -o semodule_link.o
semodule_link.c
semodule_link.c: In function `main':
semodule_link.c:84: warning: comparison is always true due to limited
range of data type


 semodule_expand/semodule_expand.c |    4 ++--
 semodule_link/semodule_link.c     |    4 ++--
 sestatus/sestatus.c               |    3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)


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


--=-A7DysD4k9VPpusic2OPJ
Content-Disposition: attachment; filename=policycoreutils-unsigned-char-ppc.diff
Content-Type: text/x-patch; name=policycoreutils-unsigned-char-ppc.diff;
	charset=ISO-8859-1
Content-Transfer-Encoding: base64

PyBwb2xpY3kvcG9saWN5LjIwDQo/IHBvbGljeS9wb2xpY3kuY29uZg0KPyBwb2xpY3kvdG1wDQo/
IHBvbGljeS9maWxlX2NvbnRleHRzL2ZpbGVfY29udGV4dHMNCj8gcG9saWN5L2ZpbGVfY29udGV4
dHMvaG9tZWRpcl90ZW1wbGF0ZQ0KPyBwb2xpY3kvZmlsZV9jb250ZXh0cy9taXNjDQpJbmRleDog
cG9saWN5Y29yZXV0aWxzL3NlbW9kdWxlX2V4cGFuZC9zZW1vZHVsZV9leHBhbmQuYw0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGludXgvbnNhL3NlbGludXgtdXNyL3BvbGljeWNv
cmV1dGlscy9zZW1vZHVsZV9leHBhbmQvc2Vtb2R1bGVfZXhwYW5kLmMsdg0KcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjkNCmRpZmYgLXUgLXIxLjkgc2Vtb2R1bGVfZXhwYW5kLmMNCi0tLSBwb2xpY3lj
b3JldXRpbHMvc2Vtb2R1bGVfZXhwYW5kL3NlbW9kdWxlX2V4cGFuZC5jCTIwIE9jdCAyMDA1IDE2
OjM3OjIzIC0wMDAwCTEuOQ0KKysrIHBvbGljeWNvcmV1dGlscy9zZW1vZHVsZV9leHBhbmQvc2Vt
b2R1bGVfZXhwYW5kLmMJNSBGZWIgMjAwNiAyMDoyODoxMyAtMDAwMA0KQEAgLTM2LDggKzM2LDgg
QEANCiANCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQogew0KLQljaGFyIGNoLCAq
YmFzZW5hbWUsICpvdXRuYW1lOw0KLQlpbnQgcmV0LCBzaG93X3ZlcnNpb24gPSAwLCB2ZXJib3Nl
ID0gMDsNCisJY2hhciAqYmFzZW5hbWUsICpvdXRuYW1lOw0KKwlpbnQgY2gsIHJldCwgc2hvd192
ZXJzaW9uID0gMCwgdmVyYm9zZSA9IDA7DQogCXN0cnVjdCBzZXBvbF9wb2xpY3lfZmlsZSAqcGY7
DQogCXNlcG9sX21vZHVsZV9wYWNrYWdlX3QgKmJhc2U7DQogCXNlcG9sX3BvbGljeWRiX3QgKm91
dDsNCkluZGV4OiBwb2xpY3ljb3JldXRpbHMvc2Vtb2R1bGVfbGluay9zZW1vZHVsZV9saW5rLmMN
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9zZWxpbnV4L25zYS9zZWxpbnV4LXVzci9w
b2xpY3ljb3JldXRpbHMvc2Vtb2R1bGVfbGluay9zZW1vZHVsZV9saW5rLmMsdg0KcmV0cmlldmlu
ZyByZXZpc2lvbiAxLjcNCmRpZmYgLXUgLXIxLjcgc2Vtb2R1bGVfbGluay5jDQotLS0gcG9saWN5
Y29yZXV0aWxzL3NlbW9kdWxlX2xpbmsvc2Vtb2R1bGVfbGluay5jCTIwIE9jdCAyMDA1IDE2OjM3
OjIzIC0wMDAwCTEuNw0KKysrIHBvbGljeWNvcmV1dGlscy9zZW1vZHVsZV9saW5rL3NlbW9kdWxl
X2xpbmsuYwk1IEZlYiAyMDA2IDIwOjI4OjEzIC0wMDAwDQpAQCAtNzMsOCArNzMsOCBAQA0KIA0K
IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCiB7DQotCWludCBpLCBzaG93X3ZlcnNp
b24gPSAwLCB2ZXJib3NlID0gMCwgbnVtX21vZHM7DQotCWNoYXIgY2gsICpiYXNlbmFtZSwgKm91
dG5hbWUgPSBOVUxMOw0KKwlpbnQgY2gsIGksIHNob3dfdmVyc2lvbiA9IDAsIHZlcmJvc2UgPSAw
LCBudW1fbW9kczsNCisJY2hhciAqYmFzZW5hbWUsICpvdXRuYW1lID0gTlVMTDsNCiAJc2Vwb2xf
bW9kdWxlX3BhY2thZ2VfdCAqYmFzZSwgKiptb2RzOw0KIAlGSUxFICpvdXRmaWxlOw0KIAlzdHJ1
Y3Qgc2Vwb2xfcG9saWN5X2ZpbGUgKnBmOw0KSW5kZXg6IHBvbGljeWNvcmV1dGlscy9zZXN0YXR1
cy9zZXN0YXR1cy5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51eC9uc2Ev
c2VsaW51eC11c3IvcG9saWN5Y29yZXV0aWxzL3Nlc3RhdHVzL3Nlc3RhdHVzLmMsdg0KcmV0cmll
dmluZyByZXZpc2lvbiAxLjkNCmRpZmYgLXUgLXIxLjkgc2VzdGF0dXMuYw0KLS0tIHBvbGljeWNv
cmV1dGlscy9zZXN0YXR1cy9zZXN0YXR1cy5jCTI5IE5vdiAyMDA1IDE1OjU1OjAyIC0wMDAwCTEu
OQ0KKysrIHBvbGljeWNvcmV1dGlscy9zZXN0YXR1cy9zZXN0YXR1cy5jCTUgRmViIDIwMDYgMjA6
Mjg6MTMgLTAwMDANCkBAIC0xNjAsOSArMTYwLDggQEANCiANCiBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpIHsNCiAJLyogdGhlc2UgdmFycyBhcmUgcmV1c2VkIHNldmVyYWwgdGltZXMg
Ki8NCi0JaW50IHJjLCBpLGM7DQorCWludCByYyxvcHQsIGksYzsNCiAJY2hhciAqY29udGV4dDsN
Ci0JY2hhciBvcHQ7DQogDQogCS8qIGZpbGVzIHRoYXQgbmVlZCBjb250ZXh0IGNoZWNrcyAqLw0K
IAljaGFyICpmY1tNQVhfQ0hFQ0tdOw0K


--=-A7DysD4k9VPpusic2OPJ--

--=-ux8F0s5qhRo/efOgFd9y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD5mLDvI7kLeavkkMRAuNWAKCfoyH7cmQqahQFLYItKfBYQmDo5wCfQsAu
6dDnLCCWGs2xywsBLxBEOZ4=
=wFPA
-----END PGP SIGNATURE-----

--=-ux8F0s5qhRo/efOgFd9y--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
