Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81KoGrT024682
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:50:16 -0400 (EDT)
Received: from mailgate.netsplit.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81KnQY2000405
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 20:49:27 GMT
Subject: Re: dpkg and selinux
From: Scott James Remnant <scott@netsplit.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
In-Reply-To: <20040901172551.GC4400@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net>
	 <1094004762.6901.68.camel@descent.netsplit.com>
	 <20040901101921.GC5882@lkcl.net>
	 <1094045403.6901.112.camel@descent.netsplit.com>
	 <20040901172551.GC4400@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d+nPsTX2Bfj33PKDA4rF"
Date: Wed, 01 Sep 2004 21:50:28 +0100
Message-Id: <1094071829.6901.149.camel@descent.netsplit.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-d+nPsTX2Bfj33PKDA4rF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 18:25 +0100, Luke Kenneth Casson Leighton wrote:

> On Wed, Sep 01, 2004 at 02:30:03PM +0100, Scott James Remnant wrote:
> > However I'm loath to embed specific selinux support into dpkg if it
> > introduces extra dependencies, or causes problems for those not using
> > it.
> =20
>  1) fortunately, the only extra dependency will be libselinux1 which
>     needs to be made "Required" such that cron, coreutils, logrotate,
> 	ssh etc. can use it.
>=20
That rules that solution out, then.  I'm not going to add a dpkg
dependency on libselinux until selinux is the default (over chown/chmod/
etc.)

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-d+nPsTX2Bfj33PKDA4rF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBNjYTIexP3IStZ2wRAoQyAJ44w0Oz6SUj2jgKcQUSnYPmnpB2zACfdBg7
FR3y5FA1ENGviWLMOLRzV8w=
=8Cg3
-----END PGP SIGNATURE-----

--=-d+nPsTX2Bfj33PKDA4rF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
