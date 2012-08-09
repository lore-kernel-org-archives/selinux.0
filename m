Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79HjcHF006598
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 13:45:38 -0400
Date: Thu, 9 Aug 2012 19:45:19 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Possible bug in finding default context?
Message-ID: <20120809174519.GE1643@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sometime ago I posted about a problem I had when building a=20
monolithic policy. Login programs were unable to determine the=20
default context of users when logging in, although i was pretty=20
sure I did everything right. I never resolved that but didn't=20
bother either since I started writing a new modular policy from=20
scratch.

Everything worked flawlessly, including logins, until suddenly=20
now logins started to fail again with the login programs unable=20
to determine the context of the user.
=20
Oh, what fresh hell is this?! So I started rolling back changes,=20
and it turns out if there are too many types associated with one=20
role and that role and one of its types is set as default context=20
for a user, /bin/login gives 'Unable to get valid context'.

BTW, the exact number seems 194. 194 types associated with one=20
role works. 195 and it's broken.

I'm doing this on Ubuntu 12.04, so it could be the crappily=20
maintained selinux userland here.

Ole

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAj9y8ACgkQS1FjE303ERyAHQCfRMbcRnnh8uW4Ab+GNFkOLEke
gVUAnR4AksGU/W0UhQhwEvy0hDtwKvby
=agCz
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
