Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG8GIIi028760
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 03:16:18 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG8GKFO003576
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:16:21 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 16 Nov 2004 09:16:19 +0100
Date: Tue, 16 Nov 2004 09:16:11 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: petre rodan <kaiowas@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for snmpd
Message-Id: <20041116081610.GA2546@jmh.mhn.de>
References: <4198D752.2020405@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <4198D752.2020405@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* petre rodan <kaiowas@gentoo.org> [2004-11-15 18:04]:
> gentoo as a special context for /proc/net:
> genfscon proc /net  system_u:object_r:proc_net_t

This seems generally useful.
Care to provide a patch which adds this genfscon line plus the necessary
policy?

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBmbdKxWIrrrL0q+cRAv1BAJ41y36vLxmwvq/uVJoS+JZEu/rlgwCfWjx5
xSYWfc/mZg8EhMf7skmNxXw=
=CkoN
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
