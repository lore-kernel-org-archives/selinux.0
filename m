Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0Q3q8sj009551
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 22:52:10 -0500 (EST)
Received: from raq1.exo2.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0Q3q3ak003962
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2005 03:52:11 GMT
Received: from adelle.saharp.org (c-66-41-173-115.mn.client2.attbi.com [66.41.173.115])
	(authenticated)
	by raq1.exo2.net (8.10.2/8.10.2) with ESMTP id j0Q3pj304233
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 22:51:45 -0500
From: steven harp <steven.harp@adventiumlabs.org>
To: selinux@tycho.nsa.gov
Subject: users with weird names
Date: Tue, 25 Jan 2005 21:53:52 -0600
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200501252153.55866.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Failed to find this in the archives, but somebody must have
tripped across the problem of linux users with names that
are policy compiler keywords, e.g. Mr allow cannot be handled
by:

  user allow roles { staff_r };

rbac:108:ERROR 'syntax error' at token 'allow' on line 56248:

Same for Mr source and Ms. target, etc., all "ok" identifiers.
I am not trying to be perverse--somebody else picked several
names that will not parse.

And the correct way to quote them is.... ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFB9xRQPcFX9H2zuSkRApeOAJ9GfOq3vcDiZQOLfBaqrm9FDOGUbwCfav7Y
7wZKoe20yTsMgbaZRgbwfQ8=
=4mfm
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
