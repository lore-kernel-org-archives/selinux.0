Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BGIwrT006518
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 12:18:58 -0400 (EDT)
Received: from sccrmhc11.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5BGIu1j018319
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 12:18:56 -0400 (EDT)
Subject: Re: too many sysadmfile?
From: Chris PeBenito <pebenito@gentoo.org>
To: Valdis.Kletnieks@vt.edu
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200406091937.i59Jbpmq025810@turing-police.cc.vt.edu>
References: <1086800282.19414.26.camel@gorn.pebenito.net>
	 <200406091937.i59Jbpmq025810@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YmgzS08JQ02KiK0RQEyQ"
Message-Id: <1086970736.19414.134.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 11:18:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YmgzS08JQ02KiK0RQEyQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-09 at 14:37, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 09 Jun 2004 11:58:03 CDT, Chris PeBenito <pebenito@gentoo.org>  s=
aid:
> > In my
> > opinion, the packagers (rpm_t, etc) should be the only ones with access
> > all file_types.
>=20
> Well... yes... True in theory, but... ;)
>=20
> The other side of the coin is system manageability - let's say that rpm_t=
 is
> able to write all file types, but the admin can't.
>=20
> Now, assume you do this:   "rpm -Fvh prog1.rpm prog2.rpm". and that the t=
wo
> RPMs have pre-req chains  so you have to do both, and that create .rpmold=
 (or
> worse, .rpmnew) files when they install with diferent foo_t labels.
>=20
> How many times do you need to 'newrole' to deal with all the .rpmnew file=
s?

Its been a long time since I've used rpm, but where do these files
usually occur?  I'd think in /etc for the most part, where types would
be sysadminfiles.  Possible manageability problems is why I suggested
getting the full access back via a boolean.

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

--=-YmgzS08JQ02KiK0RQEyQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAydtwvI7kLeavkkMRAhN2AJ9j+qR8235b+54giZ3UztQLLZbdLQCfW56Y
gWOGGU4s8UD/fhlflu6Gc+k=
=q69H
-----END PGP SIGNATURE-----

--=-YmgzS08JQ02KiK0RQEyQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
