Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5I4E8rT014710
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 00:14:08 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5I4E64C006767
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 04:14:06 GMT
Subject: Re: toggle_bool
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1087529312.23933.248.camel@gorn.pebenito.net>
References: <1087529312.23933.248.camel@gorn.pebenito.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-x+DKTE+Ez5aL5mDU30n6"
Message-Id: <1087532039.23933.253.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 23:14:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-x+DKTE+Ez5aL5mDU30n6
Content-Type: multipart/mixed; boundary="=-kxUuuor9cMEeLdKfoMeI"


--=-kxUuuor9cMEeLdKfoMeI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Oops, it was missing useful return's.

On Thu, 2004-06-17 at 22:28, Chris PeBenito wrote:
> I wrote up little tool, toggle_bool, inspired by the old avc_toggle.=20
> You can specify one or more booleans on the command line, and it will
> toggle their value, and display their new value.
>=20
> beta root # toggle_bool admin_sep disable_pax user_ping
> admin_sep: active
> disable_pax: inactive
> user_ping: inactive
>=20
> beta root # toggle_bool admin_sep disable_pax user_ping
> admin_sep: inactive
> disable_pax: active
> user_ping: active
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

--=-kxUuuor9cMEeLdKfoMeI
Content-Disposition: attachment; filename=toggle_bool.c
Content-Type: text/x-csrc; name=toggle_bool.c; charset=iso-8859-1
Content-Transfer-Encoding: base64

LyoNCiAqIENvcHlyaWdodCAxOTk5LTIwMDQgR2VudG9vIFRlY2hub2xvZ2llcywgSW5jLg0KICog
RGlzdHJpYnV0ZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSB2Mg0KICogJEhlYWRlcjogL3Zhci9jdnNyb290L2dlbnRvby1wcm9qZWN0cy9oYXJkZW5l
ZC9wb2xpY3ljb3JldXRpbHMtZXh0cmEvc3JjL3RvZ2dsZV9ib29sLmMsdiAxLjIgMjAwNC8wNi8x
OCAwNDowOTowNCBwZWJlbml0byBFeHAgJA0KICovDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNs
dWRlIDxsaWJnZW4uaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0KI2luY2x1ZGUgPHNlbGludXgvc2Vs
aW51eC5oPg0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsNCg0KCWludCByYywg
aSwgY29tbWl0PTA7DQoNCglpZihhcmdjIDwgMikgew0KCQlwcmludGYoIlVzYWdlOiAgJXMgYm9v
bG5hbWUxIFtib29sbmFtZTIgLi4uXVxuIixiYXNlbmFtZShhcmd2WzBdKSk7DQoJCXJldHVybiAx
Ow0KCX0NCg0KCWZvcihpPTE7IGk8YXJnYzsgaSsrKSB7DQoJCXByaW50ZigiJXM6ICIsYXJndltp
XSk7DQoJCXJjPXNlY3VyaXR5X2dldF9ib29sZWFuX2FjdGl2ZShhcmd2W2ldKTsNCgkJc3dpdGNo
KHJjKSB7DQoJCQljYXNlIDE6DQoJCQkJaWYoc2VjdXJpdHlfc2V0X2Jvb2xlYW4oYXJndltpXSww
KSA+PSAwKSB7DQoJCQkJCXByaW50ZigiaW5hY3RpdmVcbiIpOw0KCQkJCQljb21taXQrKzsNCgkJ
CQl9IGVsc2Ugew0KCQkJCQlwcmludGYoIiVzXG4iLHN0cmVycm9yKGVycm5vKSk7DQoJCQkJfQ0K
CQkJCWJyZWFrOw0KCQkJY2FzZSAwOg0KCQkJCWlmKHNlY3VyaXR5X3NldF9ib29sZWFuKGFyZ3Zb
aV0sMSkgPj0gMCkgew0KCQkJCQlwcmludGYoImFjdGl2ZVxuIik7DQoJCQkJCWNvbW1pdCsrOw0K
CQkJCX0gZWxzZSB7DQoJCQkJCXByaW50ZigiJXNcbiIsc3RyZXJyb3IoZXJybm8pKTsNCgkJCQl9
DQoJCQkJYnJlYWs7DQoJCQlkZWZhdWx0Og0KCQkJCWlmKGVycm5vPT1FTk9FTlQpDQoJCQkJCXBy
aW50ZigiQm9vbGVhbiBkb2VzIG5vdCBleGlzdFxuIik7DQoJCQkJZWxzZQ0KCQkJCQlwcmludGYo
IiVzXG4iLHN0cmVycm9yKGVycm5vKSk7DQoJCQkJYnJlYWs7DQoJCX0NCgl9DQoNCglpZihjb21t
aXQgPiAwKSB7DQoJCWlmKHNlY3VyaXR5X2NvbW1pdF9ib29sZWFucygpIDwgMCkgew0KCQkJcHJp
bnRmKCJDb21taXQgZmFpbGVkLiAoJXMpICBObyBjaGFuZ2UgdG8gYm9vbGVhbnMuXG4iLHN0cmVy
cm9yKGVycm5vKSk7DQoJCQlyZXR1cm4gMTsNCgkJfSBlbHNlIHsNCgkJCXJldHVybiAwOw0KCQl9
DQoJfSBlbHNlIHsNCgkJcmV0dXJuIDE7DQoJfQ0KfQ0K

--=-kxUuuor9cMEeLdKfoMeI--

--=-x+DKTE+Ez5aL5mDU30n6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0mwHvI7kLeavkkMRAm7TAJ9x8NV485TEe6EGmlYr/RdRBt21ewCeIMaB
fPR8rCL7aLqrQF/UHoB/k/E=
=Q3Kp
-----END PGP SIGNATURE-----

--=-x+DKTE+Ez5aL5mDU30n6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
