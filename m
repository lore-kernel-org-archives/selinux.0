Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i971E9rT010760
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 21:14:09 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i971E7co011029
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 01:14:08 GMT
Subject: libsepol+mls compile failure
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-niw0LLfxPwRlzKeVx/qB"
Date: Wed, 06 Oct 2004 21:12:55 -0400
Message-Id: <1097111576.31497.6.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-niw0LLfxPwRlzKeVx/qB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was going to try out MLS, but I get the following compile failure in
libsepol:

mls.c: In function `mls_compute_av':
mls.c:36: error: `policydb' undeclared (first use in this function)
mls.c:36: error: (Each undeclared identifier is reported only once
mls.c:36: error: for each function it appears in.)
mls.c: In function `mls_compute_context_len':
mls.c:84: error: `policydb' undeclared (first use in this function)
mls.c: In function `mls_sid_to_context':
mls.c:114: error: `policydb' undeclared (first use in this function)
mls.c: In function `mls_context_to_sid':
mls.c:230: error: `policydb' undeclared (first use in this function)

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


--=-niw0LLfxPwRlzKeVx/qB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBZJgXvI7kLeavkkMRAtqVAJwLGIcUXCGn85C2aQbs5eS8cqKWVgCbBKi4
RIn24gv57W8+lwdcpwCojCo=
=Pi84
-----END PGP SIGNATURE-----

--=-niw0LLfxPwRlzKeVx/qB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
