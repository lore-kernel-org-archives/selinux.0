Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RLlmDo021515
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 16:47:48 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RLgDVe010633
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 21:42:13 GMT
Subject: Re: Compromise of SHA1 and SElinux
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: todd glassey <todd.glassey@worldnet.att.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <00d501c51cf1$651072c0$010aff0a@gw>
References: <1109400342.4581.25.camel@cobra.ivg2.net>
	 <20050227104528.GC28871@lkcl.net>  <00d501c51cf1$651072c0$010aff0a@gw>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P/o6t18bQDBpZSlKumOt"
Date: Sun, 27 Feb 2005 22:44:03 +0100
Message-Id: <1109540643.18747.73.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-P/o6t18bQDBpZSlKumOt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El dom, 27-02-2005 a las 09:16 -0800, todd glassey escribi=F3:
> Got a question for this list - the hash collision that was discussed by
> Rivest, Shamir, and Hoyt at RSA2005 is a serious one. Is there an initiat=
ive
> to upgrade SELinux tools to address these new liabilities in SHA1. Most
> folks are moving to SHA256 at minimum and to 512 if they can.

You seem confused around the SHA-1 "hash collision" discussed in
RSA2005, and also on the scope of SELinux, which AFAIK has nothing to do
with cryptography, at least when talking about the stuff available in
the public eye.Any crypto-related issue regarding Linux kernel code
should be pointed to the CryptoAPI folks.

On the SHA-1 collisions, as you can read at [1], collisions were found
in certain amounts of hash operations (SHA-1 2**69, SHA-0 2**39,
58-round SHA-1 2**33).I don't mean this is something to ignore, as
*recognized* experts in the subject have talked on it seriously, and
also I'm not someone really skilled in crypto terms, but, among that no
*real* public information has been made, *currently*, the scope of this
is *limited*.

Anyways, it's a matter of time to see *public* announcements about
weakening of other algorithms.The point is a bit complex on that terms,
just that people shouldn't scare when this information gets publicly
available, they should do so when thinking on *how much* information is
undisclosed and away of the public eye regarding these research efforts,
even for proper information security (in governments, etc) or for other
purposes (I would point at RSA SecurID embedded priv. keys, as an
example).

Moving to an algorithm *publicly* known as more secure won't help in the
game, as we won't know never if we are using something really secure.

In short, don't bother, don't scare, don't run away, just live with
it ;)

Cheers,
PS: I wonder on why I've started writing more than just something like
"This is not the right place for this" :)
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-P/o6t18bQDBpZSlKumOt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCIj8jDcEopW8rLewRAoXOAJ9wRCotOLFwTes7aY/o98+BT4G8bgCdGQ7X
cyUjKqpG5bwh9+UjqvVTz28=
=7ean
-----END PGP SIGNATURE-----

--=-P/o6t18bQDBpZSlKumOt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
