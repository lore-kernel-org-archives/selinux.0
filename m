Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AN5drT022131
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 19:05:39 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AN5cl6022618
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 23:05:39 GMT
Subject: checkpolicy-1.16 multiple compile job fix
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oDy54INFR1x0elTP2K0D"
Message-Id: <1094857561.6513.66.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Fri, 10 Sep 2004 19:06:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oDy54INFR1x0elTP2K0D
Content-Type: multipart/mixed; boundary="=-V25fyXQilmqAVLQJi2lw"


--=-V25fyXQilmqAVLQJi2lw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here is a patch for the checkpolicy Makefile to fix a compile problem
with multiple compile jobs (make -j*).

One of the errors that was happening was:

policy_scan.l: In function `yylex':
policy_scan.l:48: error: `CLONE' undeclared (first use in this function)
policy_scan.l:48: error: (Each undeclared identifier is reported only
once
policy_scan.l:48: error: for each function it appears in.)
policy_scan.l:50: error: `COMMON' undeclared (first use in this
function)
[many more undeclared]


Another was:
policy_scan.l:23:19: y.tab.h: No such file or directory
make: *** [lex.yy.o] Error 1
make: *** Waiting for unfinished jobs....


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

--=-V25fyXQilmqAVLQJi2lw
Content-Disposition: attachment; filename=checkpolicy-1.16.diff
Content-Type: text/x-patch; name=checkpolicy-1.16.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGNoZWNrcG9saWN5LTEuMTYub3JpZy9NYWtlZmlsZQkyMDA0LTA4LTEzIDExOjA5OjI1LjAw
MDAwMDAwMCAtMDQwMA0KKysrIGNoZWNrcG9saWN5LTEuMTYvTWFrZWZpbGUJMjAwNC0wOS0xMCAx
Nzo0NTo1OS45MTgzMDAwMTYgLTA0MDANCkBAIC00OCw3ICs0OCw3IEBADQogeS50YWIuYzogcG9s
aWN5X3BhcnNlLnkNCiAJJChZQUNDKSAtZCBwb2xpY3lfcGFyc2UueQ0KIA0KLWxleC55eS5jOiBw
b2xpY3lfc2Nhbi5sDQorbGV4Lnl5LmM6IHBvbGljeV9zY2FuLmwgeS50YWIuYw0KIAkkKExFWCkg
cG9saWN5X3NjYW4ubA0KIA0KIHVzZXJzLnRhYi5jOiB1c2Vycy55DQo=

--=-V25fyXQilmqAVLQJi2lw--

--=-oDy54INFR1x0elTP2K0D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBQjNYvI7kLeavkkMRAmvaAJ9Kp0sJqjS/8KM6+iRXU21C4QFW8wCfdu43
96AQWl7vTeg3pTCRYSioBfs=
=vcoM
-----END PGP SIGNATURE-----

--=-oDy54INFR1x0elTP2K0D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
