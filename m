Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HNTbrT018191
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 19:29:37 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HNTa8B009437
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 23:29:37 GMT
Subject: [patch] add D-BUS service context mapping
From: Colin Walters <walters@verbum.org>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MeLavRL9CkZf1KVlxh0I"
Date: Sun, 17 Oct 2004 19:29:43 -0400
Message-Id: <1098055784.9768.8.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MeLavRL9CkZf1KVlxh0I
Content-Type: multipart/mixed; boundary="=-pGqWw/rn/bNT6ZUIynXF"


--=-pGqWw/rn/bNT6ZUIynXF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch adds an empty D-BUS service mapping to the policy.
I'll be going over the current policy for FC4 and assigning contexts=20
to the current D-BUS services we are using.  Right now they're all
just falling back to the bus context.

I've also sent a patch to the D-BUS list to make it use this by default.


--=-pGqWw/rn/bNT6ZUIynXF
Content-Disposition: attachment; filename=policy-dbus-contexts.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=policy-dbus-contexts.patch; charset=UTF-8

LS0tIC9kZXYvbnVsbAkyMDA0LTEwLTE3IDExOjQwOjAwLjIyMTc1MDEwNCAtMDQwMA0KKysrIHBv
bGljeS0xLjE3LjMwL2FwcGNvbmZpZy9kYnVzX2NvbnRleHRzCTIwMDQtMTAtMTcgMTk6MjY6MzMu
Mjk3Mzc5ODI0IC0wNDAwDQpAQCAtMCwwICsxLDYgQEANCis8IURPQ1RZUEUgYnVzY29uZmlnIFBV
QkxJQyAiLS8vZnJlZWRlc2t0b3AvL0RURCBELUJVUyBCdXMgQ29uZmlndXJhdGlvbiAxLjAvL0VO
Ig0KKyAiaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvc3RhbmRhcmRzL2RidXMvMS4wL2J1c2Nv
bmZpZy5kdGQiPg0KKzxidXNjb25maWc+DQorICA8c2VsaW51eD4NCisgIDwvc2VsaW51eD4NCis8
L2J1c2NvbmZpZz4NCi0tLSAvZGV2L251bGwJMjAwNC0xMC0xNyAxMTo0MDowMC4yMjE3NTAxMDQg
LTA0MDANCisrKyBwb2xpY3ktMS4xNy4zMC90YXJnZXRlZC9hcHBjb25maWcvZGJ1c19jb250ZXh0
cwkyMDA0LTEwLTE3IDE5OjI2OjI5LjIwOTAwMTM1MiAtMDQwMA0KQEAgLTAsMCArMSw2IEBADQor
PCFET0NUWVBFIGJ1c2NvbmZpZyBQVUJMSUMgIi0vL2ZyZWVkZXNrdG9wLy9EVEQgRC1CVVMgQnVz
IENvbmZpZ3VyYXRpb24gMS4wLy9FTiINCisgImh0dHA6Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3N0
YW5kYXJkcy9kYnVzLzEuMC9idXNjb25maWcuZHRkIj4NCis8YnVzY29uZmlnPg0KKyAgPHNlbGlu
dXg+DQorICA8L3NlbGludXg+DQorPC9idXNjb25maWc+DQo=


--=-pGqWw/rn/bNT6ZUIynXF--

--=-MeLavRL9CkZf1KVlxh0I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcwBnOIkJWWp2WGURAkHYAJoDeb6kSbuYYObsDFC7agncmUVEmgCePl+J
1+EfmjozGgENfdLJ+GxDocI=
=Y0Gl
-----END PGP SIGNATURE-----

--=-MeLavRL9CkZf1KVlxh0I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
