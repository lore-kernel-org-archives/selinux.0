Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KGMKrT005143
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:22:21 -0400 (EDT)
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KGMEQ4001969
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 16:22:19 GMT
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1ByC9e-0002Lr-00
	for selinux@tycho.nsa.gov; Fri, 20 Aug 2004 18:22:14 +0200
Received: from pd9e419a7.dip.t-dialin.net ([217.228.25.167] helo=localhost)
	by mrelayng.kundenserver.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1ByC9e-0008S6-00
	for selinux@tycho.nsa.gov; Fri, 20 Aug 2004 18:22:14 +0200
Date: Fri, 20 Aug 2004 18:22:15 +0200
From: Stefan SF <stefan@sf-net.com>
To: selinux@tycho.nsa.gov
Subject: Re: policy for scponly - need help
Message-ID: <20040820162215.GA15914@crux.sternplastic>
References: <20040819173620.GA8543@crux.localdomain> <1092967183.29540.30.camel@nexus.verbum.private> <20040820080156.GA8602@crux.sternplastic> <1093009277.4336.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1093009277.4336.11.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Yeah that was it ;-)
Your documentation about the rssh had helped me a lot! I've now a scponly-chrootet user. I will do some policy-cleanups and post it to the list. Maybe someone can read through it and say if I had done some security risks!

Thank you very much indeed!

ciao, Stefan

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJiU3UEn3BeoPvtwRAo21AJ0ad0H7iG4oRHl5CESipQT/VXvjBgCfXoA6
CCPP7vnIjjn9SqofmVe/m7M=
=mZtd
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
