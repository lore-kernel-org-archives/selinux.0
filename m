Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1KJEBdW014595
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 14:14:11 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1KJ9pli028701
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 19:09:52 GMT
Subject: RE: Bell & Lapadula Model
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Juan Espino <jp_espino@hotmail.com>
Cc: mayerf@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <BAY19-F67BE31277B62F3C14864B846F0@phx.gbl>
References: <BAY19-F67BE31277B62F3C14864B846F0@phx.gbl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1nridniVdqskImdAq8OM"
Date: Sun, 20 Feb 2005 20:11:39 +0100
Message-Id: <1108926699.4100.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1nridniVdqskImdAq8OM
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El s=E1b, 19-02-2005 a las 17:29 +0000, Juan Espino escribi=F3:
> Wao, Thanks for your explanations.  SELinux supports more applications th=
an=20
> RSBAC =BF?

Both frameworks / security suite in SELinux case support an huge amount
of applications because this is independent of the framework/engine
itself, instead, both use policies that can be handled in a fine-grained
manner (most in SELinux case AFAIK).

Sample/default policies such as NSA SELinux policy available for
download from nsa.gov, make the installation easier, but the
administrator is the person in charge of maintaining a concrete policy
for his proper circumstances and case.
They provide the minimal config. to make applications to work as *they
are expected to do*, allowing only the default operations to make the
app. just working, but this differs in personal and concrete
circumstances as I commented above (ie. Fedora C3 & other RH's goodies
policies), so, fine-tuning is needed if the administrator wants to take
advantage of all the power that SELinux can provide.

It's a decision up to you whatever solution to use, just that I don't
want to enter in flames due to personal remarking, but I've used SELinux
more than RSBAC and I think that with a good policy and knowledge
(minimal I mean) on it, you can make even more profit than using RSBAC,
among that SELinux is used under critical environments and developed by
people who can't buy unexpected issues.

Anyways, both are great solutions, so, the decision is up to you.
RSBAC has an huge amount of documentation and well-explained models, and
the people maintaining it are also good guys that do good work.

I hope my comments could help you.
Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-1nridniVdqskImdAq8OM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCGODrDcEopW8rLewRAvAiAKDVSTxWI6eafjdFzP9Ya0FNpfiV1QCgw3OH
PwUxMITVeComKSpB9j7+VPU=
=D339
-----END PGP SIGNATURE-----

--=-1nridniVdqskImdAq8OM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
