Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59NTjrT023604
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 19:29:46 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i59NTeP2000983
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 19:29:41 -0400 (EDT)
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 01:29:42 +0200
Date: Thu, 10 Jun 2004 01:29:32 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-Id: <20040609232932.GD2142@jmh.mhn.de>
References: <20040609214126.GF5727@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
In-Reply-To: <20040609214126.GF5727@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-06-10 01:06]:
> hi,
>=20
> debian's postfix init.d script does a whole stackload of
> things like copy over /etc/localtime, /etc/services.
>=20
> it's rather scary.
>=20
> ... and it doesn't work.
>=20
> by disabling the chroot (setting SYNC_CHROOT=3D"") i managed
> to get postfix to start (and it works)
>=20
> i don't know if i was supposed to have these enabled

IIRC the consensus was that the chroot setup should be disabled. The
reasoning was that SELinux can provide better protection than a chroot
and it would just give postfix unnecessary permissions.

Thomas

BTW:
> 	allow postfix_cleanup_t postfix_cleanup_t:capability { sys_chroot };
You can write these as
        allow postfix_cleanup_t self:capability sys_chroot;
which makes it both shorter and easier to read.

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAx51cxWIrrrL0q+cRAj2OAJ9zAtCiDpxp7fmvg0UvmLOZMsNwlwCfd/kZ
DyIzS4RcTmp+k2eOQ9V6d2Q=
=oLVI
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
