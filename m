Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7LLMaOb016651
	for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2005 17:22:36 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7LLCeqV001127
	for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2005 21:12:41 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 21 Aug 2005 23:12:40 +0200
Date: Sun, 21 Aug 2005 23:12:39 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: SuSE 10.0 packages
Message-Id: <20050821211238.GA7955@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

New SELinux packages for SuSE are available.
I was working on packages for 9.3, but after SuSE opened their
repositories in the form of opensuse.org I decided to rebase my work.
The packages are built against SUSE Linux 10.0 OSS Beta 2.
Only the most important packages are patched and I only tested in
permissive mode so far but it should be possible to get a functioning
SELinux system with these packages.
The packages are available on
http://www.cip.ifi.lmu.de/~bleher/selinux/suse/rpm-10.0/
If you look around you will also find packages for older versions of
SuSE.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDCO5GxWIrrrL0q+cRAs3JAJ4lZGZjC/LIFxZN/q8/5m2Mlubc4ACfZy3d
xYA5xyigrBqdQBgd8OtcaYU=
=QcCe
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
