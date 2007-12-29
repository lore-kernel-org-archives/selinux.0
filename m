Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBTI90cZ013241
	for <selinux@tycho.nsa.gov>; Sat, 29 Dec 2007 13:09:00 -0500
Received: from penguin.goodinassociates.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBTI8xtD024567
	for <selinux@tycho.nsa.gov>; Sat, 29 Dec 2007 18:08:59 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id lBTI8rWg027727
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 29 Dec 2007 12:08:53 -0600
Subject: RE: Kernel panic when using refpolicy
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A97PYTV9h/lkFBkEklP8"
Date: Sat, 29 Dec 2007 12:08:52 -0600
Message-Id: <1198951732.4073.992.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-A97PYTV9h/lkFBkEklP8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

sorry, to bring this up again, but FYI, it doesn't look like the kernel
bug got fixed in RHEL5U1. I took the most recent refpolicy and left the
type set to standard; make load; touch /.autorelabel;reboot; all hell
broke loose. however, if I set the type=3Dmcs then do the above everything
is fine. I had to pull the harddrive, and edit the policy config to get
the system back up.=20

-jj-




You have the capacity to learn from mistakes. You'll learn a lot today.

--=-A97PYTV9h/lkFBkEklP8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHdo006caZY8jbHDkRAnS0AKC3G3sHM/PaTnixtlg12lahmKgPowCgqm2U
4tFDQlvSsMg4vsOdpjB4UcI=
=fkvD
-----END PGP SIGNATURE-----

--=-A97PYTV9h/lkFBkEklP8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
