Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQ51RRb018017
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 00:01:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQ50rp5023506
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 05:00:53 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id hAQ50qt0023503
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 05:00:53 GMT
Subject: jabber policy
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: russell@coker.com.au
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MOiFJj9IuvcFnrjUWCWX"
Message-Id: <1069822543.17898.12.camel@metropolis.verbum.private>
Mime-Version: 1.0
Date: Tue, 25 Nov 2003 23:55:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MOiFJj9IuvcFnrjUWCWX
Content-Type: multipart/mixed; boundary="=-raS60TJ8OC70cAk0S1K0"


--=-raS60TJ8OC70cAk0S1K0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is a patch which adds a policy for the jabber server, against
Brian's woody policy (but should easily apply elsewhere).

This policy is for the 1.4.3 server; I haven't tried the 2.0 server yet.
I imagine that would take more work since it supports various backends
and whatnot.


--=-raS60TJ8OC70cAk0S1K0
Content-Disposition: attachment; filename=jabber.patch
Content-Type: text/x-patch; name=jabber.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIG5ldF9jb250ZXh0c34JVGh1IE9jdCAzMCAyMzowMTo0MCAyMDAzDQorKysgbmV0X2NvbnRl
eHRzCVR1ZSBOb3YgMjUgMTk6NDk6NDUgMjAwMw0KQEAgLTk2LDYgKzk2LDExIEBADQogcG9ydGNv
biB1ZHAgMTgxMiBzeXN0ZW1fdTpvYmplY3RfcjpyYWRpdXNfcG9ydF90DQogcG9ydGNvbiB1ZHAg
MTgxMyBzeXN0ZW1fdTpvYmplY3RfcjpyYWRhY2N0X3BvcnRfdCcpDQogaWZkZWYoYGRpY3RkLnRl
JywgYHBvcnRjb24gdGNwIDI2Mjggc3lzdGVtX3U6b2JqZWN0X3I6ZGljdF9wb3J0X3QnKQ0KK2lm
ZGVmKGBqYWJiZXJkLnRlJywgYA0KK3BvcnRjb24gdGNwIDUyMjIgc3lzdGVtX3U6b2JqZWN0X3I6
amFiYmVyX2NsaWVudF9wb3J0X3QNCitwb3J0Y29uIHRjcCA1MjIzIHN5c3RlbV91Om9iamVjdF9y
OmphYmJlcl9jbGllbnRfcG9ydF90DQorcG9ydGNvbiB0Y3AgNTI2OSBzeXN0ZW1fdTpvYmplY3Rf
cjpqYWJiZXJfaW50ZXJzZXJ2ZXJfcG9ydF90DQorJykNCiBpZmRlZihgaW1hemVzcnYudGUnLGAN
CiBwb3J0Y29uIHRjcCA1MzIzIHN5c3RlbV91Om9iamVjdF9yOmltYXplX3BvcnRfdA0KIHBvcnRj
b24gdWRwIDUzMjMgc3lzdGVtX3U6b2JqZWN0X3I6aW1hemVfcG9ydF90DQotLS0gL2Rldi9udWxs
CU1vbiBKdW4gMjMgMDg6MTI6MzYgMjAwMw0KKysrIGRvbWFpbnMvcHJvZ3JhbS9qYWJiZXJkLnRl
CVR1ZSBOb3YgMjUgMjI6NTM6MzYgMjAwMw0KQEAgLTAsMCArMSwzNiBAQA0KKyNERVNDIGphYmJl
cmQgLSBKYWJiZXIgZGFlbW9uDQorIw0KKyMgQXV0aG9yOiBDb2xpbiBXYWx0ZXJzIDx3YWx0ZXJz
QHZlcmJ1bS5vcmc+DQorIyBYLURlYmlhbi1QYWNrYWdlczogamFiYmVyDQorDQorZGFlbW9uX2Rv
bWFpbihqYWJiZXJkKQ0KK3R5cGUgdmFyX2xpYl9qYWJiZXJkX3QsIGZpbGVfdHlwZSwgc3lzYWRt
ZmlsZTsNCit0eXBlIHZhcl9sb2dfamFiYmVyZF90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGxv
Z2ZpbGU7DQorDQordHlwZSBqYWJiZXJfY2xpZW50X3BvcnRfdCwgcG9ydF90eXBlOw0KK3R5cGUg
amFiYmVyX2ludGVyc2VydmVyX3BvcnRfdCwgcG9ydF90eXBlOw0KKw0KK2FsbG93IGphYmJlcmRf
dCBqYWJiZXJfY2xpZW50X3BvcnRfdDp0Y3Bfc29ja2V0IG5hbWVfYmluZDsNCithbGxvdyBqYWJi
ZXJkX3QgamFiYmVyX2ludGVyc2VydmVyX3BvcnRfdDp0Y3Bfc29ja2V0IG5hbWVfYmluZDsNCisN
CithbGxvdyBqYWJiZXJkX3QgZXRjX3Q6bG5rX2ZpbGUgcmVhZDsNCithbGxvdyBqYWJiZXJkX3Qg
eyBldGNfdCByZXNvbHZfY29uZl90IGV0Y19ydW50aW1lX3QgfTpmaWxlIHsgcmVhZCBnZXRhdHRy
IH07DQorDQorYWxsb3cgamFiYmVyZF90IHZhcl9saWJfdDpkaXIgcl9kaXJfcGVybXM7DQorY3Jl
YXRlX2Rpcl9maWxlKGphYmJlcmRfdCwgdmFyX2xpYl9qYWJiZXJkX3QpDQorDQorZmlsZV90eXBl
X2F1dG9fdHJhbnMoamFiYmVyZF90LCB2YXJfbG9nX3QsIHZhcl9sb2dfamFiYmVyZF90KQ0KKw0K
KyMgRm9yIFNTTA0KK2FsbG93IGphYmJlcmRfdCByYW5kb21fZGV2aWNlX3Q6ZmlsZSByX2ZpbGVf
cGVybXM7DQorDQorY2FuX25ldHdvcmsoamFiYmVyZF90KQ0KKw0KK2FsbG93IGphYmJlcmRfdCBz
ZWxmOnVuaXhfZGdyYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7DQorYWxsb3cgamFiYmVy
ZF90IHNlbGY6dW5peF9zdHJlYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7DQorYWxsb3cg
amFiYmVyZF90IHNlbGY6Zmlmb19maWxlIHsgcmVhZCB3cml0ZSBnZXRhdHRyIH07DQorDQorYWxs
b3cgamFiYmVyZF90IHNlbGY6Y2FwYWJpbGl0eSB7IGRhY19vdmVycmlkZSB9Ow0KKw0KKyMgYWxs
b3cgYW55IHVzZXIgZG9tYWluIHRvIGNvbm5lY3QgdG8gamFiYmVyDQorY2FuX3RjcF9jb25uZWN0
KHVzZXJkb21haW4sIGphYmJlcmRfdCkNCi0tLSAvZGV2L251bGwJTW9uIEp1biAyMyAwODoxMjoz
NiAyMDAzDQorKysgZmlsZV9jb250ZXh0cy9wcm9ncmFtL2phYmJlcmQuZmMJVHVlIE5vdiAyNSAy
MToyNDoxOCAyMDAzDQpAQCAtMCwwICsxLDMgQEANCisjIGphYmJlcmQNCisvdXNyL3NiaW4vamFi
YmVyZAkJc3lzdGVtX3U6b2JqZWN0X3I6amFiYmVyZF9leGVjX3QNCisvdmFyL2xpYi9qYWJiZXIJ
CQlzeXN0ZW1fdTpvYmplY3Rfcjp2YXJfbGliX2phYmJlcmRfdA0K

--=-raS60TJ8OC70cAk0S1K0--

--=-MOiFJj9IuvcFnrjUWCWX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/xDJLOIkJWWp2WGURAgX6AJ9gK7ik/gRfGOUHo5EYJLFpgp8x+wCdFTvB
zmZcdcRhw6xXcuNxkQl5pEY=
=NhYG
-----END PGP SIGNATURE-----

--=-MOiFJj9IuvcFnrjUWCWX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
