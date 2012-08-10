Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AB76A3021195
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 07:07:06 -0400
Date: Fri, 10 Aug 2012 13:06:39 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Re: Possible bug in finding default context?
Message-ID: <20120810110639.GD2296@telvanni>
References: <20120809174519.GE1643@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
In-Reply-To: <20120809174519.GE1643@telvanni>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 07:45:19PM +0200, Ole Kliemann wrote:
> Sometime ago I posted about a problem I had when building a=20
> monolithic policy. Login programs were unable to determine the=20
> default context of users when logging in, although i was pretty=20
> sure I did everything right. I never resolved that but didn't=20
> bother either since I started writing a new modular policy from=20
> scratch.
>=20
> Everything worked flawlessly, including logins, until suddenly=20
> now logins started to fail again with the login programs unable=20
> to determine the context of the user.
> =20
> Oh, what fresh hell is this?! So I started rolling back changes,=20
> and it turns out if there are too many types associated with one=20
> role and that role and one of its types is set as default context=20
> for a user, /bin/login gives 'Unable to get valid context'.
>=20
> BTW, the exact number seems 194. 194 types associated with one=20
> role works. 195 and it's broken.
>=20
> I'm doing this on Ubuntu 12.04, so it could be the crappily=20
> maintained selinux userland here.
>=20
> Ole

Workaround is to give each type his own role and then associate=20
all the roles with the user. This way around it works.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAk6z8ACgkQS1FjE303ERxQ9QCfVYFYXJcuAROfJ1U5BLtreKw4
boQAoIz2DEI7tVl8JOFcby+BSksWsrm3
=yfLZ
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
