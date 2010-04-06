Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o36Dn1Jg010580
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2010 09:49:01 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o36DmX5L022023
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2010 13:48:34 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o36DmlOE079383
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2010 15:48:47 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o36DmXte032451
	for <selinux@tycho.nsa.gov>; Tue, 6 Apr 2010 15:48:34 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 6 Apr 2010 15:48:46 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: The confusing dot operator
Message-ID: <20100406134846.GO1518@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XlS4q8O07AKt4+K1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--XlS4q8O07AKt4+K1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I've been doing some MCS lately and I particularly started disliking the
dot range operator, as in 'c0.c1023'.

It seems to be an underdeveloped way of saying 'all categories' or
perhaps grouping them. I would welcome a 'star' operator that would do
the former and a more intelligent naming mechanism to express the latter
(ie. let's have a facility that can group 'dogs,cats,horses' as 'mammals'
and 'mammals,insects' as 'animals').

It imposes a range where there isn't. The range is in fact dependent on
the exact order of delaration. If you declare 'category c1; category c0;
category c2;' then 'c0.c2' does not include c1. If you use named cats
rather than c0-cN then even this little sense of range goes away.

Finally and most importantly sets of such 'consecutive' categories tend
to get 'range-ized' at numerous places. If a seuser is assigned to have
'dogs,cats,rats' then semanage will tell you he's got 'dogs.rats',
leaving you to figure out what's 'in between'.

What do the list members think about this?

Michal Svoboda

--XlS4q8O07AKt4+K1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAku7O74ACgkQg/fU9pp1uX6GuQCgqdZYI7hAE0R8/y3lEDCGsZ2n
kQEAn3PK2URr83CB360yk8Wkie0aSjay
=aG07
-----END PGP SIGNATURE-----

--XlS4q8O07AKt4+K1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
