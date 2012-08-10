Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AHLPSo013306
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 13:21:25 -0400
Date: Fri, 10 Aug 2012 19:21:01 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Possible bug in finding default context?
Message-ID: <20120810172101.GJ2296@telvanni>
References: <20120809174519.GE1643@telvanni>
 <201208101913.03332.russell@coker.com.au>
 <20120810103704.GC2296@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
In-Reply-To: <20120810103704.GC2296@telvanni>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 12:37:04PM +0200, Ole Kliemann wrote:
> There are a few problems I ran into that I remember off the top=20
> of my head:
>=20
> Reference policy sources can be installed and compiled but not=20
> inserted due to missing dependencies.
>=20
> There's an null pointer dereference in libsemanage, something=20
> with genhomedircon, when trying to build a non-mcs policy. That's=20
> a know issue but unpatched in Ubuntu.
>=20
> The reference policy ubuntu's policy is based on is something=20
> from 2009. It doesn't have the
>=20
>     bool mmap_low_allowed false;
>=20
> As far as my limited understanding goes that isn't a problem=20
> unless you do something stupid anyways. (Like installing wine... =20
> vm.mmap_min_addr is set to 65536 by default on Ubuntu.)

To add to the this list:

There seem to be less utilities. I don't have 'seinfo' and don't=20
know any package to get it from.

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAlQv0ACgkQS1FjE303ERzb9ACfb7RFjTLjJBMQGr1p8P5Z1QFR
05UAn1vVfRqRiafjCF85VuvdZw1OjG8H
=jhSC
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
