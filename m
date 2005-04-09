Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j399HutA011324
	for <selinux@tycho.nsa.gov>; Sat, 9 Apr 2005 05:17:56 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j399CGmT003459
	for <selinux@tycho.nsa.gov>; Sat, 9 Apr 2005 09:12:17 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 9 Apr 2005 11:12:33 +0200
Date: Sat, 9 Apr 2005 11:12:25 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: cleanup old typealiases
Message-Id: <20050409091224.GA7820@thorium.jmh.mhn.de>
References: <20050409003446.GB7830@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <20050409003446.GB7830@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2005-04-09 02:52]:
> This patches cleans up a lot of old typealiases which are no longer used.

BTW, I just noticed that domains/misc/screensaver.te is still there, I
think it can be deleted.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCV5x4xWIrrrL0q+cRAjRGAJ44LvxflMiIwdUhjPcnzT7oFerS2wCdGycK
+3vTmrkApcKI6jEWIr6xbcI=
=2u69
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
