Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i941mfrT014876
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 21:48:41 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i941lXFo023334
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 01:47:34 GMT
Date: Sun, 3 Oct 2004 20:48:21 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041004014820.GA25896@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain> <200410040108.35839.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <200410040108.35839.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2004 at 01:08:35AM +1000, Russell Coker wrote:
> I've just run apol from setools and it tells me that no execute access is=
=20
> being granted.

Hmmm... unfortunately, I'm stumped at this point.  If I have some time=20
tomorrow I'll try out the 1.16 policy from the NSA website, and see if=20
it makes any difference.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBYKvkgrEMyr8Cx2YRAmTlAKCuUTEBSkGuAzfbmu/7mF7tvNvnYACeJkou
3JXo5SoTN2R4gJBwVwXFwE4=
=i6YM
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
