Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OHPrRb012392
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 13:25:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4OHNOB2012871
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 17:23:24 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
	by jazzswing.ncsc.mil  with ESMTP id i4OHNMwk012858
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 17:23:23 GMT
Message-Id: <200405241725.i4OHPmRs008204@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
Subject: Re: [PATCH][RFC] Allow administrator control over per-user default_contexts 
In-Reply-To: Your message of "Mon, 24 May 2004 08:43:53 EDT."
             <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil> <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu> <200405240612.15645.russell@coker.com.au>
            <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_383906900P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 24 May 2004 13:25:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_383906900P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 May 2004 08:43:53 EDT, Stephen Smalley said:

> Sounds like Valdis may have misunderstood - the $1 corresponds to the
> user role/domain, not the user identity.

No, I was clear on that distinction (and was counting "domains" as being more
akin to group membership).  On the other hand, I've had the joy of running
larger systems back in the "old days" when NGROUPS_MAX was still 8 or 16 or
whatever it was for NFS back in SunOS 3.5/4.0 days, and I had literally a dozen
users pegged at the group limit (doesn't take long, when you have a 'cs_dept'
group, then a "these 3 CS profs and 1 EE prof", a "same EE prof and 2 guys from
Physics", and... you get the idea..).   One of our production machines (which
has end-user userids on it) currently has 314 users and 273 groups defined....

I've gotten burnt too many times when a user who's in multiple groups has
managed to screw things up with a 'chgrp' command (between the -R flag and file
globbing, chgrp and chmod are dangerous for users ;) - so there's a real
temptation to use roles to build a much higher wall between the contexts. And
using the one production machine as an example, it's not at all clear that
there is any really sensible halfway point between 300 people in 1 user_t
domain and 250 domains with single-digit numbers of users...


--==_Exmh_383906900P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAsjAccC3lWbTT17ARAiV5AKC+N5RGxjqmEffQA3M8UVkB96ljAgCgmuiZ
7MXOlBHt/ZtpGlXA7USTHMc=
=hyMC
-----END PGP SIGNATURE-----

--==_Exmh_383906900P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
