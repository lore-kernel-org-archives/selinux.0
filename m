Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i924bsrT007099
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:37:54 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i924brlM023428
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 04:37:54 GMT
Date: Fri, 1 Oct 2004 23:37:40 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041002043740.GA28765@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <200410021309.46413.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <200410021309.46413.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 02, 2004 at 01:09:46PM +1000, Russell Coker wrote:
> I have installed the same versions of libc6 and postfix as you but can no=
t=20
> reproduce this.
>=20
> Please show me the output of "ls -li /etc/ld.so.cache" on that machine.

1022 -rw-r--r--    1 root     root        11997 Sep 29 18:09 /etc/ld.so.cac=
he

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXjCUgrEMyr8Cx2YRAi9xAJ4lCY4KONd7qQ1qBM9oSNUcPC4nhQCgvnA8
DtG4g8Nnv6yUAqRBuvIAwzg=
=QntO
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
