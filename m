Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i921QprT006273
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 21:26:51 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i921Pj4L013949
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 01:25:45 GMT
Date: Fri, 1 Oct 2004 20:26:37 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
Message-ID: <20041002012637.GA28309@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain> <200410021059.57835.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <200410021059.57835.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 02, 2004 at 10:59:57AM +1000, Russell Coker wrote:
> Strange, I don't have any such problems with the Debian machines I have=
=20
> running Postfix.  What versions of Postfix and libc6?

Postfix is at 2.1.4-5, and libc6 is 2.3.2.ds1-17... both are current=20
according to "apt-cache policy postfix libc6".  I'm getting essentially=20
the same message for quite a few other daemons as well... I just picked=20
on postfix because it's the most obvious offender.


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXgPNgrEMyr8Cx2YRAqgoAKCqlO29NnlruqGGg5WtI3bOjiWYqgCfYOnv
9Z7hjoBHk/S0Ol9caRobOq4=
=2wrd
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
