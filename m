Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2RD5rDo019933
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 08:05:53 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2RD5E7X029235
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 13:05:14 GMT
Subject: Re: selinux-policy-targeted (1:1.22-2) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Colin Walters <walters@verbum.org>
Cc: ubuntu-hardened@lists.ubuntu.com, rcoker@redhat.com, dwalsh@redhat.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1111887665.16952.22.camel@nexus.verbum.private>
References: <1111884872.27644.228.camel@localhost.localdomain>
	 <1111887665.16952.22.camel@nexus.verbum.private>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D4bE3HaHMb6czhd3npWC"
Date: Sun, 27 Mar 2005 15:04:46 +0200
Message-Id: <1111928686.27644.249.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-D4bE3HaHMb6czhd3npWC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El s=E1b, 26-03-2005 a las 20:41 -0500, Colin Walters escribi=F3:
> Very cool, I'm excited about this.

We'll see how well it works.
If not, then blame at me ;)

> I assume you mean this:
>=20
> +        print "Do you want $file:" . substr($line, 6);
> +        print "Yes/No/Display [Y/n/d]? ";
>=20
> I suggest that you simply delete this code entirely, and install
> every .te file.  It's outdated for several reasons:
>=20
> 1) With the new dynamic boolean support, SELinux enforcement for a
>    particular daemon can be turned off at runtime, instead of
>    at policy build time.
> 2) The targeted policy is significantly smaller than the strict, so
>    there are no space/size concerns. =20
> 3) It's always been annoying as hell :)

Done, I'm doing some improvements for the -3 revision.

Now I need to do other stuff, I'll upload the new package later.

Cheers and thanks for the help ;),
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-D4bE3HaHMb6czhd3npWC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRq9uDcEopW8rLewRAvf/AKC/Rl04C4nykkTUP0gQYVxJ4f5XpgCeOMwq
DmikfJ+yaOQdWHcUwsE6wZY=
=IRkL
-----END PGP SIGNATURE-----

--=-D4bE3HaHMb6czhd3npWC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
