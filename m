Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i64CiorT021481
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 08:44:50 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i64CiWD3018503
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 12:44:33 GMT
Date: Sun, 4 Jul 2004 07:44:36 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dnsmasq policy advice
Message-ID: <20040704124436.GA3976@yggdrasil.localdomain>
References: <20040703032852.GA23857@yggdrasil.localdomain> <200407031834.02192.russell@coker.com.au> <20040703153007.GA25813@yggdrasil.localdomain> <200407041502.59456.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <200407041502.59456.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 04, 2004 at 03:02:59PM +1000, Russell Coker wrote:
> I think that types/network.te is the best place.  Then we can have one fi=
le to=20
> handle all code related to multiple domains accessing the one port.

OK, that makes sense.

> > Also, I'm not sure why the "node_inaddr_any_t:udp_socket { node_bind }"
> > entry was removed.  This is definitely required in dnsmasq's default
>=20
> Doesn't can_network() cover that?

No... not in the selinux-policy-default 1:1.12-3 Debian package, at
least.  It doesn't appear to be present in your policy snapshot
either.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5/u0grEMyr8Cx2YRAjGYAJ9n3Yv+JN+dX7tCOLEoYo6CZqdzYACgnv9n
vJyFxPWVjDXq/ki3Ny1DN2A=
=ftwW
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
