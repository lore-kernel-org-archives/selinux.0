Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QJ77rT028302
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 15:07:08 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QJ6576018815
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 19:06:06 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 21:07:03 +0200
Date: Sun, 26 Sep 2004 21:07:37 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: postfix, spamd, cupsd all attempting name_bind to 25, 893 etc. as "reserved_port_t"
Message-Id: <20040926190736.GA2529@jmh.mhn.de>
References: <20040926171824.GD28076@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <20040926171824.GD28076@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-09-26 20:31]:
> hi, i'm using the latest cvs from sf as policy.
>=20
> kernel 2.6.8.1-selinux1 also from cvs (last week).
>=20
> i get cups attempting to bind to port 631 as a "reserved_port_t",
> also postfix to 25 likewise
> and spamd_t to port 783 - again to reserved_port_t.
>=20
> i've made absolutely no changes to the strict policy.

You need to use checkpolicy from cvs if you want to use the cvs policy.
reserved_port_t as used in the latest policy is only supported by the
cvs checkpolicy.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVxN4xWIrrrL0q+cRAtctAJ9Ad/PgNhVB1QG3kgq9ecXvB2lbwQCgr7//
cd6SMgalBnPHQGUdEOvxPrU=
=Fex5
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
