Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KHkggA018633
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 13:46:43 -0400 (EDT)
Received: from kokytos.rz.ifi.lmu.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KHgEDg022781
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 17:42:15 GMT
Received: from minsk.cip.ifi.lmu.de (minsk.cip.ifi.lmu.de [141.84.214.166])
	by kokytos.rz.ifi.lmu.de (Postfix) with ESMTP id 9A9D0435E1
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 19:42:14 +0200 (CEST)
Date: Wed, 20 Jul 2005 12:35:43 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Dale Amon <amon@vnl.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Suse selinux policy
Message-ID: <20050720103541.GB8124@thorium.jmh.mhn.de>
References: <20050718234403.GA30685@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
In-Reply-To: <20050718234403.GA30685@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dale Amon <amon@vnl.com> [2005-07-19 02:03]:
> I have recently been doing some work on Suse and
> Sunday thought I'd play around with their version
> of selinux packages. However I failed to find their
> base policy package. Does anyone know what they call
> it and if it is present in a baseline SLES9?

I don't know about SLES9 but afaik most SuSE products don't contain a
policy package (I once saw one for an older version but it was very
outdated). From what I've heard SuSE favors AppArmor over SELinux so
it's unlikely they will support SELinux[1].
I have built packages for 9.2 and am currently building some for 9.3,
you can see the work I have done at
http://www.cip.ifi.lmu.de/~bleher/selinux/suse/s?rpm-9.{2,3}/
The policy at my site is rather old but if you want I can send you a
newer policy.

Thomas

[1] Please note that I am just a normal SuSE user with no internal
contacts at SuSE so take this with a grain of salt.

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC3ij9xWIrrrL0q+cRAmSBAKCavxDBhqholTuepj4gL6EgGfmYJACcDKfC
WNUHg6tS2gZdMFjnsC7Oc5c=
=TEb/
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
