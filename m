Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KGOLrT005172
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:24:21 -0400 (EDT)
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KGOJQ4002024
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 16:24:20 GMT
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1ByCBg-0003iO-00
	for selinux@tycho.nsa.gov; Fri, 20 Aug 2004 18:24:20 +0200
Received: from pd9e419a7.dip.t-dialin.net ([217.228.25.167] helo=localhost)
	by mrelayng.kundenserver.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1ByCBf-00044W-00
	for selinux@tycho.nsa.gov; Fri, 20 Aug 2004 18:24:20 +0200
Date: Fri, 20 Aug 2004 18:24:21 +0200
From: Stefan SF <stefan@sf-net.com>
To: selinux@tycho.nsa.gov
Subject: Re: policy for scponly - need help
Message-ID: <20040820162421.GB15914@crux.sternplastic>
References: <BJENLMGHDPAAAGKKPOFOGEMHCEAA.richard.simpson@wgint.com> <1093009633.16585.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
In-Reply-To: <1093009633.16585.137.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> > allow user_t self:capability { dac_override dac_read_search };

Yes that's right. But how Walters mentioned before this is a security risk and I've read through his rssh-policy files and found a much cleaner way. I will post the policy in some days (cleanups will done).

thx, Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJiW1UEn3BeoPvtwRAuAlAJ9moKLqvXqqUPBMrQfQusYwkn+ZugCdG9wP
f0AemSC/GapqsVKEGylwFZY=
=tBok
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
