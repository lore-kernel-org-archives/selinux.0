Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HCrIrT016221
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 08:53:18 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HCrH8B028592
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 12:53:18 GMT
Subject: Re: gentoo merge for postfix
From: Chris PeBenito <pebenito@gentoo.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: petre rodan <kaiowas@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20041017111346.GA2537@jmh.mhn.de>
References: <417149C9.9010102@gentoo.org> <20041017111346.GA2537@jmh.mhn.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yaPYrUXT5L/jpM5RIKtL"
Date: Sun, 17 Oct 2004 08:52:20 -0400
Message-Id: <1098017540.6785.7.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yaPYrUXT5L/jpM5RIKtL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 13:13 +0200, Thomas Bleher wrote:
> * petre rodan <kaiowas@gentoo.org> [2004-10-17 00:55]:
> > can you please ifdef 'rhgb_domain(postfix_master_t)' since it's not par=
t of=20
> > some distros?
>=20
> I disagree. rhgb_domain() is a no-op if you don't use rhgb.te. Using
> additional ifdefs just makes the policy harder to read.

That is assuming rhgb_macros.te is included.  It is not included in
Gentoo's policy since we never use it.  I'm not going to add unneeded
files to fix something thats not properly ifdef'ed.

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


--=-yaPYrUXT5L/jpM5RIKtL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcmsEvI7kLeavkkMRAj/BAJ9+4UY4NlKoYeZMpUzecozumde40ACgm2ta
FSdTtYOxYe0HRsqAbqYCNik=
=pwJc
-----END PGP SIGNATURE-----

--=-yaPYrUXT5L/jpM5RIKtL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
