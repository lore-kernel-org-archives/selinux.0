Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3LNo4Rb027941
	for <selinux@tycho.nsa.gov>; Wed, 21 Apr 2004 19:50:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3LNlvW3022465
	for <selinux@tycho.nsa.gov>; Wed, 21 Apr 2004 23:47:57 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
	by jazzswing.ncsc.mil  with ESMTP id i3LNluIx022462
	for <selinux@tycho.nsa.gov>; Wed, 21 Apr 2004 23:47:56 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 22 Apr 2004 01:50:00 +0200
Date: Thu, 22 Apr 2004 01:50:40 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: arch archive of SELinux policy
Message-Id: <20040421235040.GC2255@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For those interested, I have made an arch[0] archive which contains=20
the SELinux policy. It is available at=20
http://www.cip.ifi.lmu.de/~bleher/arch/selinux/=20
(Archive name tbleher@gmx.de--selinux)

It contains several branches:
policy--snapshot--0: CVS mirror, I intend to updated this twice a week
policy--devo--0: my development branch, contains some policy not yet in CVS=
=20
policy--suse--0: experimental SuSE policy, not yet complete

I have used arch for a few weeks now to manage the policy on all of my
computers and found that it fits my workflow very well. Especially the merg=
ing
capabilities are very time-saving when doing development.  Another nifty
detail: Taglines[1] are used in the archive whenever possible. This allows =
arch
to automatically detect which files have moved.
Some additional notes and instructions can be found on my home page [2]

The archive is signed using my gpg-key.

Comments and suggestions welcome!

Thomas

--=20
[0] Information about arch: http://wiki.gnuarch.org/
[1] Info on taglines: http://wiki.gnuarch.org/moin.cgi/ID_2dtagging_20metho=
ds
[2] My SELinux pages: http://www.cip.ifi.lmu.de/~bleher/selinux/
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhwjQxWIrrrL0q+cRAiZWAJsEOUxKPENy4oi/8vlugrne65I/5gCggBoT
r7dI7vvQN0ratA42p5ySqkU=
=t564
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
