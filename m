Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2S4xQRb029598
	for <selinux@tycho.nsa.gov>; Sat, 27 Mar 2004 23:59:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2S4xOFV021994
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 04:59:24 GMT
Received: from gorn.pebenito.dhs.org (c-24-15-25-98.client.comcast.net [24.15.25.98])
        by jazzband.ncsc.mil  with ESMTP id i2S4xO36021988 for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 04:59:24 GMT
Subject: distcc policy
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EZ2mdAt0QIE/V4X4zJi4"
Message-Id: <1080449956.11635.32.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Sat, 27 Mar 2004 22:59:16 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EZ2mdAt0QIE/V4X4zJi4
Content-Type: multipart/mixed; boundary="=-gYWD+t1nayTMAGrEBgbQ"


--=-gYWD+t1nayTMAGrEBgbQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here's a policy for distccd, the distributed compiler daemon.  Its been
in heavy use in Gentoo for a while.

http://distcc.samba.org/


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

--=-gYWD+t1nayTMAGrEBgbQ
Content-Disposition: attachment; filename=distcc-portcon.diff
Content-Type: text/x-patch; name=distcc-portcon.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IG5ldF9jb250ZXh0cw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L3NlbGlu
dXgvbnNhL3NlbGludXgtdXNyL3BvbGljeS9uZXRfY29udGV4dHMsdg0KcmV0cmlldmluZyByZXZp
c2lvbiAxLjUNCmRpZmYgLXUgLWIgLUIgLXIxLjUgbmV0X2NvbnRleHRzDQotLS0gbmV0X2NvbnRl
eHRzCTE3IE1hciAyMDA0IDE4OjI2OjA0IC0wMDAwCTEuNQ0KKysrIG5ldF9jb250ZXh0cwkyNiBN
YXIgMjAwNCAxOToyOTowNSAtMDAwMA0KQEAgLTEyNyw2ICsxMjcsNyBAQA0KIHBvcnRjb24gdGNw
IDcwMDAgc3lzdGVtX3U6b2JqZWN0X3I6Z2F0ZWtlZXBlcl9wb3J0X3QNCiAnKQ0KIGlmZGVmKGBk
aWN0ZC50ZScsIGBwb3J0Y29uIHRjcCAyNjI4IHN5c3RlbV91Om9iamVjdF9yOmRpY3RfcG9ydF90
JykNCitpZmRlZihgZGlzdGNjLnRlJyxgcG9ydGNvbiB0Y3AgMzYzMiBzeXN0ZW1fdTpvYmplY3Rf
cjpkaXN0Y2NkX3BvcnRfdCcpDQogaWZkZWYoYHB4ZS50ZScsIGANCiBkZWZpbmUoYHVzZV9weGUn
KQ0KICcpDQo=

--=-gYWD+t1nayTMAGrEBgbQ
Content-Disposition: attachment; filename=distcc.fc
Content-Type: text/plain; name=distcc.fc; charset=ISO-8859-1
Content-Transfer-Encoding: base64

IyBkaXN0Y2MNCi91c3IvYmluL2Rpc3RjY2QJCXN5c3RlbV91Om9iamVjdF9yOmRpc3RjY2RfZXhl
Y190DQo=

--=-gYWD+t1nayTMAGrEBgbQ
Content-Disposition: attachment; filename=distcc.te
Content-Type: text/plain; name=distcc.te; charset=ISO-8859-1
Content-Transfer-Encoding: base64

I0RFU0MgZGlzdGNjIC0gRGlzdHJpYnV0ZWQgY29tcGlsZXIgZGFlbW9uDQojDQojIEF1dGhvcjog
Q2hyaXMgUGVCZW5pdG8gPHBlYmVuaXRvQGdlbnRvby5vcmc+DQojDQoNCmRhZW1vbl9kb21haW4o
ZGlzdGNjZCkNCmNhbl9uZXR3b3JrKGRpc3RjY2RfdCkNCnRtcF9kb21haW4oZGlzdGNjZCkNCg0K
dHlwZSBkaXN0Y2NkX3BvcnRfdCwgcG9ydF90eXBlOw0KYWxsb3cgZGlzdGNjZF90IGRpc3RjY2Rf
cG9ydF90OnRjcF9zb2NrZXQgbmFtZV9iaW5kOw0KYWxsb3cgZGlzdGNjZF90IHNlbGY6Y2FwYWJp
bGl0eSB7IHNldGdpZCBzZXR1aWQgfTsNCg0KIyBkaXN0Y2NkIGNhbiByZW5pY2UNCmFsbG93IGRp
c3RjY2RfdCBzZWxmOnByb2Nlc3Mgc2V0c2NoZWQ7DQoNCiMgY29tcGlsZXIgc3R1ZmYNCmFsbG93
IGRpc3RjY2RfdCB7IGJpbl90IHNiaW5fdCB9OmRpciB7IHNlYXJjaCBnZXRhdHRyIH07DQpjYW5f
ZXhlYyhkaXN0Y2NkX3QsYmluX3QpDQpjYW5fZXhlYyhkaXN0Y2NkX3QsbGliX3QpDQoNCiMgY29t
bSBzdHVmZg0KYWxsb3cgZGlzdGNjZF90IHJlc29sdl9jb25mX3Q6ZmlsZSByX2ZpbGVfcGVybXM7
DQphbGxvdyBkaXN0Y2NkX3Qgc2VsZjp7IHVuaXhfc3RyZWFtX3NvY2tldCB1bml4X2RncmFtX3Nv
Y2tldCB9IHsgY3JlYXRlIGNvbm5lY3QgcmVhZCB3cml0ZSB9Ow0KYWxsb3cgZGlzdGNjZF90IHNl
bGY6Zmlmb19maWxlIHsgcmVhZCB3cml0ZSBnZXRhdHRyIH07DQoNCiMgY29uZmlnIGFjY2Vzcw0K
YWxsb3cgZGlzdGNjZF90IHsgZXRjX3QgZXRjX3J1bnRpbWVfdCB9OmZpbGUgcl9maWxlX3Blcm1z
Ow0KYWxsb3cgZGlzdGNjZF90IHByb2NfdDpmaWxlIHJfZmlsZV9wZXJtczsNCg0KYWxsb3cgZGlz
dGNjZF90IHZhcl90OmRpciBzZWFyY2g7DQphbGxvdyBkaXN0Y2NkX3QgYWRtaW5fdHR5X3R5cGU6
Y2hyX2ZpbGUgeyBpb2N0bCByZWFkIHdyaXRlIH07DQo=

--=-gYWD+t1nayTMAGrEBgbQ--

--=-EZ2mdAt0QIE/V4X4zJi4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAZlujvI7kLeavkkMRAuCqAJ400pzCoJOW8tkI27v7w4/D9nwEGgCfba4s
mZfncNIjfv1X7GRowyU7bp8=
=edU0
-----END PGP SIGNATURE-----

--=-EZ2mdAt0QIE/V4X4zJi4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
