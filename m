Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB6FKcIi021502
	for <selinux@tycho.nsa.gov>; Mon, 6 Dec 2004 10:20:38 -0500 (EST)
Subject: Re: SELinux port for 2.4.28 (and incoming backport from 2.6)
	released.
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1102342918.23475.70.camel@moss-spartans.epoch.ncsc.mil>
References: <1102192723.19001.19.camel@localhost>
	 <1102342918.23475.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LLmNCIuAQ/aJl90tQpNh"
Date: Mon, 06 Dec 2004 16:20:28 +0100
Message-Id: <1102346428.11450.2.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LLmNCIuAQ/aJl90tQpNh
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

El lun, 06-12-2004 a las 09:21 -0500, Stephen Smalley escribi=F3:
> On Sat, 2004-12-04 at 15:38, Lorenzo Hernandez Garcia-Hierro wrote:
> > I've not tested it yet, but hopefully works.
>=20
> For that kernel, you'll have to pass the -c 15 option to checkpolicy to
> tell it to build a version 15 policy, as the 2.4-based SELinux doesn't
> support newer policy versions.  Specifically, the 2.4-based SELinux was
> never updated for the conditional policy support (policy booleans), ipv6
> support, and fine-grained netlink classes.  See
> http://marc.theaimsgroup.com/?l=3Dselinux&m=3D107643944721568&w=3D2.

Yes, the conditional policy (v16) could be ported to it, as i have the
diff of the first release (2.6) that came with it, anyway, other stuff
could be hard to backport.

It would be great to have somewhere a SCM to see real diffs and the
evolution of the 2.6 brand, and the old 2.4 one, to compare what things
need to be backported and how to do it.

I will take a look in it later.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro [1024D/6F2B2DEC]
Hardened Debian head developer & project manager.
http://www.debian-hardened.org=20

--=-LLmNCIuAQ/aJl90tQpNh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtHi7DcEopW8rLewRAoMXAJ9dynu2F7rk8KxVQA1F/6Rqn6rOVQCg06bm
ez/9r6COZEnCoQMnZA9SdKc=
=wMy1
-----END PGP SIGNATURE-----

--=-LLmNCIuAQ/aJl90tQpNh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
