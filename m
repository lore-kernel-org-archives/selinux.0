Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JNWGrT014295
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 19:32:17 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JNWFNX013243
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 23:32:16 GMT
Subject: Re: [PATCH] Gentoo-specific initrc
From: Chris PeBenito <pebenito@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409200704.46291.russell@coker.com.au>
References: <1095381586.735.30.camel@gorn.pebenito.net>
	 <200409191801.05094.russell@coker.com.au>
	 <1095599331.735.62.camel@gorn.pebenito.net>
	 <200409200704.46291.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OalohR5b50WY/ltEPiy2"
Message-Id: <1095636681.735.70.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Sun, 19 Sep 2004 19:31:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OalohR5b50WY/ltEPiy2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-19 at 17:04, Russell Coker wrote:
> On Sun, 19 Sep 2004 23:08, Chris PeBenito <pebenito@gentoo.org> wrote:
> > > +allow initrc_t etc_runtime_t:dir read;
> > >
> > > Your patch doesn't include any .fc entries to label a directory as
> > > etc_runtime_t.
> >
> > This is going to appear in my types.fc patch.  The directory I'm
> > referring to is not specific to initrc.
>=20
> What is the purpose of a etc_runtime_t directory?  Currently any process =
that=20
> can create files as etc_runtime_t can write to a directory labelled as et=
c_t. =20

Good point, I'll send an updated patch when sourceforge cvs starts
responding again for me.  I guess I got a little overzealous on the
labeling.

> Are you planning to change that?

No, unless I can think of (or someone tells me) a reason to do that.

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

--=-OalohR5b50WY/ltEPiy2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBThbJvI7kLeavkkMRAmQfAJ9Oep6yFmM1MhuhzX4hxIEDx6g0aQCfX2tL
pBUfqkenIVATvs30n2EpNlk=
=sInY
-----END PGP SIGNATURE-----

--=-OalohR5b50WY/ltEPiy2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
