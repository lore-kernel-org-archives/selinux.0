Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG8S7Ii028789
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 03:28:07 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG8QeAa010994
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:26:41 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 16 Nov 2004 09:28:09 +0100
Date: Tue, 16 Nov 2004 09:28:00 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: petre rodan <kaiowas@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: gentoo policy for stunnel
Message-Id: <20041116082800.GB2546@jmh.mhn.de>
References: <4198D4CA.3020708@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <4198D4CA.3020708@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* petre rodan <kaiowas@gentoo.org> [2004-11-15 17:51]:
>=20
> Hi,
>=20
> attached you'll find the policy we use for stunnel [1]
>=20
>=20
> type stunnel_port_t, port_type;

Are there any default ports for stunnel? If yes, can you provide a patch
to net_contexts? If no, it would be nice to have a line like "to use
stunnel for IMAP, add the following line to net_contexts..." and so on.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBmboQxWIrrrL0q+cRAlsrAJ9VX+76JdL9oRWaXwzvs6IzdFv7SgCgwzxe
PrDRGTz8PC8lucL+ATrcNbg=
=Qdbs
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
