Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA12033
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 03:30:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA29659
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 07:29:14 GMT
Received: from ultraviolet.org (freeside.ultraviolet.org [192.215.175.10])
	by jazzswing.ncsc.mil  with SMTP id HAA29655
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 07:29:14 GMT
Date: Wed, 2 Oct 2002 00:30:04 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002003004.C28686@ultraviolet.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org> <20021001232715.A28686@ultraviolet.org> <20021002092056.A4475@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
In-Reply-To: <20021002092056.A4475@lemuria.org>; from tom@lemuria.org on Wed, Oct 02, 2002 at 09:20:56AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 09:20:56AM +0200, Tom spake thusly:
> That's just some symlinking, I believe.

Ah. Confusing. :)

> Welcome to SELinux. :)
> I guess this happens to everyone at least once.
>=20
> However, the (old) default policy worked fine for me and I don't think
> there have been so many critical changes. Anything uncommon you
> have, like raid, scsi, root filesystems on /dev/hdc7 or something?

I realized that I still have xdm running and logged in through that so I
was logged in as xdm_t and my username wasn't in the users file which of
course causes all sorts of problems.

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2aoHwACgkQ9PIYKZYVAq0aqQCbBv2DacKa6lB/ssIL8PAsoGOQ
ldMAn2r8TLa+zLO2VSY4HvAM7GvpWYGE
=/K/P
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
