Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0U0QoXf027909
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 19:26:51 -0500 (EST)
Received: from estila.tuxedo-es.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0U0Qm0a009596
	for <selinux@tycho.nsa.gov>; Mon, 30 Jan 2006 00:26:48 GMT
Subject: Re: labeling of compilers etc
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200601301003.17498.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
	 <1138572517.9012.27.camel@estila> <200601301003.17498.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6tNcoNGjN5h+60TiIk7o"
Date: Mon, 30 Jan 2006 01:26:46 +0100
Message-Id: <1138580807.9012.52.camel@estila>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6tNcoNGjN5h+60TiIk7o
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On lun, 2006-01-30 at 10:03 +1100, Russell Coker wrote:
> Limiting access to wget would also imply doing the same to lynx, links, f=
tp,=20
> ncftp, netcat, and many others.

Right.

> What do you consider to be the issues relating to tar etc?

I'm generally talking about binfmt/file parsing risks. 'tar' shouldn't
be able to do anything more than what it has been designed for.

Cheers,
--=20
Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-6tNcoNGjN5h+60TiIk7o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3V1GDcEopW8rLewRAoDDAJ4+FvEI9sdi+2ywoO3UjdPpKu0P+wCaAlUq
9zrVMs1oKZYSjTKy0JNL9PY=
=NFTD
-----END PGP SIGNATURE-----

--=-6tNcoNGjN5h+60TiIk7o--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
