Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TH6MXZ009785
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 13:06:23 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TH53Mb011952
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 17:05:04 GMT
Message-Id: <200410291706.i9TH6Fxx031799@turing-police.cc.vt.edu>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: make policy complains on file_contexts 
In-Reply-To: Your message of "Thu, 28 Oct 2004 16:24:05 EDT."
             <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
From: Valdis.Kletnieks@vt.edu
References: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1698560238P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 29 Oct 2004 13:06:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1698560238P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Oct 2004 16:24:05 EDT, Alex Ackerman said:

> Building file_contexts ...
> /usr/bin/checkpolicy -o policy.18 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> security:  6 users, 6 roles, 1204 types, 28 bools
> security:  53 classes, 265518 rules
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 18) to =
> policy.18
> Validating file_contexts ...
> /usr/sbin/setfiles -q -c policy.18 file_contexts/file_contexts
> /usr/sbin/setfiles:  invalid context system_u:object_r:user_eclipse_rw_t =
> on line number 898
> make: *** [policy.18] Error 1

Does a 'make reload' fix this?  A common cause of this is a "new" type that's
in the on-disk policy, but not in the in-memory version.  So the
new policy.18 is made, but when you run setfiles, user_eclipse_rw_t isn't
active yet....

--==_Exmh_-1698560238P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBgniGcC3lWbTT17ARAsAJAKCQhwv2U5a5ccRRg+KxbpdWWvXw4ACcD5Cp
jPPQ/s/k8H3wnDaAUZ9qCO4=
=6r6V
-----END PGP SIGNATURE-----

--==_Exmh_-1698560238P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
