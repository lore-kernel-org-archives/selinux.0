Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6NLqhbW029781
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 17:52:43 -0400
Received: from QMTA09.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6NLqXmM025142
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 21:52:38 GMT
Subject: Re: [refpolicy patch] retry add irssi module.
From: Chris PeBenito <pebenito@gentoo.org>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1216769485.3475.5.camel@sulphur.notebook.internal>
References: <1216769485.3475.5.camel@sulphur.notebook.internal>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VBsvPRWcHILYy2GH8NOW"
Date: Wed, 23 Jul 2008 17:52:19 -0400
Message-Id: <1216849939.5039.4.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VBsvPRWcHILYy2GH8NOW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-23 at 01:31 +0200, Dominick Grift wrote:
> Patch aims to add the irssi module. The irssi patch that i sent earlier
> was not complete.

Is there a reason why the irc module can't be updated to handle irssi?
Also, please submit patches relative to the top level of the policy
directory so they apply with patch -p0 or -p1.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-VBsvPRWcHILYy2GH8NOW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiHqBMACgkQvI7kLeavkkOzjgCdGJhuLuuRPnTHBT045yAiKa/G
otgAni2rIY33Uj8VtPPztLOpTFrP3Cjf
=TMyk
-----END PGP SIGNATURE-----

--=-VBsvPRWcHILYy2GH8NOW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
