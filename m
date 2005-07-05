Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65JZlgA025539
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 15:35:47 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j65JXDSt003429
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 19:33:14 GMT
Subject: Re: Groups in the alternative user solution
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42CADC3F.8000206@redhat.com>
References: <20050630191417.26186.qmail@web31611.mail.mud.yahoo.com>
	 <42CADC3F.8000206@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZXx4Ia/pgGKHZDnB9nw2"
Date: Tue, 05 Jul 2005 15:33:51 -0400
Message-Id: <1120592032.16262.5.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZXx4Ia/pgGKHZDnB9nw2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-07-05 at 15:15 -0400, Daniel J Walsh wrote:

>=20
> This would potentially eliminate the 1000's of file contexts files proble=
m,
> since almost all users would map to the default user_r and user_home_t...
> for his home dir file context.

But isn't a large part of the point of this to ensure that e.g. grissom
can never access medical records stored in welby's home directory, even
if welby accidentally sets the DAC permissions to allow it?  Or is
something else in this scheme preventing that?


--=-ZXx4Ia/pgGKHZDnB9nw2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCyuCfOIkJWWp2WGURAm71AJwJ7eCM43CHcgEksWGembHVBMnlvwCfWpXp
TIwFjHqpwGoRu/hnh2AG+iQ=
=G/p6
-----END PGP SIGNATURE-----

--=-ZXx4Ia/pgGKHZDnB9nw2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
