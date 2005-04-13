Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3DDsq7C009442
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 09:54:52 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3DDmX1i003979
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 13:48:33 GMT
Subject: Re: selinux-policy-targeted (1:1.22-2) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Dale Amon <amon@vnl.com>
Cc: Colin Walters <walters@verbum.org>, ubuntu-devel@lists.ubuntu.com,
   dwalsh@redhat.com, rcoker@redhat.com, selinux@tycho.nsa.gov,
   ubuntu-hardened@lists.ubuntu.com
In-Reply-To: <20050327120532.GC7660@vnl.com>
References: <1111884872.27644.228.camel@localhost.localdomain>
	 <1111887665.16952.22.camel@nexus.verbum.private>
	 <20050327120532.GC7660@vnl.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iX+gFIGw2hvLebM/YWU9"
Date: Wed, 13 Apr 2005 15:49:43 +0200
Message-Id: <1113400183.10363.94.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iX+gFIGw2hvLebM/YWU9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El dom, 27-03-2005 a las 13:05 +0100, Dale Amon escribi=F3:
> On Sat, Mar 26, 2005 at 08:41:05PM -0500, Colin Walters wrote:
> > I assume you mean this:
> >=20
> > +        print "Do you want $file:" . substr($line, 6);
> > +        print "Yes/No/Display [Y/n/d]? ";
> >=20
> > I suggest that you simply delete this code entirely, and install
> > every .te file.  It's outdated for several reasons:
> >
> > 3) It's always been annoying as hell :)
>=20
> Yeah, an automatic install/configurator project
> I was working on in spare time foundered on that
> ever changing reef of dependencies and name changes...

We don't need that in the targeted policy package, but it would make
sense as an independently packaged tool or included in the -strict
policy package.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-iX+gFIGw2hvLebM/YWU9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCXSN3DcEopW8rLewRAlbJAKCY2tfZUP6E8vKNH7gYyjAzDjNQhACeLZ1l
dMuuOJsgykK0wz3TMeeeT7Y=
=KmGk
-----END PGP SIGNATURE-----

--=-iX+gFIGw2hvLebM/YWU9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
