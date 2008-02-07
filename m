Subject: Re: java threads
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202391931.27371.190.camel@moss-spartans.epoch.ncsc.mil>
References: <1202338588.2801.400.camel@bluejay.goodinassociates.com>
	 <1202391931.27371.190.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2SMKZNvUd8ghdGl9JoHy"
Date: Thu, 07 Feb 2008 09:02:09 -0600
Message-Id: <1202396529.2801.457.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2SMKZNvUd8ghdGl9JoHy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-02-07 at 08:45 -0500, Stephen Smalley wrote:
> On Wed, 2008-02-06 at 16:56 -0600, Jeremiah Jahn wrote:
> > what allows java to create a new thread? execmem? execstack? =09
>=20
> execmem/execstack are memory controls, not thread controls.

That's what I was thinking, but without allowing execmem, java can't
seem to start up a new thread. I know for the longest time, java on
Linux didn't use the standard thread API, so I thought that might be the
cause. I'm just curious to see if anyone knows why this seems to be
required for java to do it's thing with regards to threads.=20


>=20
"If I am elected, the concrete barriers around the WHITE HOUSE will be
replaced by tasteful foam replicas of ANN MARGARET!"

--=-2SMKZNvUd8ghdGl9JoHy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHqx1x6caZY8jbHDkRArI4AKCzoU7AQW5dNx2jl5uBEhLxsgfHCwCdEhEw
DV/UfTpKW+AlK9j0dsn4hjw=
=4Yjm
-----END PGP SIGNATURE-----

--=-2SMKZNvUd8ghdGl9JoHy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
