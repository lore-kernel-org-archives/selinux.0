Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4A9M5Rb013570
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 05:22:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4A9M4YW024196
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 09:22:04 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
        by jazzband.ncsc.mil  with ESMTP id i4A9M3Bf024193 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 09:22:03 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 10 May 2004 11:22:01 +0200
Date: Mon, 10 May 2004 11:21:41 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Depend on CONFIG_AUDIT?
Message-Id: <20040510092141.GB2092@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just compiled a 2.6.6-rc3-mm3 kernel without CONFIG_AUDIT to see what
would happen. SELinux still seems to initialize but doesn't produce any
log messages. Since this is useless for most people I think SELinux
should depend on CONFIG_AUDIT.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAn0mlxWIrrrL0q+cRAsHlAJ4/Ik6lq23nDVhUt8ZGI8rZshXCZQCeLTiL
tCHPVGstSAKEhAdrjRlUimg=
=fV/5
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
