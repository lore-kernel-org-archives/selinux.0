Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RKkgDo021341
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 15:46:42 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RKhQjS013515
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 20:43:30 GMT
Subject: Re: missing features in user-land tools
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200502261846.55490.russell@coker.com.au>
References: <200502261846.55490.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wH+x8swOxnPx+82FRfdS"
Date: Sun, 27 Feb 2005 21:42:55 +0100
Message-Id: <1109536975.18747.55.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wH+x8swOxnPx+82FRfdS
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El s=E1b, 26-02-2005 a las 18:46 +1100, Russell Coker escribi=F3:
> I believe that for ideal functionality we want a program that will create=
 a=20
> file with a specified context.  It seems to me that modifying chcon would=
 be=20
> a good way of doing this as chcon already supports specifying the context=
 and=20
> the desired sym-link functionality.  Something like "chcon -n $CONTEXT $F=
ILE"=20
> with "-n" meaning that the file should be created if it doesn't exist (no=
t=20
> sure whether we would want chcon to abort if the file doesn't already exi=
st -=20
> maybe another option for that).
>=20
> The precedent for that is touch(1) which will change the time-stamp or cr=
eate=20
> the file if it doesn't exist.
>=20
>=20
> I think it would also be good if mktemp(1) was modified to allow specifyi=
ng=20
> the context of the file being created.  Often a script creates a temp fil=
e=20
> which will be written to by a program running in a different context.  Su=
re=20
> it could call chcon(1) after creating the temp file, but I think that hav=
ing=20
> mktemp do it all would be better.

I could work out something on mktemp, it seems not difficult, but I will
be able to do it after I finish the exams *sigh*.

Just lemme know how you want it (exactly) and what it needs to do among
setting a proper context to the temporal file being created.

Also, maybe a helper within libselinux could be interesting.I would like
to know what Stephen thinks at this point, if per-tool basis
modification with the whole code for context setting or a common helper
for those who share the same pattern.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-wH+x8swOxnPx+82FRfdS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCIjDPDcEopW8rLewRAmqwAJ0WztReQ/FQ3WdMFECuvqGmwwc7NwCgjJYD
/KJ31QXhKb9I79Iu+bvaHcc=
=X+/n
-----END PGP SIGNATURE-----

--=-wH+x8swOxnPx+82FRfdS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
