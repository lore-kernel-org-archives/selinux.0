Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NGJCpP008105
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 12:19:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NGJCoN007572
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:19:12 GMT
Subject: Re: Selinux Sources
From: Thorsten Scherf <tscherf@redhat.com>
Reply-To: tscherf@redhat.com
To: Miguel Fernandes <esmiguelfc@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b5ba3cd0606230759t3fa8317frcd7c88fcef3830b5@mail.gmail.com>
References: <7b5ba3cd0606230706p7775ab9cx4dcc4ba1d70798c1@mail.gmail.com>
	 <1151073136.16104.3.camel@tiffy.tuxgeek.de>
	 <7b5ba3cd0606230759t3fa8317frcd7c88fcef3830b5@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h2hEmbn6Z5QqNk8Uz29m"
Date: Fri, 23 Jun 2006 18:19:04 +0200
Message-Id: <1151079545.16104.11.camel@tiffy.tuxgeek.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-h2hEmbn6Z5QqNk8Uz29m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 10:59 -0400, Miguel Fernandes wrote:
> Hi Thorsten, thanks for your quick reply,
>=20
> I'm trying to make the modification mention here:=20
> http://article.gmane.org/gmane.network.nagios.user/33586/match=3Dselinux
>=20
> But I don't know where to make the moditications recommended there
> because there are not such files on my distro. Any advice on this?
> Thanks!

The description is based on a monolithic, non-modular, policy. FC5 is
using a modular policy, which is based on the refpolicy.

Happy Day.
Thorsten

--=20
Thorsten Scherf <tscherf@redhat.com>
Red Hat GmbH

--=-h2hEmbn6Z5QqNk8Uz29m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnBR4wfkoLTuSgLsRAqqGAKDvQfm58b1LUjImh0YrPQJjYk4ndwCgk9v9
YOi55UUg6aavzHaxkSQ3UUc=
=fwIo
-----END PGP SIGNATURE-----

--=-h2hEmbn6Z5QqNk8Uz29m--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
