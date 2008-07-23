Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6NLksdT028827
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 17:46:54 -0400
Received: from QMTA01.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6NLkg30000623
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 21:46:53 GMT
Subject: Re: [refpolicy patch] services: add a duplicate delimiter.
From: Chris PeBenito <pebenito@gentoo.org>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1216680555.30300.3.camel@sulphur.notebook.internal>
References: <1216680555.30300.3.camel@sulphur.notebook.internal>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MJMj//eXrOnCYXO9H3xI"
Date: Wed, 23 Jul 2008 17:46:23 -0400
Message-Id: <1216849583.5039.1.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MJMj//eXrOnCYXO9H3xI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-22 at 00:49 +0200, Dominick Grift wrote:
> This patch aims to add a duplicate delimiter.

This set is merged.  There was one error that would have been caught by
a compile test.  Please do a compile test before submitting, regardless
of how trivial the patch is.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-MJMj//eXrOnCYXO9H3xI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiHpq8ACgkQvI7kLeavkkOeFQCff/ECMbUGr9JoA9u6s2UP0gnD
vkUAn3JpKp/KhhRZsKE8YIts6Du3cx2y
=3o1p
-----END PGP SIGNATURE-----

--=-MJMj//eXrOnCYXO9H3xI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
