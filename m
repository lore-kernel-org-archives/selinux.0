Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j061oSIi006339
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 20:50:28 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j061mZFH015694
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 01:48:36 GMT
Subject: Re: Updated SELinux Release
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Colin Walters <walters@verbum.org>,
   Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <200501032353.12543.russell@coker.com.au>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1099667461.25416.27.camel@nexus.verbum.private>
	 <20041105155752.GC5565@lkcl.net>  <200501032353.12543.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZPfBL+i3jZoiyZM0ldhx"
Date: Mon, 03 Jan 2005 15:47:57 +0100
Message-Id: <1104763677.4281.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZPfBL+i3jZoiyZM0ldhx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Russell,

El lun, 03-01-2005 a las 23:53 +1100, Russell Coker escribi=F3:
> On Saturday 06 November 2004 02:57, Luke Kenneth Casson Leighton=20
> <lkcl@lkcl.net> wrote:
> >  debian doesn't GIVE users that choice [remember the adamantix
> >  bun-fight, anyone?] and instead settles for about the lowest possible
> >  common denominator - no consideration to modern security AT ALL!
>=20
> Doing the things that Adamantix does takes some work.  The Adamantix peop=
le=20
> are doing their own distribution and are not contributing to Debian.  The=
re=20
> are many Debian developers who want to see the same stuff included in Deb=
ian=20
> (including me), but no-one with the right combination of interest, time, =
and=20
> skills.
>=20
> If someone is looking for things to work on then it would be a good place=
 to=20
> start.

I think that Hardened Debian is putting many efforts in terms of
security technologies deployment.
We are now working on the deployment in Ubuntu Linux as a first move
before the possible deployment in Debian.

I'm now interested in making SELinux a really reliable solution thus i
have the other things almost done, and some kernel work is already done.

The debian policies should be improved and creation of a work team would
be great.

I have a blank page at the wiki
(http://wiki.debian-hardened.org/SELinux_on_Debian) which could be a
start point.

As i'm new and even i don't know what's the current state of SELinux
Debian deployment, i would appreciate any information.

I've set up a site (BTW, running on a hardened debian powered "box")
where i'm maintaining patches and other stuff i worked on related with
SELinux, it's at http://selinux.tuxedo-es.org .

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-ZPfBL+i3jZoiyZM0ldhx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB2VscDcEopW8rLewRAlQIAKCOTSiDm0GcyECFKZu4DGBrY2bifACgpkEn
zMQ8zFFU4q5p2GDunONGUXA=
=zLSV
-----END PGP SIGNATURE-----

--=-ZPfBL+i3jZoiyZM0ldhx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
