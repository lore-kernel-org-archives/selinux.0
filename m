Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3RKL8gA019688
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 16:21:08 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3RKKrES025486
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 20:20:54 GMT
Subject: Re: [RFC][PATCH 1/2] Further SELinux restrictions on mprotect
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   roland@redhat.com, mingo@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <426FC551.5030100@redhat.com>
References: <1114017480.8495.93.camel@localhost.localdomain>
	 <1114619778.4115.127.camel@moss-spartans.epoch.ncsc.mil>
	 <426FC551.5030100@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f+BAQ1xHaZp+Dl12RSwk"
Date: Wed, 27 Apr 2005 22:18:09 +0200
Message-Id: <1114633089.8548.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-f+BAQ1xHaZp+Dl12RSwk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 27-04-2005 a las 10:01 -0700, Ulrich Drepper escribi=F3:
> Stephen Smalley wrote:
> > What do others think about these additional permission checks,
> > particularly in terms of being able to practically apply them?  Has
> > anyone else experimented with them?
>=20
> I certainly like all the lockdown in this area we can get.  The other
> approaches to achieve this (i.e., pax) are simply unsuitable for a
> general OS release.  The fact that some programs need relaxed policies
> now doesn't mean this cannot be changed.

I agree, it's a matter of doing it well, and doing it simple, at least
from the users side.
That would ensure a future and wide deployment in an huge variety of
distributions (ie. Debian, Ubuntu...), and more important, in the
"Desktop world", generally.

> For instance, the X issue you saw is iirc changed upstream.  Maybe
> upstream =3D=3D R7, but I think the people are receptive.

I was looking around it, and seems that is patched right now.
I think it was also on RH's bugzilla, submitted by Ingo, but I dunno
certainly.

> As for the JVM, I have contacts at Sun and I'm sure they have an equal
> interest in making the JVM secure.

Good to know, personally I don't care much on Java but we must provide
support for the most possible wide range of users, and that would help a
lot.

> valgrind is a special tool, I'm not worried.

:)

Cheers and thanks for your comments,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-f+BAQ1xHaZp+Dl12RSwk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCb/OBDcEopW8rLewRAt/bAKDGZRY5GfDLzPnh68ofLPFxBuWEBwCfXpeG
8wnMNP6tzK3IfNuOf9gCWtY=
=OIwN
-----END PGP SIGNATURE-----

--=-f+BAQ1xHaZp+Dl12RSwk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
