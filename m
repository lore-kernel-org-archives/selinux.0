Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o14HnDG3026387
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 12:49:14 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o14Hn3BS020152
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 17:49:04 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o14Hn2jW080788
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 18:49:02 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o14Hn1Y8088292
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 18:49:02 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 4 Feb 2010 18:49:01 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: MLS and network
Message-ID: <20100204174901.GL1750@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I've struck an interesting issue on stock fedora12. When you install the
MLS policy and then newrole yourself to s1 (or anything higher than s0),
you can still connect to the 'net (for example, ftp somewhere). I've
checked that the kernel is in enforcing mode.

This clearly violates the intent of MLS, as you could easily leak
confidential files this way. The question is which part is buggy? I've
looked briefly into the sources of the reference policy and it seems
that the necessary infrastructure is there: ports are labeled as s0, mls
constraints are in place and the domains of user processes do not have
mls exempts. That leaves things in a couple of options:

1) there is a bug in selinux or this feature is unsupported
2) fedora applies some patches to the policy which defeat the proper
   functioning
3) i have missed something

Any ideas?

Michal Svoboda


--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktrCI0ACgkQg/fU9pp1uX6LBwCeM8pTfuo4Kmyrr2CGdYN/VuAD
8XkAn1RYORWz7OdmqmknNS16bfv4k7Yu
=BLzW
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
